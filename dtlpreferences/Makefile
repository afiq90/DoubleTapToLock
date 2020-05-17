include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = dtlpreferences

dtlpreferences_FILES = DTLRootListController.m
dtlpreferences_INSTALL_PATH = /Library/PreferenceBundles
dtlpreferences_FRAMEWORKS = UIKit
dtlpreferences_PRIVATE_FRAMEWORKS = Preferences
dtlpreferences_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/dtlpreferences.plist$(ECHO_END)
