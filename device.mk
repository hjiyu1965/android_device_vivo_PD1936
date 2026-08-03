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
    $(LOCAL_PATH)/recovery/root/system/bin/keystore_auth:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/keystore_auth \
    $(LOCAL_PATH)/recovery/root/system/bin/little_buddy:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/little_buddy \
    $(LOCAL_PATH)/recovery/root/system/bin/rec_bigdata:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/rec_bigdata \
    $(LOCAL_PATH)/recovery/root/system/bin/vivofbe:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/vivofbe \
    $(LOCAL_PATH)/recovery/root/system/bin/vivotool:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/vivotool \
    $(LOCAL_PATH)/recovery/root/system/bin/vts_app_recovery:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/vts_app_recovery \
    $(LOCAL_PATH)/recovery/root/system/bin/wait_for_keymaster:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/wait_for_keymaster

# FBE decryption chain - vendor/bin HAL services (from stock recovery.img)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/bin/qseecomd:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/bin/qseecomd \
    $(LOCAL_PATH)/recovery/root/vendor/bin/android.hardware.keymaster@4.0-service-qti:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/bin/android.hardware.keymaster@4.0-service-qti \
    $(LOCAL_PATH)/recovery/root/vendor/bin/android.hardware.gatekeeper@1.0-service-qti:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/bin/android.hardware.gatekeeper@1.0-service-qti \
    $(LOCAL_PATH)/recovery/root/vendor/bin/hw/android.hardware.health@2.0-service:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/bin/hw/android.hardware.health@2.0-service

# vivo proprietary libraries (NOT built from source by AOSP/TWRP)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/lib64/libGuardianAngleClient.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libGuardianAngleClient.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libGuardianAngleService.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libGuardianAngleService.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libGuardianAngleServiceImpl.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libGuardianAngleServiceImpl.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libvivofscrypt.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libvivofscrypt.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libvivogatekeeper.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libvivogatekeeper.so

# Keymaster / Keystore / FBE decryption libraries (from stock recovery.img)
# These are vivo/Qualcomm proprietary, NOT built from source by AOSP/TWRP
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/lib64/libkeymaster4_1support.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libkeymaster4_1support.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libkeymaster4support.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libkeymaster4support.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libkeymaster_messages.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libkeymaster_messages.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libkeymaster_portable.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libkeymaster_portable.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libkeymasterdeviceutils.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libkeymasterdeviceutils.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libkeymasterutils.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libkeymasterutils.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libkeystore-attestation-application-id.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libkeystore-attestation-application-id.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libkeystore_aidl.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libkeystore_aidl.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libkeystore_binder.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libkeystore_binder.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libkeystore_parcelables.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libkeystore_parcelables.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libkeyutils.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libkeyutils.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libqcbor.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libqcbor.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libqtikeymaster4.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libqtikeymaster4.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/librpmb.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/librpmb.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libsoft_attestation_cert.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libsoft_attestation_cert.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libsoftkeymasterdevice.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libsoftkeymasterdevice.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libminuivivo.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libminuivivo.so

# Qualcomm vendor proprietary libraries and firmware
# NOTE: HIDL interface libraries (vendor.display.config@1.0.so,
#       vendor.qti.hardware.tui_comm@1.0.so) are excluded because
#       they are built from source by hardware/qcom and cause conflicts.
#       All other vendor/lib64/ libraries are Qualcomm proprietary
#       and NOT present in the AOSP/TWRP source tree.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/etc/gpfspath_oem_config.xml:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/etc/gpfspath_oem_config.xml \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/TP-CONFIG-FW-PD1936-LCMID33-VER0x0028.bin:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/firmware/TP-CONFIG-FW-PD1936-LCMID33-VER0x0028.bin \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/TP-CONFIG-FW-PD1936-LCMID33-VER0x002C.bin:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/firmware/TP-CONFIG-FW-PD1936-LCMID33-VER0x002C.bin \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/TP-FW-PD1936-LCMID33-VER0x502100028.bin:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/firmware/TP-FW-PD1936-LCMID33-VER0x502100028.bin \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/TP-FW-PD1936-LCMID33-VER0x50213002C.bin:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/firmware/TP-FW-PD1936-LCMID33-VER0x50213002C.bin \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/bdwlan.bin.4g:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/firmware/bdwlan.bin.4g \
    $(LOCAL_PATH)/recovery/root/vendor/firmware/touch_firmwares_recovery.bin:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/firmware/touch_firmwares_recovery.bin \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/hw/android.hardware.gatekeeper@1.0-impl-qti.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/hw/android.hardware.gatekeeper@1.0-impl-qti.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libGPreqcancel.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libGPreqcancel.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libGPreqcancel_svc.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libGPreqcancel_svc.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libQSEEComAPI.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libQSEEComAPI.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libStDrvInt.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libStDrvInt.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdiag.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libdiag.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdrmfs.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libdrmfs.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdrmtime.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libdrmtime.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdsutils.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libdsutils.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libidl.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libidl.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libjson.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libjson.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libmdmdetect.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libmdmdetect.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libperipheral_client.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libperipheral_client.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqisl.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libqisl.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmi_cci.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libqmi_cci.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmi_client_qmux.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libqmi_client_qmux.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmi_common_so.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libqmi_common_so.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmi_csi.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libqmi_csi.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmi_encdec.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libqmi_encdec.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmiservices.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libqmiservices.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqrtr.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libqrtr.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqsocket.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libqsocket.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libsecureui.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libsecureui.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libsecureui_svcsock.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libsecureui_svcsock.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libspcom.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libspcom.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libssd.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libssd.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libssl.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libssl.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libtime_genoff.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libtime_genoff.so

# USB controller property (from boot cmdline: androidboot.usbcontroller=a600000.dwc3)
PRODUCT_PROPERTY_OVERRIDES += \
    sys.usb.controller=a600000.dwc3 \
    sys.usb.configfs=1
