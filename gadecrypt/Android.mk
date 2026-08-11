LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := gadecrypt
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_RELATIVE_PATH := system/bin
LOCAL_MULTILIB := first
LOCAL_SRC_FILES := gadecrypt.cpp
LOCAL_SHARED_LIBRARIES := libbinder libutils libc++
LOCAL_LDFLAGS += -L$(TARGET_RECOVERY_ROOT_OUT)/system/lib64 -lGuardianAngleClient
LOCAL_C_INCLUDES += $(TARGET_RECOVERY_ROOT_OUT)/../system/lib64
include $(BUILD_EXECUTABLE)
