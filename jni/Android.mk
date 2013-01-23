# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_CFLAGS := "-I$(TI_MOBILE_SDK)/android/native/include" -I$(SYSROOT)/usr/include "-I/Users/ewing/Library/Application Support/Titanium/mobilesdk/osx/3.0.0.GA/android/native/include"
#LOCAL_CFLAGS += -Wno-conversion-null

# cf https://groups.google.com/forum/?fromgroups=#!topic/android-ndk/Q8ajOD37LR0
#LOCAL_CFLAGS += -Wno-psabi

LOCAL_MODULE    := hello-jni
#LOCAL_SRC_FILES := hello-jni.c example.c example_wrap_javascript_v8.cpp
LOCAL_SRC_FILES := hello-jni.c
#LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -ldl -llog -L$(TARGET_OUT) "-L/Users/ewing/Library/Application Support/Titanium/mobilesdk/osx/3.0.0.GA/android/native/libs/$(TARGET_ARCH_ABI)" -lkroll-v8
#LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -L$(TARGET_OUT) "-L$(TI_MOBILE_SDK)/android/native/libs/$(TARGET_ARCH_ABI)" -lkroll-v8

include $(BUILD_SHARED_LIBRARY)



########################################################################################################

include $(CLEAR_VARS)
ANDROID_NDK_ROOT=/Library/Frameworks/Android/android-ndk
TARGET_PLATFORM := android-14
LOCAL_MODULE     := openal
#LOCAL_ARM_MODE   := arm
MY_ROOT_DIR := /Users/ewing/Documents/Titanium_Studio_Workspace/ALmixer_Android
#LIBOPENAL_DIR    := $(MY_ROOT_DIR)/openal-soft-apportable/jni/OpenAL
LIBOPENAL_DIR    := openal-soft-apportable/jni/OpenAL
ABS_OPENAL_DIR := $(MY_ROOT_DIR)/$(LIBOPENAL_DIR)
LOCAL_C_INCLUDES := $(LIBOPENAL_DIR)/include $(LIBOPENAL_DIR)/OpenAL32/Include $(LIBOPENAL_DIR)/Alc \
	$(ABS_OPENAL_DIR)/include $(ABS_OPENAL_DIR)/OpenAL32/Include $(ABS_OPENAL_DIR)/Alc
	
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)       
#	LOCAL_C_INCLUDES += $(ANDROID_NDK_ROOT)/platforms/android-14/arch-arm/usr/include
endif

ifeq ($(TARGET_ARCH_ABI),armeabi)       
#	LOCAL_C_INCLUDES += $(ANDROID_NDK_ROOT)/platforms/android-14/arch-arm/usr/include
endif

ifeq ($(TARGET_ARCH_ABI),x86)       
#	LOCAL_C_INCLUDES += $(ANDROID_NDK_ROOT)/platforms/android-14/arch-arm/usr/include
endif

LOCAL_SRC_FILES  := $(LIBOPENAL_DIR)/OpenAL32/alAuxEffectSlot.c \
                    $(LIBOPENAL_DIR)/OpenAL32/alBuffer.c        \
                    $(LIBOPENAL_DIR)/OpenAL32/alDatabuffer.c    \
                    $(LIBOPENAL_DIR)/OpenAL32/alEffect.c        \
                    $(LIBOPENAL_DIR)/OpenAL32/alError.c         \
                    $(LIBOPENAL_DIR)/OpenAL32/alExtension.c     \
                    $(LIBOPENAL_DIR)/OpenAL32/alFilter.c        \
                    $(LIBOPENAL_DIR)/OpenAL32/alListener.c      \
                    $(LIBOPENAL_DIR)/OpenAL32/alSource.c        \
                    $(LIBOPENAL_DIR)/OpenAL32/alState.c         \
                    $(LIBOPENAL_DIR)/OpenAL32/alThunk.c         \
                    $(LIBOPENAL_DIR)/Alc/ALc.c                  \
                    $(LIBOPENAL_DIR)/Alc/alcConfig.c            \
                    $(LIBOPENAL_DIR)/Alc/alcEcho.c              \
                    $(LIBOPENAL_DIR)/Alc/alcModulator.c         \
                    $(LIBOPENAL_DIR)/Alc/alcReverb.c            \
                    $(LIBOPENAL_DIR)/Alc/alcRing.c              \
                    $(LIBOPENAL_DIR)/Alc/alcThread.c            \
                    $(LIBOPENAL_DIR)/Alc/ALu.c                  \
                    $(LIBOPENAL_DIR)/Alc/android.c              \
                    $(LIBOPENAL_DIR)/Alc/audiotrack.c           \
                    $(LIBOPENAL_DIR)/Alc/bs2b.c                 \
                    $(LIBOPENAL_DIR)/Alc/mixer.c                \
                    $(LIBOPENAL_DIR)/Alc/null.c                 \
                    $(LIBOPENAL_DIR)/Alc/panning.c              \
                    $(LIBOPENAL_DIR)/Alc/opensles.c             \

#LOCAL_CFLAGS     := -DAL_BUILD_LIBRARY -DAL_ALEXT_PROTOTYPES -DNDEBUG -DANDROID -DPOST_FROYO
LOCAL_CFLAGS     := -DAL_ALEXT_PROTOTYPES -DNDEBUG -DANDROID -DPOST_FROYO \
                    -fpic \
                    -ffunction-sections \
                    -funwind-tables \
                    -fstack-protector \
                    -fno-short-enums \
                    -DHAVE_GCC_VISIBILITY \
                    -O3

LOCAL_LDLIBS     := -llog -Wl,-s

ifeq ($(TARGET_ARCH_ABI),armeabi)
#	LOCAL_CFLAGS := $(LOCAL_CFLAGS) -DHAVE_NEON=0
#	LOCAL_CFLAGS += -marm -DOPENAL_FIXED_POINT -DOPENAL_FIXED_POINT_SHIFT=16
#	Not sure if fixed point really helps with armv7. It was originally for armv5/6. Need to benchmark.
	LOCAL_CFLAGS += -DOPENAL_FIXED_POINT -DOPENAL_FIXED_POINT_SHIFT=16
#	LOCAL_ARM_NEON  := true	
endif


MAX_SOURCES_LOW ?= 32
MAX_SOURCES_START ?= 32
MAX_SOURCES_HIGH ?= 32
LOCAL_CFLAGS += -DMAX_SOURCES_LOW=$(MAX_SOURCES_LOW) -DMAX_SOURCES_START=$(MAX_SOURCES_START) -DMAX_SOURCES_HIGH=$(MAX_SOURCES_HIGH)


include $(BUILD_SHARED_LIBRARY)

