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

# Device-specific binaries and libraries (extracted from stock recovery ramdisk)
# Only includes files NOT provided by TWRP/AOSP build system
# Categories: FBE decryption, Qualcomm vendor, vivo proprietary, touch firmware
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/bin/aria2c:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/aria2c \
    $(LOCAL_PATH)/recovery/root/system/bin/guardianangle:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/guardianangle \
    $(LOCAL_PATH)/recovery/root/system/bin/hwservicemanager:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/hwservicemanager \
    $(LOCAL_PATH)/recovery/root/system/bin/i2cdetect:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/i2cdetect \
    $(LOCAL_PATH)/recovery/root/system/bin/i2cdump:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/i2cdump \
    $(LOCAL_PATH)/recovery/root/system/bin/i2cget:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/i2cget \
    $(LOCAL_PATH)/recovery/root/system/bin/i2cset:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/i2cset \
    $(LOCAL_PATH)/recovery/root/system/bin/keystore:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/keystore \
    $(LOCAL_PATH)/recovery/root/system/bin/keystore_auth:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/keystore_auth \
    $(LOCAL_PATH)/recovery/root/system/bin/little_buddy:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/little_buddy \
    $(LOCAL_PATH)/recovery/root/system/bin/reboot:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/reboot \
    $(LOCAL_PATH)/recovery/root/system/bin/rec_bigdata:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/rec_bigdata \
    $(LOCAL_PATH)/recovery/root/system/bin/servicemanager:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/servicemanager \
    $(LOCAL_PATH)/recovery/root/system/bin/vivofbe:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/vivofbe \
    $(LOCAL_PATH)/recovery/root/system/bin/vivotool:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/vivotool \
    $(LOCAL_PATH)/recovery/root/system/bin/vts_app_recovery:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/vts_app_recovery \
    $(LOCAL_PATH)/recovery/root/system/bin/wait_for_keymaster:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/wait_for_keymaster \
    $(LOCAL_PATH)/recovery/root/system/bin/wget:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/bin/wget \
    $(LOCAL_PATH)/recovery/root/system/etc/security/otacerts.zip:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/etc/security/otacerts.zip \
    $(LOCAL_PATH)/recovery/root/system/etc/vintf/manifest.xml:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/etc/vintf/manifest.xml \
    $(LOCAL_PATH)/recovery/root/system/etc/vintf/manifest/manifest.xml:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/etc/vintf/manifest/manifest.xml \
    $(LOCAL_PATH)/recovery/root/system/lib64/android.hardware.confirmationui@1.0.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/android.hardware.confirmationui@1.0.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/android.hardware.gatekeeper@1.0.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/android.hardware.gatekeeper@1.0.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/android.hardware.keymaster@3.0.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/android.hardware.keymaster@3.0.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/android.hardware.keymaster@4.0.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/android.hardware.keymaster@4.0.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/android.hardware.keymaster@4.1.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/android.hardware.keymaster@4.1.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/android.hardware.weaver@1.0.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/android.hardware.weaver@1.0.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/android.hidl.token@1.0.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/android.hidl.token@1.0.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/android.system.suspend@1.0.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/android.system.suspend@1.0.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/android.system.wifi.keystore@1.0.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/android.system.wifi.keystore@1.0.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/hw/android.hardware.health@2.0-impl-default.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/hw/android.hardware.health@2.0-impl-default.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libGuardianAngleClient.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libGuardianAngleClient.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libGuardianAngleService.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libGuardianAngleService.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libGuardianAngleServiceImpl.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libGuardianAngleServiceImpl.so \
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
    $(LOCAL_PATH)/recovery/root/system/lib64/libminuivivo.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libminuivivo.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libqcbor.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libqcbor.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libqtikeymaster4.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libqtikeymaster4.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/librecovery_ui.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/librecovery_ui.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/librecovery_ui_ext.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/librecovery_ui_ext.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/librpmb.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/librpmb.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libsoft_attestation_cert.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libsoft_attestation_cert.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libsoftkeymasterdevice.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libsoftkeymasterdevice.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libvivofscrypt.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libvivofscrypt.so \
    $(LOCAL_PATH)/recovery/root/system/lib64/libvivogatekeeper.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/system/lib64/libvivogatekeeper.so \
    $(LOCAL_PATH)/recovery/root/vendor/bin/android.hardware.gatekeeper@1.0-service-qti:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/bin/android.hardware.gatekeeper@1.0-service-qti \
    $(LOCAL_PATH)/recovery/root/vendor/bin/android.hardware.keymaster@4.0-service-qti:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/bin/android.hardware.keymaster@4.0-service-qti \
    $(LOCAL_PATH)/recovery/root/vendor/bin/hw/android.hardware.boot@1.0-service:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/bin/hw/android.hardware.boot@1.0-service \
    $(LOCAL_PATH)/recovery/root/vendor/bin/hw/android.hardware.health@2.0-service:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/bin/hw/android.hardware.health@2.0-service \
    $(LOCAL_PATH)/recovery/root/vendor/bin/qseecomd:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/bin/qseecomd \
    $(LOCAL_PATH)/recovery/root/vendor/bin/vndservicemanager:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/bin/vndservicemanager \
    $(LOCAL_PATH)/recovery/root/vendor/etc/gpfspath_oem_config.xml:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/etc/gpfspath_oem_config.xml \
    $(LOCAL_PATH)/recovery/root/vendor/etc/vintf/compatibility_matrix.xml:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/etc/vintf/compatibility_matrix.xml \
    $(LOCAL_PATH)/recovery/root/vendor/etc/vintf/manifest.xml:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/etc/vintf/manifest.xml \
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
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libtime_genoff.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/libtime_genoff.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/vendor.display.config@1.0.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/vendor.display.config@1.0.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/vendor.qti.hardware.tui_comm@1.0.so:$(TARGET_COPY_OUT_RECOVERY_ROOT)/vendor/lib64/vendor.qti.hardware.tui_comm@1.0.so

# USB controller property (from boot cmdline: androidboot.usbcontroller=a600000.dwc3)
PRODUCT_PROPERTY_OVERRIDES += \
    sys.usb.controller=a600000.dwc3 \
    sys.usb.configfs=1
