// #import <Cephei/HBPreferences.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.afiq.dtlpreferences.plist"

static BOOL isEnabled;

static void loadPrefs() {
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
    isEnabled = [[prefs objectForKey:@"isEnabled"] boolValue];
}

@interface SpringBoard : UIApplication
- (void)_simulateLockButtonPress;
@end

%hook SBIconListView
  - (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isEnabled) {
      if ([[touches anyObject] tapCount] == 2) [(SpringBoard *)[%c(SpringBoard) sharedApplication] _simulateLockButtonPress];
    } else {
      %orig;
    }
  }
%end

%ctor{
    loadPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.afiq.dtlpreferences/ReloadPrefs"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}

// @interface SpringBoard : UIApplication
// - (void)_simulateLockButtonPress;
// @end

// %hook SBIconListView
//   - (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
// 	  NSLog(@"tapped");
//     if ([[touches anyObject] tapCount] == 2) [(SpringBoard *)[%c(SpringBoard) sharedApplication] _simulateLockButtonPress];
//   }
// %end

