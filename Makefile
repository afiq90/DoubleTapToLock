THEOS_DEVICE_IP = 192.168.1.3

INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e
# TARGET = iphone::12.0:latest

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = doubletaptolock

doubletaptolock_FILES = Tweak.x
doubletaptolock_CFLAGS = -fobjc-arc


include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += dtlpreferences
include $(THEOS_MAKE_PATH)/aggregate.mk
