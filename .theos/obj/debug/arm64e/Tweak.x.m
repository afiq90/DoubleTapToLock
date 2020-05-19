#line 1 "Tweak.x"
#import <Cephei/HBPreferences.h>


@interface SBIconController: UIViewController
+(id)sharedInstance;
-(BOOL)isEditing;


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

@class SpringBoard; @class SBIconController; @class SBHomeScreenViewController; 
static void (*_logos_orig$_ungrouped$SBHomeScreenViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL SBHomeScreenViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBHomeScreenViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBHomeScreenViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBHomeScreenViewController$lockDevice(_LOGOS_SELF_TYPE_NORMAL SBHomeScreenViewController* _LOGOS_SELF_CONST, SEL); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBIconController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBIconController"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SpringBoard(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SpringBoard"); } return _klass; }
#line 23 "Tweak.x"


static void _logos_method$_ungrouped$SBHomeScreenViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBHomeScreenViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {

	_logos_orig$_ungrouped$SBHomeScreenViewController$viewDidLoad(self, _cmd);

	UIView *redRectangle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];

	UILabel *statusLabel = [[UILabel alloc] initWithFrame:redRectangle.frame];
	[statusLabel setTextColor:[UIColor blackColor]];

	if(tapGesture == nil) {
		tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lockDevice)];
		tapGesture.numberOfTapsRequired = 2;
		[self.view addGestureRecognizer: tapGesture];
	}

	
	
	
	
	
	
	
	
	
	
	

	NSLog(@"Am I enabled two? %i", isEnabled);
	
	if (isEnabled) {
		
		[redRectangle setBackgroundColor:[UIColor redColor]];
		statusLabel.text = @"ON";
	} else {
		
		[redRectangle setBackgroundColor:[UIColor greenColor]];
		statusLabel.text = @"OFf";
	}

	[redRectangle addSubview:statusLabel];
	[self.view addSubview:redRectangle];


}

 
static void _logos_method$_ungrouped$SBHomeScreenViewController$lockDevice(_LOGOS_SELF_TYPE_NORMAL SBHomeScreenViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	
	if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){.majorVersion = 13, .minorVersion = 0, .patchVersion = 0}]) {
		if(![[[_logos_static_class_lookup$SBIconController() sharedInstance] iconManager] isEditing]) {
			[(SpringBoard *)[_logos_static_class_lookup$SpringBoard() sharedApplication] _simulateLockButtonPress];
		}
	} else {
		if(![[_logos_static_class_lookup$SBIconController() sharedInstance] isEditing]) {
		     [(SpringBoard *)[_logos_static_class_lookup$SpringBoard() sharedApplication] _simulateLockButtonPress];
		}
	}
}



static __attribute__((constructor)) void _logosLocalCtor_a036efd8(int __unused argc, char __unused **argv, char __unused **envp) {
	prefs = [[HBPreferences alloc] initWithIdentifier:@"com.afiq.dtlpreferences"];
	[prefs registerBool:&isEnabled default:YES forKey:@"isEnabled"];
	{Class _logos_class$_ungrouped$SBHomeScreenViewController = objc_getClass("SBHomeScreenViewController"); MSHookMessageEx(_logos_class$_ungrouped$SBHomeScreenViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$SBHomeScreenViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$SBHomeScreenViewController$viewDidLoad);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBHomeScreenViewController, @selector(lockDevice), (IMP)&_logos_method$_ungrouped$SBHomeScreenViewController$lockDevice, _typeEncoding); }}
}
