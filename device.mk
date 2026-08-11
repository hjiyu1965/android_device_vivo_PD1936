#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/vivo/PD1936

# Init scripts and configuration files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/etc/fstab:$(TARGET_RECOVERY_ROOT_OUT)/etc/fstab \
    $(LOCAL_PATH)/recovery/root/etc/fstab:$(TARGET_RECOVERY_ROOT_OUT)/fstab.qcom \
    $(LOCAL_PATH)/recovery/root/init.recovery.platform.rc:$(TARGET_RECOVERY_ROOT_OUT)/init.recovery.platform.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.qcom.rc:$(TARGET_RECOVERY_ROOT_OUT)/init.recovery.qcom.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.svc.rc:$(TARGET_RECOVERY_ROOT_OUT)/init.recovery.svc.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.touch.rc:$(TARGET_RECOVERY_ROOT_OUT)/init.recovery.touch.rc \
    $(LOCAL_PATH)/recovery/root/ueventd.qcom.rc:$(TARGET_RECOVERY_ROOT_OUT)/ueventd.qcom.rc

# vivo proprietary binaries
# NOTE: wait_for_keymaster is built from source by AOSP/TWRP, do NOT copy as prebuilt
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/bin/vivofbe:$(TARGET_RECOVERY_ROOT_OUT)/system/bin/vivofbe \
    $(LOCAL_PATH)/recovery/root/system/bin/vivofbe_wrapper:$(TARGET_RECOVERY_ROOT_OUT)/system/bin/vivofbe_wrapper \
    $(LOCAL_PATH)/recovery/root/system/bin/vivotool:$(TARGET_RECOVERY_ROOT_OUT)/system/bin/vivotool \
    $(LOCAL_PATH)/recovery/root/system/bin/vts_app_recovery:$(TARGET_RECOVERY_ROOT_OUT)/system/bin/vts_app_recovery

# FBE decryption chain - vendor/bin HAL services
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/bin/qseecomd:$(TARGET_RECOVERY_ROOT_OUT)/vendor/bin/qseecomd \
    $(LOCAL_PATH)/recovery/root/vendor/bin/android.hardware.keymaster@4.0-service-qti:$(TARGET_RECOVERY_ROOT_OUT)/vendor/bin/android.hardware.keymaster@4.0-service-qti \
    $(LOCAL_PATH)/recovery/root/vendor/bin/android.hardware.gatekeeper@1.0-service-qti:$(TARGET_RECOVERY_ROOT_OUT)/vendor/bin/android.hardware.gatekeeper@1.0-service-qti

# vivo proprietary libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/lib64/libGuardianAngleClient.so:$(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libGuardianAngleClient.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libGuardianAngleService.so:$(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libGuardianAngleService.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libGuardianAngleServiceImpl.so:$(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libGuardianAngleServiceImpl.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libbigdata_utils.so:$(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libbigdata_utils.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libvivofscrypt.so:$(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libvivofscrypt.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libvivogatekeeper.so:$(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libvivogatekeeper.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libwifikeystorehalext.so:$(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libwifikeystorehalext.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libqcbor.so:$(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libqcbor.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libqtikeymaster4.so:$(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libqtikeymaster4.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libminuivivo.so:$(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libminuivivo.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libkeymasterdeviceutils.so:$(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libkeymasterdeviceutils.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/librpmb.so:$(TARGET_RECOVERY_ROOT_OUT)/system/lib64/librpmb.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libsqlite.so:$(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libsqlite.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libandroidicu.so:$(TARGET_RECOVERY_ROOT_OUT)/system/lib64/libandroidicu.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libkeymasterutils.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libkeymasterutils.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libion.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libion.so \

# Qualcomm vendor proprietary libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/etc/gpfspath_oem_config.xml:$(TARGET_RECOVERY_ROOT_OUT)/vendor/etc/gpfspath_oem_config.xml \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/hw/android.hardware.gatekeeper@1.0-impl-qti.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/hw/android.hardware.gatekeeper@1.0-impl-qti.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libGPreqcancel.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libGPreqcancel.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libGPreqcancel_svc.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libGPreqcancel_svc.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libQSEEComAPI.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libQSEEComAPI.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libStDrvInt.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libStDrvInt.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdiag.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libdiag.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdrmfs.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libdrmfs.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdrmtime.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libdrmtime.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdsutils.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libdsutils.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libidl.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libidl.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libjson.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libjson.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libmdmdetect.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libmdmdetect.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libperipheral_client.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libperipheral_client.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqisl.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libqisl.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmi_cci.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libqmi_cci.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmi_client_qmux.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libqmi_client_qmux.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmi_common_so.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libqmi_common_so.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmi_csi.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libqmi_csi.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmi_encdec.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libqmi_encdec.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmiservices.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libqmiservices.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqrtr.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libqrtr.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqsocket.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libqsocket.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libsecureui.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libsecureui.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libsecureui_svcsock.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libsecureui_svcsock.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libspcom.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libspcom.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libssd.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libssd.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libssl.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libssl.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libtime_genoff.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/libtime_genoff.so

# Touchscreen firmware
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/TP-CONFIG-FW-PD1936-LCMID33-VER0x0028.bin:$(TARGET_RECOVERY_ROOT_OUT)/vendor/firmware/TP-CONFIG-FW-PD1936-LCMID33-VER0x0028.bin \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/TP-CONFIG-FW-PD1936-LCMID33-VER0x002C.bin:$(TARGET_RECOVERY_ROOT_OUT)/vendor/firmware/TP-CONFIG-FW-PD1936-LCMID33-VER0x002C.bin \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/TP-FW-PD1936-LCMID33-VER0x502100028.bin:$(TARGET_RECOVERY_ROOT_OUT)/vendor/firmware/TP-FW-PD1936-LCMID33-VER0x502100028.bin \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/TP-FW-PD1936-LCMID33-VER0x50213002C.bin:$(TARGET_RECOVERY_ROOT_OUT)/vendor/firmware/TP-FW-PD1936-LCMID33-VER0x50213002C.bin \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/bdwlan.bin.4g:$(TARGET_RECOVERY_ROOT_OUT)/vendor/firmware/bdwlan.bin.4g \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/touch_firmwares_recovery.bin:$(TARGET_RECOVERY_ROOT_OUT)/vendor/firmware/touch_firmwares_recovery.bin

# Device properties for touchscreen firmware matching and FBE decryption
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.build.oem.projects=PD1936 PD1936B PD1936C PD1936D PD1936E PD1936G \
    ro.vivo.product.release.name=PD1936 \
    ro.product.board=msmnile \
    ro.board.platform=msmnile \
    ro.vivo.product.platform=SM8150 \
    ro.vivo.product.solution=QCOM \
    ro.vivo.hardware.version=PD1936MA \
    ro.board.bbk=MA \
    ro.vivo.board.version=MA \
    ro.build.expect.hardware=PD1936MA \
    ro.vivo.product.series=IQOO \
    ro.vivo.oem.support=yes \
    ro.minui.pixel_format=RGBX_8888 \
    vendor.gatekeeper.disable_spu=true

# USB controller and ADB
PRODUCT_PROPERTY_OVERRIDES += \
    sys.usb.controller=a600000.dwc3 \
    sys.usb.configfs=1 \
    persist.sys.usb.config=adb \
    ro.adb.secure=0

# VINTF manifest for keymaster/gatekeeper HAL registration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/etc/vintf/manifest.xml:$(TARGET_RECOVERY_ROOT_OUT)/vendor/etc/vintf/manifest.xml

# FBE decryption - QCOM TUI communication library (NOT built by AOSP)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/vendor.qti.hardware.tui_comm@1.0.so:$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib64/vendor.qti.hardware.tui_comm@1.0.so
