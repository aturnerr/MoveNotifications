include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = movenotifications
movenotifications_FILES = mnpRootListController.m
movenotifications_INSTALL_PATH = /Library/PreferenceBundles
movenotifications_FRAMEWORKS = UIKit
movenotifications_PRIVATE_FRAMEWORKS = Preferences
$(BUNDLE_NAME)_EXTRA_FRAMEWORKS = Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/movenotifications.plist$(ECHO_END)
