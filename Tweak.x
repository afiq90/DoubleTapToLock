#import <Cephei/HBPreferences.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.afiq.dtlpreferences.plist"

@interface SBIconController: UIViewController
+(id)sharedInstance;
-(BOOL)isEditing;

//iOS 13
-(id)iconManager;
@end

@interface SpringBoard : NSObject 
-(void)_simulateLockButtonPress;
@end

@interface SBHomeScreenViewController : UIViewController 
@end

UITapGestureRecognizer *tapGesture;
BOOL isEnabled;
HBPreferences *prefs;

static void loadPrefs() {
	NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:PLIST_PATH];
	// if(prefs) {
	// 	isEnabled = [[prefs objectForKey:@"isEnabled"] boolValue];
	// }
	isEnabled = [[prefs objectForKey:@"isEnabled"] boolValue];

}

%hook SBHomeScreenViewController

-(void)viewDidLoad {

	%orig;

	UIView *redRectangle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];

	UILabel *statusLabel = [[UILabel alloc] initWithFrame:redRectangle.frame];
	[statusLabel setTextColor:[UIColor blackColor]];

	if(tapGesture == nil) {
		tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lockDevice)];
		tapGesture.numberOfTapsRequired = 2;
		[self.view addGestureRecognizer:tapGesture];
	}

	// NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.afiq.dtlpreferences"];
	// id isEnable = [bundleDefaults valueForKey:@"isEnable"];
	// if ([isEnable isEqual:@0]) {
	// 	tapGesture.enabled = NO;
	// 	[redRectangle setBackgroundColor:[UIColor redColor]];
	// 	statusLabel.text = @"OFF";
	// } else {
	// 	tapGesture.enabled = YES;
	// 	[redRectangle setBackgroundColor:[UIColor greenColor]];
	// 	statusLabel.text = @"ON";
	// }

	NSLog(@"Am I enabled? %i", isEnabled);
	
	if (isEnabled) {
		tapGesture.enabled = YES;
		[redRectangle setBackgroundColor:[UIColor redColor]];
		statusLabel.text = @"ON";
	} else {
		tapGesture.enabled = NO;
		[redRectangle setBackgroundColor:[UIColor greenColor]];
		statusLabel.text = @"OFF";
	}

	[redRectangle addSubview:statusLabel];
	[self.view addSubview:redRectangle];


}

%new 
-(void)lockDevice {
	// check ios13?
	if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){.majorVersion = 13, .minorVersion = 0, .patchVersion = 0}]) {
		if(![[[%c(SBIconController) sharedInstance] iconManager] isEditing]) {
			[(SpringBoard *)[%c(SpringBoard) sharedApplication] _simulateLockButtonPress];
		}
	} else {
		if(![[%c(SBIconController) sharedInstance] isEditing]) {
		     [(SpringBoard *)[%c(SpringBoard) sharedApplication] _simulateLockButtonPress];
		}
	}
}

%end

%ctor {
	// prefs = [[HBPreferences alloc] initWithIdentifier:@"com.afiq.dtlpreferences"];
	// [prefs registerBool:&isEnabled default:YES forKey:@"isEnabled"];
	// %init;
	loadPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.afiq.dtlpreferences.ReloadPrefs"), NULL, CFNotificationSuspensionBehaviorCoalesce);

}