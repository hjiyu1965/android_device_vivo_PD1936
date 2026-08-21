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

## Magisk 安装（vivo 块设备保护钩子的绕过）
- 现象：TWRP 刷 Magisk 报 "Unable to unpack boot image" + openat /dev/block/by-name/boot EACCES。
- 根因：vivo 内核拒绝【非 adbd 后代】进程打开块设备（recovery 域、su 域、路径白名单均无效，
  与 SELinux/路径/会话无关；adb shell 发起的进程可以）。
- 修复（bootable/recovery/orscmd/orscmd.cpp，commit 4bd2563）：
  twrp CLI（adbd 子进程）执行 install 时：
    1) dd boot 分区 -> /tmp/twrp_boot.img
    2) 重定向 /dev/block/by-name/boot -> 临时文件（安装器操作普通文件）
    3) 安装完成后恢复符号链接，若文件被修改则写回 boot 分区
- 用法：adb shell 'twrp install /cache/Magisk-v30.7.zip'（GUI 直接点安装仍会失败，
  必须走 twrp CLI；zip 放到 /cache 最稳，/data/media 的 FUSE 推送偶尔会损坏文件）。
- Magisk v30.7 已验证：unpack -> patch ramdisk -> repack -> 写回 boot，系统正常启动。

## 2026-08 格式化解密回归：真根因 = 密钥装入方式（keyring 路径）

### 现象
Format Data 后重新进 TWRP：显示"解密成功"但 /data/data、/data/system、/data/media/0
全是密文文件名；顶层 /data（无策略）正常。

### 根因链
1. Format Data 抹掉 /data/unencrypted/user_keys（系统不会自动重建 savior 副本）。
2. TWRP fscrypt_init_user0 发现 de/0 缺失 → create_and_install_user_keys 现场生成
   一对全新随机密钥写进去 → 第一次进 TWRP 失败，第二次"成功"但钥匙全错。
3. 更深层：即使换成真密钥，TWRP 仍乱码。对比 system 与 recovery 的 /proc/keys：
   - 系统（正常）：keyring "fscrypt"，4 个 fscrypt-p 类型 key，描述=策略 ref 裸 hex，
     payload 72B = struct fscrypt_key{mode=0, raw[64](wrapped), size=64}。
   - TWRP（乱码）：keyring "fscrypt-sda19"，1 个 ._fscrypt key，描述 6db0749fb1698fca
     （内核自算），与任何 v1 策略 ref 都不匹配。
   即 vivo 内核的 FS_IOC_ADD_ENCRYPTION_KEY 回移实现把 key 存到 v1 查找根本不会
   查询的位置；vold 实际走 add_key("fscrypt-p"|"logon", ...) 进会话 "fscrypt" ring。
   已验证 TWRP 的 keyref 计算（double-SHA512(wrapped[0:32])[0:8]）与策略 ref 一致
   （/data/unencrypted/ref = 0d14e27eef0cf3cb = fscryptpolicyget /data/adb）。

### 修复（twrp11/bootable/recovery/crypto/fscrypt/KeyUtil.cpp + BoardConfig）
- BoardConfig: TW_FORCE_LEGACY_FSCRYPT_KEYRING := true（Android.mk 转 -D）。
- isFsKeyringSupported() 强制返回 false → installKey 走 installKeyLegacy。
- installKeyLegacy：类型按序尝试 "fscrypt-p"、"logon"；描述加裸 hex ref
  （vold 的 key 描述就是裸 ref）；fscryptKeyring() 不存在时创建 "fscrypt" ring。
- payload 与 stock vold 反汇编结果一致：{mode=0, raw=wrapped 64B, size=64}（72B）。

### 防止再犯（FsCrypt.cpp）
- fscrypt_init_user0：de/0 缺失且 /data/system_de 存在（已初始化 FS）时拒绝现场造 key。
- fscrypt_init_user0 / read_and_install_user_ce_key：安装后用 fscrypt_policy_get_struct
  对比真实策略 ref（/data/system_de/0、/data/data），不匹配直接失败并提示跑 sync 脚本。

### 无 root 也能同步密钥
- vivo 的 adb shell 能读 root-only 目录（adbd 定制）：
  adb pull /data/misc/vold/user_keys 即可拿到标准格式明文 key（系统解锁状态下）。
- 再进 TWRP：rm -rf /data/unencrypted/user_keys/{ce,de} && adb push 回去。
- sync_fbe_keys.sh 需要 su；无 su 时用 pull/push 法。

### Format Data "In use by the system!"
- make_f2fs 以 O_EXCL 打开块设备，任何残留挂载（/emmc alias 等）都会让格式化失败。
- partition.cpp Wipe_Encryption：UnMount 后强制 detach（umount/umount2 MNT_DETACH）
  /emmc + /data，并记录 /proc/mounts 诊断。

## 2026-08 后续验证
- Format Data 修复实测通过（"In use by the system!" 不再出现）。
- 格式化后的标准流程：
  1) TWRP 格式化 /data
  2) 重启进系统完成初始化（让系统生成并"fixate"密钥、完成 keymaster 升级）
  3) 解锁屏幕后同步密钥（sync_fbe_keys.sh 需要 su；无 su 用 adb pull/push 法）
  4) 重启进 TWRP → 解密正常
- 注意：格式化后第一次进 TWRP 必然解密失败（无密钥副本，防护会拒绝造假密钥），
  这是预期行为，不是 bug。
- 若同步后仍失败：再完整进一次系统（完成 keymaster 密钥升级）后重新同步一次。
- magisk/fbe_key_sync.sh：Magisk service.d 自动同步脚本（root 持久化后可装到
  /data/adb/service.d/，实现开机自动同步，免手动步骤）。
  ⚠️ 本机 vivo 系统会自愈 boot 分区，Magisk 补丁会被还原，root 不稳定。

## 2026-08-21 最终突破：inlinecrypt 挂载参数（真正的根因）

### 现象
TWRP 显示"解密成功"、文件名正常，但**文件内容全部是密文**
（users/0.xml、keystore .metadata、照片……读出来都是乱码）。

### 根因
- vivo /data 挂载必须带 **inlinecrypt** 挂载参数（f2fs 内联加密 = ICE 硬件）。
  原厂 fstab.qcom：
  /dev/block/bootdevice/by-name/userdata /data f2fs noatime,nosuid,nodev,discard,
  reserve_root=32768,resgid=1065,fsync_mode=nobarrier,inlinecrypt
  latemount,wait,resize,check,formattable,fileencryption=ice,wrappedkey,...
- TWRP 挂载 /data 时没传 inlinecrypt → ICE 上下文不存在：
  - 内容加密无法由 ICE 硬件解密 → 文件内容乱码
  - add_key("fscrypt-p",...) 报 errno=19 ENODEV（fscrypt-p key 类型依赖 ICE 上下文）
- 文件名解密走软件 fscrypt（logon 型 key），所以一直"看起来正常"。
- 之前误判的"用户密钥目录自加密（savior 设计）"其实是**内容层 ICE 密文**！
  补上 inlinecrypt 后 /data/misc/vold/user_keys/de/0/version 直接读出 "1"。

### 修复
- recovery.fstab /data 行加 fsflags=noatime,nosuid,nodev,discard,reserve_root=32768,
  resgid=1065,fsync_mode=nobarrier,inlinecrypt。
- FsCrypt.cpp：user_key_dir 首选 /data/misc/vold/user_keys（原厂位置，系统开机后
  已 fixate 成标准格式），/data/unencrypted/user_keys 副本仅作回退。

### 结果：TWRP 完全自动解密
- 不需要任何同步脚本、不需要 root、不需要手工步骤。
- 唯一前提：格式化后进过一次系统（系统创建+fixate 密钥，这是密钥存在的前提）。
- 密钥链：systemwide key → 直接读 /data/misc/vold/user_keys/{de,ce} → 完整解密
  （文件名 + 内容全部明文，实测 users/0.xml 读出完整 XML）。
