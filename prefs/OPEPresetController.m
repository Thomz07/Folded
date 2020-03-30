//While it is abnormal, there is no .h file for this .m file. Everything comes in one neat package!
//This is because there was a "#include nested too deeply" error.
#import <Preferences/PSListController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListItemsController.h>
#import <Preferences/PSSliderTableCell.h>

@interface OPEPresetController : PSListController
-(void)setObjectInPreset:(id)value forKey:(NSString *)key;
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

NSString *domain = @"/var/mobile/Library/Preferences/xyz.burritoz.thomz.folded.prefs.plist";

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

-(void)setObjectInPreset:(id)value forKey:(NSString *)key {
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:key inDomain:domain]; //literally useless except to make the following method look neater
}

-(void)applyPreset:(PSSpecifier *)specifier {

	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Apply Preset"
							message:@"Are you sure you want to apply this preset? \n \n This action will override your existing preferences!"
							preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
		handler:^(UIAlertAction * action) {}];
		UIAlertAction* yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive
		handler:^(UIAlertAction * action) {
			
			NSUserDefaults *prefs = [[NSUserDefaults standardUserDefaults] init];
			[prefs removePersistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];
			
			if([[specifier propertyForKey:@"presetName"] isEqualToString:@"clean35"]) {

				[self setObjectInPreset:@YES forKey:@"clearBackgroundIcons"];
				[self setObjectInPreset:@"38.0" forKey:@"cornerRadius"];
				[self setObjectInPreset:@YES forKey:@"cornerRadiusEnabled"];
				[self setObjectInPreset:@"1" forKey:@"customBlurBackground"];
				[self setObjectInPreset:@NO forKey:@"customBlurBackgroundEnabled"];
				[self setObjectInPreset:@YES forKey:@"customCenteredFrameEnabled"];
				[self setObjectInPreset:@YES forKey:@"customFolderIconEnabled"];
				[self setObjectInPreset:@YES forKey:@"customFrameEnabled"];
				[self setObjectInPreset:@"500" forKey:@"customFrameHeight"];
				[self setObjectInPreset:@"325" forKey:@"customFrameWidth"];
				[self setObjectInPreset:@"3" forKey:@"customLayoutColumns"];
				[self setObjectInPreset:@"3" forKey:@"folderIconRows"];
				[self setObjectInPreset:@"3" forKey:@"folderIconColumns"];
				[self setObjectInPreset:@"5" forKey:@"customLayoutRows"];
				[self setObjectInPreset:@YES forKey:@"customLayoutEnabled"];
				[self setObjectInPreset:@YES forKey:@"customTitleFontSizeEnabled"];
				[self setObjectInPreset:@"50" forKey:@"customTitleFontSize"];
				[self setObjectInPreset:@YES forKey:@"customTitleOffsetEnabled"];
				[self setObjectInPreset:@"45" forKey:@"customTitleOffset"];
				[self setObjectInPreset:@YES forKey:@"customWallpaperBlurEnabled"];
				[self setObjectInPreset:@YES forKey:@"enabled"];
				[self setObjectInPreset:@"2" forKey:@"hideDotsPref"];
				[self setObjectInPreset:@YES forKey:@"hideFolderIconBackground"];
				[self setObjectInPreset:@YES forKey:@"pinchToCloseEnabled"];
				[self setObjectInPreset:@YES forKey:@"tapToCloseEnabled"];
				[self setObjectInPreset:@"2" forKey:@"titleAlignment"];
				[self setObjectInPreset:@"3" forKey:@"titleFontWeight"];

			} else if([[specifier propertyForKey:@"presetName"] isEqualToString:@"44setup"]) {
				[self setObjectInPreset:@YES forKey:@"twoByTwoIconEnabled"];
				[self setObjectInPreset:@YES forKey:@"hideFolderIconBackground"];
				[self setObjectInPreset:@YES forKey:@"customTitleFontSizeEnabled"];
				[self setObjectInPreset:@"2" forKey:@"folderIconColumns"];
				[self setObjectInPreset:@"2" forKey:@"folderIconRows"];
				[self setObjectInPreset:@"4" forKey:@"customLayoutColumns"];
				[self setObjectInPreset:@"4" forKey:@"customLayoutRows"];
				[self setObjectInPreset:@YES forKey:@"customLayoutEnabled"];
				[self setObjectInPreset:@YES forKey:@"customCenteredFrameEnabled"];
				[self setObjectInPreset:@YES forKey:@"pinchToCloseEnabled"];
				[self setObjectInPreset:@YES forKey:@"tapToCloseEnabled"];
				[self setObjectInPreset:@"350" forKey:@"customFrameWidth"];
				[self setObjectInPreset:@YES forKey:@"customTitleFontSizeEnabled"];
				[self setObjectInPreset:@"60" forKey:@"customTitleFontSize"];
				[self setObjectInPreset:@YES forKey:@"backgroundAlphaEnabled"];
				[self setObjectInPreset:@"3" forKey:@"titleFontWeight"];
				[self setObjectInPreset:@YES forKey:@"clearBackgroundIcons"];
				[self setObjectInPreset:@"110" forKey:@"customTitleOffset"];
				[self setObjectInPreset:@YES forKey:@"customTitleXOffsetEnabled"];
				[self setObjectInPreset:@YES forKey:@"enabled"];
				[self setObjectInPreset:@"2" forKey:@"hideDotsPref"];
				[self setObjectInPreset:@"1" forKey:@"titleAlignment"];
				[self setObjectInPreset:@YES forKey:@"customFrameEnabled"];
				[self setObjectInPreset:@YES forKey:@"customFolderIconEnabled"];
				[self setObjectInPreset:@YES forKey:@"customTitleOffsetEnabled"];
				[self setObjectInPreset:@"-17" forKey:@"customTitleXOffset"];
				[self setObjectInPreset:@"400" forKey:@"customFrameHeight"];
				[self setObjectInPreset:@"350" forKey:@"customFrameWidth"];

			} else if([[specifier propertyForKey:@"presetName"] isEqualToString:@"modern27"]) {
				[self setObjectInPreset:@YES forKey:@"backgroundAlphaEnabled"];
				[self setObjectInPreset:@"0" forKey:@"backgroundAlpha"];
				[self setObjectInPreset:@YES forKey:@"tapToCloseEnabled"];
				[self setObjectInPreset:@YES forKey:@"enabled"];
				[self setObjectInPreset:@"1" forKey:@"titleAlignment"];
				[self setObjectInPreset:@"2" forKey:@"titleFontWeight"];
				[self setObjectInPreset:@"2" forKey:@"hideDotsPref"];
				[self setObjectInPreset:@"500" forKey:@"customFrameHeight"];
				[self setObjectInPreset:@"375" forKey:@"customFrameWidth"];
				[self setObjectInPreset:@"0" forKey:@"customFrameX"];
				[self setObjectInPreset:@"167" forKey:@"customFrameY"];
				[self setObjectInPreset:@YES forKey:@"customFrameEnabled"];
				[self setObjectInPreset:@YES forKey:@"customLayoutEnabled"];
				[self setObjectInPreset:@"4" forKey:@"customLayoutColumns"];
				[self setObjectInPreset:@"5" forKey:@"customLayoutRows"];

			} else if([[specifier propertyForKey:@"presetName"] isEqualToString:@"oled92"]) {
				[self setObjectInPreset:@YES forKey:@"enabled"];
				[self setObjectInPreset:@YES forKey:@"backgroundAlphaEnabled"];
				[self setObjectInPreset:@"0" forKey:@"backgroundAlpha"];
				[self setObjectInPreset:@YES forKey:@"tapToCloseEnabled"];
				[self setObjectInPreset:@"2" forKey:@"hideDotsPref"];
				[self setObjectInPreset:@YES forKey:@"folderBackgroundBackgroundColorEnabled"];
				[self setObjectInPreset:@"000000" forKey:@"folderBackgroundBackgroundColor"];
				[self setObjectInPreset:@"1" forKey:@"backgroundAlphaColor"];

			} else if([[specifier propertyForKey:@"presetName"] isEqualToString:@"biggerFolder63"]) {
				[self setObjectInPreset:@YES forKey:@"enabled"];
				[self setObjectInPreset:@YES forKey:@"hideTitleEnabled"];
				[self setObjectInPreset:@YES forKey:@"pinchToCloseEnabled"];
				[self setObjectInPreset:@"500" forKey:@"customFrameHeight"];
				[self setObjectInPreset:@"350" forKey:@"customFrameWidth"];
				[self setObjectInPreset:@YES forKey:@"customFrameEnabled"];
				[self setObjectInPreset:@YES forKey:@"customCenteredFrameEnabled"];
				[self setObjectInPreset:@YES forKey:@"customLayoutEnabled"];
				[self setObjectInPreset:@"4" forKey:@"customLayoutColumns"];
				[self setObjectInPreset:@"5" forKey:@"customLayoutRows"];
				[self setObjectInPreset:@YES forKey:@"clearBackgroundIcons"];
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

-(void)resetPrefs:(id)sender {

	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Reset Preferences"
							message:@"Are you sure you want to reset all of your preferences? This action CANNOT be undone! Your device will respring."
							preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
		handler:^(UIAlertAction * action) {}];
		UIAlertAction* yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive
		handler:^(UIAlertAction * action) {
		
		NSUserDefaults *prefs = [[NSUserDefaults standardUserDefaults] init];
		[prefs removePersistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];			

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