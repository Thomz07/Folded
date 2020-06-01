ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Folded

Folded_FILES = $(wildcard *.m) #makes compiler include the other cells/pages of prefs
Folded_INSTALL_PATH = /Library/PreferenceBundles
Folded_FRAMEWORKS = UIKit
Folded_PRIVATE_FRAMEWORKS = Preferences
Folded_CFLAGS = -fobjc-arc
Folded_LDFLAGS += -lCSColorPicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Folded.plist$(ECHO_END)
