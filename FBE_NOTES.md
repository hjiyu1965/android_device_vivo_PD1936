# vivo PD1936 (NEX 3 5G) TWRP FBE 解密 — 完整笔记

设备：vivo PD1936 (V1936A, NEX 3 5G)，SM8150/msmnile，Android 11 (SDK 30)，
kernel 4.14，非 A/B，f2fs + ICE 内联加密，fscrypt 策略 v1 + 硬件 wrappedkey。

## 最终状态：TWRP 全自动解密 ✅

- 进 TWRP 自动完整解密（文件名 + 文件内容全部明文），
  不需要任何同步脚本、root、或手动步骤。
- 唯一前提：格式化 /data 后开机进过一次系统
  （系统生成密钥 + 把 savior 格式整理成标准 vold 格式——密钥本身那时才存在）。

## 密钥链（已实测走通）

1. 系统级密钥（systemwide）：从 /data/unencrypted/key 读取（标准 vold 格式），
   经 keymaster 导出 64B hardware-wrapped key 装入内核。
2. 用户 DE/CE 密钥：直接从原厂位置 /data/misc/vold/user_keys/de|ce/0 读取
   （系统开机后已 fixate 成 version=1 标准格式）。
3. 内核 keyring：key 装入会话 fscrypt keyring（keyctl add_key，
   描述 = fscrypt:/ext4:/f2fs: + 16 位 hex ref）。

## 根因与修复清单（twrp11/bootable/recovery）

1. fscrypt v1 + wrapped key 强制
   - FsCrypt.cpp get_data_file_encryption_options：强制 version=1 +
     use_hw_wrapped_key=true。否则把 455B keymaster blob 当 raw key 传内核 → EINVAL。
2. keymaster -62 (KEY_REQUIRES_UPGRADE)：KeyStorage.cpp begin() 升级循环限 3 次重试。
3. 密钥装入路径（文件名乱码的根因）
   - vivo 内核的 FS_IOC_ADD_ENCRYPTION_KEY 回移实现会把 key 存到 v1 策略
     查找根本不会查询的位置 → 文件名全部乱码且“显示解密成功”。
   - 修复：TW_FORCE_LEGACY_FSCRYPT_KEYRING := true（BoardConfig/Android.mk），
     改走 add_key() 会话 keyring 路径（vold 同款）。keyref 计算
     double-SHA512(wrapped 前 32B) 前 8B 与 vivo 一致（反汇编 vold 确认）。
4. inlinecrypt 挂载参数（文件内容乱码的最终根因，最重要）
   - vivo /data 必须带 inlinecrypt 挂载（f2fs ICE 硬件加密开关）。
     TWRP 没传 → ICE 上下文缺失 → 文件内容全密文、add_key(fscrypt-p) 报
     ENODEV（errno 19）。文件名走软件 fscrypt，所以一直“看起来正常”。
   - 之前误判的“用户密钥目录自加密（savior 设计）”其实是内容层 ICE 密文。
   - 修复：fstab /data 行加 fsflags=noatime,nosuid,nodev,discard,
     reserve_root=32768,resgid=1065,fsync_mode=nobarrier,inlinecrypt
5. 直接读原厂密钥目录（免同步）
   - FsCrypt.cpp user_key_dir 首选 /data/misc/vold/user_keys；
     /data/unencrypted/user_keys 副本仅作回退（不再需要 sync_fbe_keys.sh）。
6. 防造假密钥：fscrypt_init_user0 在缺 de/0 且 /data/system_de 存在时
   拒绝现场生成密钥（否则生成随机密钥“成功”但全是乱码）。
7. 密钥校验：安装后用 fscrypt_policy_get_struct 对比磁盘策略 ref
   （/data/system_de/0、/data/data），不匹配直接失败。
8. Parse_Users：跳过非 '<' 开头的用户 XML（CE 密文），修复 GUI 死循环
   （1.5GB 日志 + Scudo OOM 重启）。
9. Format Data：Wipe_Encryption 在 make_f2fs 前强制 detach 所有挂载
   （修 In use by the system!）。
10. 备份/恢复：twrpTar/libtar 跳过 ENOKEY（密文名）条目。

## 用户操作流程

格式化 /data（TWRP）→ 重启进系统完成初始化 → 进 TWRP → 自动解密。

- 格式化后第一次进 TWRP 会提示解密失败（密钥还不存在）——预期行为。
- 设了锁屏 PIN 时：TWRP 走标准 PIN 输入 + synthetic password 流程
  （spblob 路径），暂未在新架构下完整回归。

## 诊断手段

- recovery.log 里的 vivo-dbg 行：每次 key 导出/安装的 ref、DE/CE 校验结果、
  add_key 失败原因（errno）。
- TWRP 内：fscryptpolicyget 目录 读磁盘策略 ref；
  od -An -tx1 /data/unencrypted/ref 读 TWRP 安装的 device key ref；
  cat /proc/keys 看 keyring 内容。
- 对照：系统解锁时 /proc/keys 显示 fscrypt ring + fscrypt-p 型 key。

## 构建与刷机

- 树：/home/hjiyu/twrp11（TWRP 3.7.0_11-0，bootable/recovery 改动）。
- 每次 make recoveryimage 前必须：
  1) rm -rf out/target/product/PD1936/recovery/root/etc
  2) make recoveryimage
  3) cp -f system/lib/*.so → recovery/root/system/lib/ 与 lib64 同理
     （RAMDISK 的 .so 不会自动刷新！）
  4) rm -f ramdisk-recovery.cpio recovery.img + 再 make recoveryimage
- 刷机：fastboot -S 256M flash recovery（-S 256M 必加，否则 vivo bootloader 拒绝）。
  fastboot boot 不支持。USB 枚举在 fastboot 模式下只有 Windows 侧可见：
  /mnt/f/Downloads/UotanToolbox_Windows_x64_3.6.1/Bin/platform-tools/fastboot.exe
- Linux adb：/home/hjiyu/android-sdk/platform-tools/adb。USB 连接易掉（几分钟一断），
  掉线时重插数据线即可。

## vivo 特有行为

- 内核拒绝非 adbd 后代进程打开块设备（SELinux/路径/域无关）。
  Magisk 安装走 twrp CLI（orscmd boot redirect：dd boot → 临时文件 → 装完写回）：
  adb shell 'twrp install /cache/Magisk-v30.7-vivo.zip'（GUI 直接装必失败）。
- adb shell（无 root）能读 root-only 目录（adbd 定制）。
- 系统侧 savior 目录（/data/misc/vold/savior/newest）在无用户密钥时
  名字可读、内容密文，不能作为 TWRP 引导密钥的入口。
- FUSE 数据（/data/media push）会损坏大文件；往手机放 zip 用 /cache 或 /data/local/tmp。

## 提交记录

twrp11（bootable/recovery，detached HEAD）：
- ac92e93 legacy keyring 密钥安装 + 防造假密钥 + Format Data 修复
- d9ab352 密钥安装诊断日志
- d0692c1 直接读原厂用户密钥 + add_key 失败日志
- 早期：3e57fce / 7fd8b2b / 7933f42 / 4bd2563 / b7b0147 / b2d8267 / c5b4ef4

device tree（github hjiyu1965/android_device_vivo_PD1936，branch twrp-11）：
- 77e6787 legacy keyring 开关 + 笔记
- 2cac684 同步脚本（已不再需要，仅存档）
- 9b27c67 inlinecrypt fstab 修复 + 本文档
