include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MoveNotifications
MoveNotifications_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += movenotifications
include $(THEOS_MAKE_PATH)/aggregate.mk
