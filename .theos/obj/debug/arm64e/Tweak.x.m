#line 1 "Tweak.x"


#define PLIST_PATH @"/var/mobile/Library/Preferences/com.afiq.dtlpreferences.plist"

static BOOL isEnabled;

static void loadPrefs() {
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
    isEnabled = [[prefs objectForKey:@"isEnabled"] boolValue];
}

@interface SpringBoard : UIApplication
- (void)_simulateLockButtonPress;
@end


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SpringBoard; @class SBIconListView; 
static void (*_logos_orig$_ungrouped$SBIconListView$touchesEnded$withEvent$)(_LOGOS_SELF_TYPE_NORMAL SBIconListView* _LOGOS_SELF_CONST, SEL, NSSet *, UIEvent *); static void _logos_method$_ungrouped$SBIconListView$touchesEnded$withEvent$(_LOGOS_SELF_TYPE_NORMAL SBIconListView* _LOGOS_SELF_CONST, SEL, NSSet *, UIEvent *); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SpringBoard(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SpringBoard"); } return _klass; }
#line 16 "Tweak.x"

  static void _logos_method$_ungrouped$SBIconListView$touchesEnded$withEvent$(_LOGOS_SELF_TYPE_NORMAL SBIconListView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSSet * touches, UIEvent * event) {
    if (isEnabled) {
      if ([[touches anyObject] tapCount] == 2) [(SpringBoard *)[_logos_static_class_lookup$SpringBoard() sharedApplication] _simulateLockButtonPress];
    } else {
      _logos_orig$_ungrouped$SBIconListView$touchesEnded$withEvent$(self, _cmd, touches, event);
    }
  }


static __attribute__((constructor)) void _logosLocalCtor_1477b421(int __unused argc, char __unused **argv, char __unused **envp){
    loadPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.afiq.dtlpreferences/ReloadPrefs"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}












static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBIconListView = objc_getClass("SBIconListView"); MSHookMessageEx(_logos_class$_ungrouped$SBIconListView, @selector(touchesEnded:withEvent:), (IMP)&_logos_method$_ungrouped$SBIconListView$touchesEnded$withEvent$, (IMP*)&_logos_orig$_ungrouped$SBIconListView$touchesEnded$withEvent$);} }
#line 42 "Tweak.x"
