# vivo PD1936 (NEX 3 5G) TWRP FBE 解密 — 逆向笔记

## 已验证并修复（twrp11 tree 已改，已刷机验证）
- **系统级密钥**：TWRP 必须走 v1 + hardware-wrapped 流程。
  - fstab 解析结果必须为 version=1 + use_hw_wrapped_key=true（否则把 455B blob 当 raw key → 内核 EINVAL）。
  - 已改：bootable/recovery/crypto/fscrypt/FsCrypt.cpp 强制这两项（带诊断日志）。
  - 验证：export 的 64B wrapped key 前 32B 稳定；keyref = abd764c3088d7d3d，与 stock 写入 /data/unencrypted/ref 的完全一致。
  - 系统级 key 装好后 /data/misc 可读（keystore DB、vold/user_keys、savior 都在里面）。
- 内核 ioctl 契约（已探明）：FS_IOC_ADD_ENCRYPTION_KEY = 0xC0506617，80B 头：
  key_spec@0(40B)、raw_size@40、key_id@44、reserved@48-75、flags@76(bit0=HW wrapped)、raw@80。
  内核只接受 raw_size <= 64（455B 必 EINVAL）。
- keymaster Begin/exportKey 会先返回 -62 (KEY_REQUIRES_UPGRADE)，需要 upgradeKey 后重试（TWRP 代码已处理）。
- 无密码设备密钥：/data/unencrypted/key 是标准 vold 格式（version="1", stretching="nopassword"）。

## 未解决：用户级 CE/DE 密钥（savior 私有格式）
- /data/misc/vold/user_keys/{ce,de}/0 存在，但格式私有：
  - ce/0/current/version = 0x23, de/0/version = 0xc8, savior/newest/de/0/version = 0x38；
  - stretching = 10 字节二进制；encrypted_key=483B(GCM), keymaster_key_blob=455B, secdiscardable=16KB。
- vivo recovery ramdisk 自带的 libvivofscrypt 也读不了（"Version mismatch, expected 1"）——官方 recovery 解密本来就不完整。
- 系统版 vold（/system/bin/vold，1.1MB，已拉到 sysbin/vold_system）里有 FsCryptSavior.cpp 子系统：
  - savior|fscrypt_init_user0 state/last code、savior|repair、savior|from_stash、
    vold.cryptfs.savior_code、savior|fscrypt_unlock_user_key miss km blob → 走 UserController(keystore)。
  - 即：用户密钥被 vivo"密码找回"(savior) 功能重包装过，二进制 version/stretching 是 savior 标记。
- 系统 vold 的 retrieveKey 对 device key 走标准 "1" 检查（0x5bdf8 处 compare "1"）；用户密钥走另一条 savior/UserController 路径。
- 手机有锁屏 PIN（系统 CE 锁定）。密码验证走 GuardianAngle（vivo TEE），不是标准 gatekeeper。
  （用户之前 commit 2bac1aa 做过 Decrypt.cpp 内联 GuardianAngle 的尝试。）
- vivofbe（vivo 官方工具）依赖 AOSP 格式 /etc/recovery.fstab（TWRP 格式解析不出 /data），
  且其 installKey 把 455B blob 当 raw 传（type=2 identifier）→ 内核 EINVAL → 官方工具在本机也不可用。

## 下一步候选路线（按性价比排序）
1. **让用户在系统里关掉 vivo 的"密码找回"功能**（设置→安全→密码/账号相关，或移除锁屏 PIN）。
   关闭/改密码会触发系统 vold 重包装密钥，version 可能回到标准 "1" + 文本 stretching → TWRP 标准流程即可读。
   之后只需补 GuardianAngle PIN 验证。
2. 逆向 sysbin/vold_system 的 savior 读取路径（FsCryptSavior + UserController/keystore SP），移植进 TWRP KeyStorage.cpp。
3. GuardianAngle 密码验证（用户已开始的 2bac1aa 方向）：libGuardianAngleClient/Service/Impl 已打包进 ramdisk，
   guardianangle 服务已随 recovery.service=1 启动。

## 环境备忘
- 构建树：/home/hjiyu/twrp11（bootable/recovery/crypto/fscrypt/ 有未提交改动：FsCrypt.cpp 修复+日志、
  KeyStorage.cpp 调试 dump、KeyUtil.cpp provisioning 非致命化、fbe_probe.cpp 诊断工具）。
- 诊断工具 fbe_probe：dlopen 调用 vivo retrieveKey 验证格式（twrp11 内 m fbe_probe 构建）。
- 系统侧参考二进制：workspace/sysbin/{vold_system,keystore_system}（从 stock system 拉取）。
- adb：Linux 侧 /home/hjiyu/android-sdk/platform-tools；Windows 侧 Uotan F:\Downloads\UotanToolbox...\Bin\platform-tools。
- 刷机：fastboot boot/flash recovery.img；手机进 TWRP：adb reboot recovery。

## ✅ 最终状态（全部打通）
- TWRP 完整解密成功：systemwide DE key → user DE key → user CE key（默认密码路径）。
- 验证：/data/media/0 全明文（DCIM/Pictures/Android...），df 显示 109G 用户数据正常挂载。

## 最终补丁清单（twrp11/bootable/recovery）
1. crypto/fscrypt/FsCrypt.cpp
   - get_data_file_encryption_options: 强制 version=1 + use_hw_wrapped_key=true（vivo wrappedkey v1 流程）。
   - user_key_dir 改为 /data/unencrypted/user_keys（读取系统 root 复制出的明文密钥副本）。
2. crypto/fscrypt/KeyStorage.cpp: begin() 升级循环加 3 次上限 + 日志（防 -62 死循环）。
3. partitionmanager.cpp Parse_Users: 用户 XML 非 '<' 开头（CE 密文）直接跳过，不解析、立即释放。
   这修复了 GUI 死循环（XML 解析失败无限刷新 → 1.5GB 日志 + Scudo OOM 256M → 重启）。
4. 用户密钥副本（关键前置步骤，root 系统上执行一次）：
   su -c 'mkdir -p /data/unencrypted/user_keys; cp -a /data/misc/vold/user_keys/. /data/unencrypted/user_keys/'
   ⚠️ 改锁屏密码后需要重新复制（密钥会重包装）。

## 刷机备忘
- fastboot flash 用 -S 256M（默认 sparse 块大小会被 vivo bootloader 拒绝：Invalid argument）。
- fastboot boot 不支持（unknown command），只能 flash recovery 分区。
- vivo 用户密钥目录自加密（savior 设计），无密钥时读到的 version 是密文字节，勿被误导。
- 系统侧旧格式密钥（version 0x23/0xc8）在系统启动时会被自动修复成标准格式（version="1"）。

## Commit 记录（twrp11/bootable/recovery，detached HEAD）
- 3e57fce vivo PD1936: FBE decryption fixes for hardware-wrapped v1 keys
- 7fd8b2b vivo PD1936: skip encrypted user XML in Parse_Users
- 7933f42 vivo PD1936: add fbe_probe diagnostics tool
（hex dump 调试日志已在提交前移除，避免把 wrapped key 写进日志）

## 密钥同步脚本
- sync_fbe_keys.sh（仓库根目录）：改锁屏密码/OTA 后在已解锁的系统上执行一次。
- 用法：手机开机进系统 → 解锁屏幕 → 电脑上运行 ./sync_fbe_keys.sh → adb reboot recovery。
