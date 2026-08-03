# Android device tree for vivo V1936A (PD1936)

TWRP device tree for vivo PD1936 (V1936A), based on Android 11 (API 30).

## 设备信息

| 项目 | 详情 |
|------|------|
| 设备代号 | PD1936 |
| 型号 | V1936A |
| 品牌 | vivo |
| 平台 | Qualcomm msmnile (SDM765G) |
| Android 版本 | 11 (RP1A.200720.012) |
| 固件版本 | PD1936_A_9.15.14 |
| 分区方案 | 非 A/B |
| 加密方式 | FBE (File-Based Encryption) + ICE |
| userdata 文件系统 | F2FS |

## 设备树特性

- FBE 文件级加密解密支持
- Qualcomm QSEE / Keymaster 4.0 / Gatekeeper 1.0 解密链
- vivo 专有解密: vivofbe, libvivofscrypt, libvivogatekeeper
- 预编译内核 (从原厂 recovery.img 提取)
- 触摸屏固件支持
- TWRP 11 兼容 (vendor/twrp)
- 中文默认语言

## 使用 GitHub Actions 编译

### 方法一: 在本仓库直接编译 (推荐)

1. 进入仓库的 **Actions** 页面
2. 选择 **Recovery Build** 工作流
3. 点击 **Run workflow**
4. 参数已预填好，直接点击 **Run workflow** 开始编译
5. 编译完成后在 **Releases** 页面下载 `recovery.img`

### 编译参数说明

| 参数 | 默认值 | 说明 |
|------|--------|------|
| MANIFEST_URL | minimal-manifest-twrp/platform_manifest_twrp_aosp | TWRP 源码 manifest |
| MANIFEST_BRANCH | twrp-11 | Android 11 对应分支 |
| DEVICE_TREE_URL | 本仓库地址 | 设备树仓库 |
| DEVICE_TREE_BRANCH | twrp-11 | 设备树分支 |
| DEVICE_PATH | device/vivo/PD1936 | 设备树在源码中的路径 |
| DEVICE_NAME | PD1936 | 设备代号 |
| MAKEFILE_NAME | twrp_PD1936 | 编译 makefile (twrp_ 或 omni_) |
| BUILD_TARGET | recovery | 编译目标 |

### 方法二: 使用 Action-TWRP-Builder

也可以 Fork [azwhikaru/Action-TWRP-Builder](https://github.com/azwhikaru/Action-TWRP-Builder) 仓库，填入本仓库地址进行编译。

## 本地编译

```bash
# 初始化 TWRP 11 源码
mkdir twrp-11 && cd twrp-11
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp -b twrp-11
repo sync -j$(nproc --all)

# 克隆设备树
git clone https://github.com/hjiyu1965/android_device_vivo_PD1936 -b twrp-11 device/vivo/PD1936

# 编译
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch twrp_PD1936-eng
make recoveryimage -j$(nproc --all)
```

编译产物路径: `out/target/product/PD1936/recovery.img`

## 刷入方法

```bash
# 进入 fastboot 模式
adb reboot bootloader

# 刷入 recovery
fastboot flash recovery recovery.img

# 重启进入 recovery
fastboot boot recovery.img
```

## 目录结构

```
PD1936/
├── .github/workflows/
│   └── Recovery Build.yml      # GitHub Actions 工作流
├── scripts/
│   └── convert.sh              # 依赖转换脚本
├── prebuilt/
│   ├── kernel                  # 预编译内核
│   ├── dtb.img                 # 设备树二进制
│   └── dtbo.img                # 设备树覆盖
├── recovery/root/
│   ├── init.recovery.*.rc      # recovery init 脚本
│   ├── system/                 # 系统二进制和库
│   └── vendor/                 # 供应商二进制和库
├── AndroidProducts.mk          # 产品定义
├── BoardConfig.mk              # 板级配置
├── device.mk                   # 设备配置
├── recovery.fstab              # 分区表
├── twrp_PD1936.mk              # TWRP 11 产品配置
├── omni_PD1936.mk              # Omni 产品配置
├── twrp.dependencies           # 依赖声明
└── proprietary-files.txt       # 专有文件清单
```

## 许可证

Apache-2.0
