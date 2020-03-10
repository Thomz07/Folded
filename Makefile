ARCHS = armv7 arm64 arm64e
THEOS_DEVICE_IP = 192.168.0.172 #This is my phone ip (Burrit0z)

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Folded

Folded_FILES = Tweak.xm
Folded_CFLAGS = -fobjc-arc
Folded_LDFLAGS += -lCSColorPicker

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += folded
include $(THEOS_MAKE_PATH)/aggregate.mk
