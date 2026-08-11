#!/usr/bin/env python3
"""Patch TWRP Android.mk to include gadecrypt build target"""
import os, sys

amd = 'bootable/recovery/crypto/fscrypt/Android.mk'
src = 'bootable/recovery/crypto/fscrypt/gadecrypt.cpp'

if not os.path.exists(src):
    print(f'gadecrypt source not found: {src}')
    sys.exit(1)

# Read original
with open(amd, 'r') as f:
    content = f.read()

# Add gadecrypt build rule before endif
insert = '''
# vivo GuardianAngle decrypt helper
include $(CLEAR_VARS)
LOCAL_MODULE := gadecrypt
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_RELATIVE_PATH := system/bin
LOCAL_SRC_FILES := gadecrypt.cpp
LOCAL_SHARED_LIBRARIES := libbinder libutils libc++
LOCAL_LDFLAGS += -lGuardianAngleClient
include $(BUILD_EXECUTABLE)
'''

old_end = '\nendif'
assert old_end in content, 'endif not found in Android.mk'

content = content.replace(old_end, insert + old_end, 1)

with open(amd, 'w') as f:
    f.write(content)

print('Android.mk patched for gadecrypt')
