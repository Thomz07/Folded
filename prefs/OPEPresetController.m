//While it is abnormal, there is no .h file for this .m file. Everything comes in one neat package!
//This is because there was a "#include nested too deeply" error.
#import <Preferences/PSListController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListItemsController.h>
#import <Preferences/PSSliderTableCell.h>

@interface OPEPresetController : PSListController
@end

@interface NSTask : NSObject
@property(copy) NSArray *arguments;
@property(copy) NSString *launchPath;
- (id)init;
- (void)waitUntilExit;
- (void)launch;
@end

@interface NSUserDefaults (Folded)

-(id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
-(void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain; //thanks to R0wDrunner for these two lines of the interface :)
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
    //NSString *desiredPresetPlist = [NSString stringWithFormat:@"/Library/PreferenceBundles/Folded.bundle/%@.plist /var/mobile/Library/Preferences/xyz.burritoz.thomz.folded.prefs.plist", [specifier propertyForKey:@"presetName"]];

	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Apply Preset"
							message:@"Are you sure you want to apply this preset? \n \n This action CANNOT be undone!"
							preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
		handler:^(UIAlertAction * action) {}];
		UIAlertAction* yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive
		handler:^(UIAlertAction * action) {
			
			NSUserDefaults *prefs = [[NSUserDefaults standardUserDefaults] init];
			[prefs removePersistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

			/*NSTask *t4 = [[NSTask alloc] init];
			[t4 setLaunchPath:@"/bin/cp"];
			[t4 setArguments:[NSArray arrayWithObjects:desiredPresetPlist, nil]];
			[t4 launch];
			[t4 waitUntilExit];*/

			
			static NSString *domain = @"/var/mobile/Library/Preferences/xyz.burritoz.thomz.folded.prefs.plist";
			
			if([[specifier propertyForKey:@"presetName"] isEqualToString:@"clean35"]) {

			[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"clearBackgroundIcons" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@"38.0" forKey:@"cornerRadius" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"cornerRadiusEnabled" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"customBlurBackground" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@NO forKey:@"customBlurBackgroundEnabled" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"customCenteredFrameEnabled" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"customFolderIconEnabled" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"customFrameEnabled" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@"500" forKey:@"customFrameHeight" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@"325" forKey:@"customFrameWidth" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@"3" forKey:@"customLayoutColumns" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@"3" forKey:@"folderIconRows" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@"3" forKey:@"folderIconColumns" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@"5" forKey:@"customLayoutRows" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"customLayoutEnabled" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"customTitleFontSizeEnabled" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@"50" forKey:@"customTitleFontSize" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"customTitleOffsetEnabled" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@"45" forKey:@"customTitleOffset" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"customWallpaperBlurEnabled" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"enabled" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"hideDotsPref" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"hideFolderIconBackground" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"pinchToCloseEnabled" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"tapToCloseEnabled" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"titleAlignment" inDomain:domain];
			[[NSUserDefaults standardUserDefaults] setObject:@"3" forKey:@"titleFontWeight" inDomain:domain];

			
			}


		 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("xyz.burritoz.thomz.folded.prefs/reload"), nil, nil, true);
         });

		NSTask *f = [[NSTask alloc] init];
		[f setLaunchPath:@"/usr/bin/killall"];
		[f setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
		[f launch];
		}];

		[alert addAction:defaultAction];
		[alert addAction:yes];
		[self presentViewController:alert animated:YES completion:nil];

}

@end