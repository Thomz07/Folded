//While it is abnormal, there is no .h file for this .m file. Everything comes in one neat package!
//This is because there was a "#include nested too deeply" error.
#import <Preferences/PSListController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListItemsController.h>
#import <Preferences/PSSliderTableCell.h>
#import <spawn.h>
//#import <Preferences/PSSegmentTableCell.h>

@interface OPEPresetController : PSListController
@end

@interface NSTask : NSObject
@property(copy) NSArray *arguments;
@property(copy) NSString *launchPath;
- (id)init;
- (void)launch;
@end

@implementation OPEPresetController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Presets" target:self];
	}

	return _specifiers;
}

- (void)viewWillAppear:(BOOL)animated {

	[[UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:0.00 green:0.54 blue:1.00 alpha:1.00]];
    [[UISwitch appearanceWhenContainedInInstancesOfClasses:@[self.class]] setOnTintColor:[UIColor colorWithRed:0.00 green:0.54 blue:1.00 alpha:1.00]];
    [[UISlider appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:0.00 green:0.54 blue:1.00 alpha:1.00]];

    [super viewWillAppear:animated];
}

-(void)applyPreset:(PSSpecifier *)specifier {
    NSString *desiredPresetPlist = [NSString stringWithFormat:@"/Library/PreferenceBundles/Folded.bundle/%@.plist /var/mobile/Library/Preferences/xyz.burritoz.thomz.folded.prefs.plist", [specifier propertyForKey:@"presetName"]];

	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Apply Preset"
							message:@"Are you sure you want to apply this preset? \n \n This action CANNOT be undone!"
							preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
		handler:^(UIAlertAction * action) {}];
		UIAlertAction* yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive
		handler:^(UIAlertAction * action) {
			NSTask *t = [[NSTask alloc] init];
			[t setLaunchPath:@"/bin/rm"];
			[t setArguments:[NSArray arrayWithObjects:@"/var/mobile/Library/Preferences/xyz.burritoz.thomz.folded.prefs.plist", nil]];
			[t launch];

			NSTask *t4 = [[NSTask alloc] init];
			[t4 setLaunchPath:@"/bin/cp"];
			[t4 setArguments:[NSArray arrayWithObjects:desiredPresetPlist, nil]];
			[t4 launch];

			pid_t pid;
    			const char* args[] = {"killall", "-9", "SpringBoard", NULL};
   			    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);

			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("xyz.burritoz.thomz.folded.prefs/reload"), nil, nil, true);
         });
		}];

		[alert addAction:defaultAction];
		[alert addAction:yes];
		[self presentViewController:alert animated:YES completion:nil];

}

@end