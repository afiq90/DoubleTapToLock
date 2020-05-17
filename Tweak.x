#import <spawn.h>

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

%hook SBHomeScreenViewController
-(void)viewDidLoad {

	%orig;

	if(tapGesture == nil) {
		tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lockDevice)];
		tapGesture.numberOfTapsRequired = 2;
		[self.view addGestureRecognizer: tapGesture];
	}

	NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.afiq.dtlpreferences"];
	id isEnable = [bundleDefaults valueForKey:@"isEnable"];
	if ([isEnable isEqual:@0]) {
		tapGesture.enabled = NO;
		// [self lockDevice];
		
	} else {
		tapGesture.enabled = YES;
		// [self reSpring];
	}

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
