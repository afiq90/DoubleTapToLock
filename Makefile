THEOS_DEVICE_IP = 192.168.1.5

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = doubletaptolock

doubletaptolock_FILES = Tweak.x
doubletaptolock_CFLAGS = -fobjc-arc
doubletaptolock_EXTRA_FRAMEWORKS += Cephei


include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += dtlpreferences
include $(THEOS_MAKE_PATH)/aggregate.mk
