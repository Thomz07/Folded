ARCHS = armv7 arm64 arm64e

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Folded

Folded_FILES = Tweak.xm
Folded_CFLAGS = -fobjc-arc
Folded_LDFLAGS += -lCSColorPicker

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += folded
include $(THEOS_MAKE_PATH)/aggregate.mk
