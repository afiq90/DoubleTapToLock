#include "DTLRootListController.h"
#import <spawn.h>
#import <Preferences/PSSpecifier.h>

@implementation DTLRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)respringDevice{
	if (@available(iOS 11, *)){
		pid_t pid;
    	const char* args[] = {"sbreload", NULL};
    	posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)args, NULL);
	} else {
		pid_t pid;
    	const char* args[] = {"killall", "backboardd", NULL};
    	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
	}
}

-(id) readPreferenceValue:(PSSpecifier *)specifier {
		NSDictionary *prefsPlist = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", [specifier.properties objectForKey:@"defaults"]]];
		if (![prefsPlist objectForKey:[specifier.properties objectForKey:@"key"]]) {
			return [specifier.properties objectForKey:@"default"];
		}
		return [prefsPlist objectForKey:[specifier.properties objectForKey:@"key"]];
}

-(void) setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
	NSMutableDictionary *prefsPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", [specifier.properties objectForKey:@"defaults"]]];
	[prefsPlist setObject:value forKey:[specifier.properties objectForKey:@"key"]];
	[prefsPlist writeToFile:[NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", [specifier.properties objectForKey:@"defaults"]] atomically:1];
	if ([specifier.properties objectForKey:@"PostNotification"]) {
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)[specifier.properties objectForKey:@"PostNotification"], NULL, NULL, YES);
	}
	[super setPreferenceValue:value specifier:specifier];
}

@end
