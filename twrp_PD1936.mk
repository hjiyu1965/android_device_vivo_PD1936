#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from AOSP base (required for Android 11 / TWRP 11)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Inherit from TWRP common config
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from PD1936 device
$(call inherit-product, device/vivo/PD1936/device.mk)

# Device identifier
PRODUCT_DEVICE := PD1936
PRODUCT_NAME := twrp_PD1936
PRODUCT_BRAND := vivo
PRODUCT_MODEL := V1936A
PRODUCT_MANUFACTURER := vivo

PRODUCT_GMS_CLIENTID_BASE := android-vivo

# Android 11 API level
PRODUCT_SHIPPING_API_LEVEL := 30

# Build fingerprint (from stock firmware PD1936_A_9.15.14)
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="PD1936-user 11 RP1A.200720.012 compiler0714182446 release-keys"

BUILD_FINGERPRINT := vivo/PD1936/PD1936:11/RP1A.200720.012/compiler0714182446:user/release-keys
