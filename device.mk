#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/vivo/PD1936

# Init scripts and configuration files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/etc/recovery.fstab \
    $(LOCAL_PATH)/recovery/root/init.recovery.platform.rc:$(TARGET_COPY_OUT_RECOVERY_ROOT)/init.recovery.platform.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.qcom.rc:$(TARGET_COPY_OUT_RECOVERY_ROOT)/init.recovery.qcom.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.svc.rc:$(TARGET_COPY_OUT_RECOVERY_ROOT)/init.recovery.svc.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.touch.rc:$(TARGET_COPY_OUT_RECOVERY_ROOT)/init.recovery.touch.rc \
    $(LOCAL_PATH)/recovery/root/ueventd.qcom.rc:$(TARGET_COPY_OUT_RECOVERY_ROOT)/ueventd.qcom.rc

# vivo proprietary binaries (NOT built from source by AOSP/TWRP)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/bin/aria2c:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/aria2c \
    $(LOCAL_PATH)/recovery/root/system/bin/guardianangle:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/guardianangle \
    $(LOCAL_PATH)/recovery/root/system/bin/little_buddy:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/little_buddy \
    $(LOCAL_PATH)/recovery/root/system/bin/rec_bigdata:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/rec_bigdata \
    $(LOCAL_PATH)/recovery/root/system/bin/vivofbe:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/vivofbe \
    $(LOCAL_PATH)/recovery/root/system/bin/vivotool:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/vivotool \
    $(LOCAL_PATH)/recovery/root/system/bin/vts_app_recovery:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/vts_app_recovery

# vivo proprietary libraries (NOT built from source by AOSP/TWRP)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/lib64/libGuardianAngleClient.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libGuardianAngleClient.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libGuardianAngleService.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libGuardianAngleService.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libGuardianAngleServiceImpl.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libGuardianAngleServiceImpl.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libvivofscrypt.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libvivofscrypt.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libvivogatekeeper.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libvivogatekeeper.so

# Qualcomm vendor proprietary config and firmware only
# NOTE: All vendor/lib64/ libraries are built from source by AOSP/TWRP
# (hardware/qcom/sm7250, device/qcom/common, etc.)
# Only firmware and config files are kept as prebuilts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/etc/gpfspath_oem_config.xml:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/etc/gpfspath_oem_config.xml \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/TP-CONFIG-FW-PD1936-LCMID33-VER0x0028.bin:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/firmware/TP-CONFIG-FW-PD1936-LCMID33-VER0x0028.bin \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/TP-CONFIG-FW-PD1936-LCMID33-VER0x002C.bin:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/firmware/TP-CONFIG-FW-PD1936-LCMID33-VER0x002C.bin \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/TP-FW-PD1936-LCMID33-VER0x502100028.bin:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/firmware/TP-FW-PD1936-LCMID33-VER0x502100028.bin \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/TP-FW-PD1936-LCMID33-VER0x50213002C.bin:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/firmware/TP-FW-PD1936-LCMID33-VER0x50213002C.bin \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/bdwlan.bin.4g:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/firmware/bdwlan.bin.4g \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/touch_firmwares_recovery.bin:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/firmware/touch_firmwares_recovery.bin

# USB controller property (from boot cmdline: androidboot.usbcontroller=a600000.dwc3)
PRODUCT_PROPERTY_OVERRIDES += \
    sys.usb.controller=a600000.dwc3 \
    sys.usb.configfs=1
