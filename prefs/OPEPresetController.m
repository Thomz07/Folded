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
#define PLIST_PATH @"/User/Library/Preferences/xyz.burritoz.thomz.folded.prefs.plist"
#define kIdentifier @"xyz.burritoz.thomz.folded.prefs"
#define kSettingsChangedNotification (CFStringRef)@"xyz.burritoz.thomz.folded.prefs/reload"
#define kSettingsPath @"/var/mobile/Library/Preferences/xyz.burritoz.thomz.folded.prefs.plist"

NSDictionary *recievedPrefs = nil;
NSMutableArray *arrayWithPrefs;

static void reloadPrefs() 
{
    if ([NSHomeDirectory() isEqualToString:@"/var/mobile"]) 
    {
        CFArrayRef keyList = CFPreferencesCopyKeyList((CFStringRef)kIdentifier, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);

        if (keyList) 
        {
            recievedPrefs = (NSDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, (CFStringRef)kIdentifier, kCFPreferencesCurrentUser, kCFPreferencesAnyHost));

            if (!recievedPrefs) 
            {
                recievedPrefs = [NSDictionary new];
            }
            CFRelease(keyList);
        }
    } 
    else 
    {
        recievedPrefs = [NSDictionary dictionaryWithContentsOfFile:kSettingsPath];
    }
}
static BOOL boolValueForKey(NSString *key, BOOL defaultValue) {
	BOOL value = (recievedPrefs && [recievedPrefs objectForKey:key]) ? [[recievedPrefs objectForKey:key] boolValue] : defaultValue;
	if(value) {
		[arrayWithPrefs addObject:@YES];
	} else {
		[arrayWithPrefs addObject:@NO];
	}
    return value;
}

static double numberForValue(NSString *key, double defaultValue) {
	double value = (recievedPrefs && [recievedPrefs objectForKey:key]) ?  [[recievedPrefs objectForKey:key] doubleValue] : defaultValue;

	NSNumber *numberForDouble = [NSNumber numberWithDouble:value];

	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	formatter.roundingIncrement = [NSNumber numberWithDouble:0.01];
	formatter.numberStyle = NSNumberFormatterDecimalStyle;

	[arrayWithPrefs addObject:[NSString stringWithFormat:@"%@",[formatter stringFromNumber:numberForDouble]]];
	return value;
}

static NSString* colorForValue(NSString *key) {
	NSString *value = (recievedPrefs && [recievedPrefs objectForKey:key]) ?  [recievedPrefs objectForKey:key] : @"#000000";
	[arrayWithPrefs addObject:[NSString stringWithFormat:@"%@",value]];
	return value;
}

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
				[self setObjectInPreset:@YES forKey:@"customTitleXOffSetEnabled"];
				[self setObjectInPreset:@YES forKey:@"enabled"];
				[self setObjectInPreset:@"2" forKey:@"hideDotsPref"];
				[self setObjectInPreset:@"1" forKey:@"titleAlignment"];
				[self setObjectInPreset:@YES forKey:@"customFrameEnabled"];
				[self setObjectInPreset:@YES forKey:@"customFolderIconEnabled"];
				[self setObjectInPreset:@YES forKey:@"customTitleOffsetEnabled"];
				[self setObjectInPreset:@"-17" forKey:@"customTitleXOffSet"];
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
				[self setObjectInPreset:@"600" forKey:@"customFrameHeight"]; //I made this bigger
				[self setObjectInPreset:@"375" forKey:@"customFrameWidth"];
				[self setObjectInPreset:@"0" forKey:@"customFrameX"];
				[self setObjectInPreset:@"167" forKey:@"customFrameY"];
				[self setObjectInPreset:@YES forKey:@"customFrameEnabled"];
				[self setObjectInPreset:@YES forKey:@"customLayoutEnabled"];
				[self setObjectInPreset:@"4" forKey:@"customLayoutColumns"];
				[self setObjectInPreset:@"5" forKey:@"customLayoutRows"];
				
				[self setObjectInPreset:@YES forKey:@"clearBackgroundIcons"];
				[self setObjectInPreset:@"3" forKey:@"titleFontWeight"];
				[self setObjectInPreset:@YES forKey:@"customTitleXOffSetEnabled"];
				[self setObjectInPreset:@"-17" forKey:@"customTitleXOffSet"];
				[self setObjectInPreset:@YES forKey:@"customTitleOffSetEnabled"];
				[self setObjectInPreset:@"167" forKey:@"customTitleOffSet"];


				[self setObjectInPreset:@YES forKey:@"customFolderIconEnabled"];
				[self setObjectInPreset:@"3" forKey:@"folderIconColumns"];
				[self setObjectInPreset:@"3" forKey:@"folderIconRows"];

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

				[self setObjectInPreset:@YES forKey:@"customFolderIconEnabled"];
				[self setObjectInPreset:@"3" forKey:@"folderIconColumns"];
				[self setObjectInPreset:@"3" forKey:@"folderIconRows"];

				[self setObjectInPreset:@"3" forKey:@"titleFontWeight"];
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

-(void)exportPrefs {
	arrayWithPrefs = [[NSMutableArray alloc] init];

	BOOL enabled = YES;
	BOOL backgroundAlphaEnabled;
	double backgroundAlpha;
	BOOL cornerRadiusEnabled;
	double cornerRadius;
	BOOL pinchToCloseEnabled;
	BOOL customFrameEnabled;
	BOOL customCenteredFrameEnabled;
	CGFloat frameX;
	CGFloat frameY;
	CGFloat frameWidth;
	CGFloat frameHeight;
	BOOL customLayoutEnabled;
	long long customLayoutRows;
	long long customLayoutColumns;
	BOOL hideTitleEnabled;
	BOOL customTitleFontSizeEnabled;
	double customTitleFontSize;
	BOOL customTitleOffSetEnabled;
	double customTitleOffSet;
	BOOL customTitleXOffSetEnabled;
	double customTitleXOffSet;
	BOOL customFolderIconEnabled;
	long long folderIconRows;
	long long folderIconColumns;
	BOOL twoByTwoIconEnabled;
	int titleFontWeight;
	int titleAlignment;
	BOOL titleColorEnabled;
	NSString *titleColor;
	BOOL titleBackgroundEnabled;
	NSString *titleBackgroundColor;
	double titleBackgroundCornerRadius;
	BOOL titleBackgroundBlurEnabled;
	BOOL showInjectionAlerts;
	BOOL customBlurBackgroundEnabled;
	int customBlurBackground;
	BOOL folderBackgroundColorEnabled;
	NSString *folderBackgroundColor;
	BOOL customTitleFontEnabled;
	double customTitleFont;
	BOOL seizureModeEnabled;
	BOOL folderBackgroundBackgroundColorEnabled;
	double backgroundAlphaColor;
	NSString * folderBackgroundBackgroundColor;
	BOOL randomColorBackgroundEnabled;
	BOOL folderBackgroundColorWithGradientEnabled;
	NSString *folderBackgroundColorWithGradient;
	BOOL folderBackgroundColorWithGradientVerticalGradientEnabled; // bruh
	BOOL hideFolderGridEnabled;
	BOOL clearBackgroundIcons;
	BOOL customWallpaperBlurEnabled;
	double customWallpaperBlurFactor;
	BOOL tapToCloseEnabled;
	BOOL hideFolderIconBackground;
	double hideDotsPref;
	BOOL resizeFolderIconEnabled;
	double resizeFactor;

    CFPreferencesAppSynchronize((CFStringRef)kIdentifier);
    reloadPrefs();

	enabled = boolValueForKey(@"enabled", NO);
	backgroundAlphaEnabled = boolValueForKey(@"backgroundAlphaEnabled", NO);
	backgroundAlpha = numberForValue(@"backgroundAlpha", 1.0);
	cornerRadiusEnabled = boolValueForKey(@"cornerRadiusEnabled", NO);
	cornerRadius = numberForValue(@"cornerRadius", 25);
	pinchToCloseEnabled = boolValueForKey(@"pinchToCloseEnabled", NO);
	customFrameEnabled = boolValueForKey(@"customFrameEnabled", YES);
	customCenteredFrameEnabled = boolValueForKey(@"customCenteredFrameEnabled", NO);
	frameX = numberForValue(@"customFrameX", 0);
	frameY = numberForValue(@"customFrameY", 0);
	frameWidth = numberForValue(@"customFrameWidth", 300);
	frameHeight = numberForValue(@"customFrameHeight", 300);
	customLayoutEnabled = boolValueForKey(@"customLayoutEnabled", NO);
	customLayoutRows = numberForValue(@"customLayoutRows", 4);
	customLayoutColumns = numberForValue(@"customLayoutColumns", 4);
    hideTitleEnabled = boolValueForKey(@"hideTitleEnabled", NO);
    customTitleFontSizeEnabled = boolValueForKey(@"customTitleFontSizeEnabled", NO);
    customTitleFontSize = numberForValue(@"customTitleFontSize", 36);
    customTitleOffSetEnabled = boolValueForKey(@"customTitleOffSetEnabled", NO);
    customTitleOffSet = numberForValue(@"customTitleOffSet", 0);
	customTitleXOffSetEnabled = boolValueForKey(@"customTitleXOffSetEnabled", NO);
    customTitleXOffSet = numberForValue(@"customTitleXOffSet", 0);
	customFolderIconEnabled = boolValueForKey(@"customFolderIconEnabled", NO);
    folderIconRows = numberForValue(@"folderIconRows", 3);
	folderIconColumns = numberForValue(@"folderIconColumns", 3);
	twoByTwoIconEnabled = boolValueForKey(@"twoByTwoIconEnabled", NO);
	titleFontWeight = numberForValue(@"titleFontWeight", 0);
	titleAlignment = numberForValue(@"titleAlignment", 1);
	titleColorEnabled = boolValueForKey(@"titleColorEnabled", NO);
	titleColor = colorForValue(@"titleColor");
	titleBackgroundEnabled = boolValueForKey(@"titleBackgroundEnabled", NO);
	titleBackgroundColor = colorForValue(@"titleBackgroundColor");
	titleBackgroundCornerRadius = numberForValue(@"titleBackgroundCornerRadius", 10);
	titleBackgroundBlurEnabled = boolValueForKey(@"titleBackgroundBlurEnabled", NO);
	showInjectionAlerts = boolValueForKey(@"showInjectionAlerts", YES);
	customBlurBackgroundEnabled = boolValueForKey(@"customBlurBackgroundEnabled", NO);
	customBlurBackground = numberForValue(@"customBlurBackground", 1);
	folderBackgroundColorEnabled = boolValueForKey(@"folderBackgroundColorEnabled", NO);
	folderBackgroundColor = colorForValue(@"folderBackgroundColor");
	customTitleFontEnabled = boolValueForKey(@"customTitleFontEnabled", NO);
	customTitleFont = numberForValue(@"customTitleFont", 36);
	seizureModeEnabled = boolValueForKey(@"seizureModeEnabled", NO);
	folderBackgroundBackgroundColorEnabled = boolValueForKey(@"folderBackgroundBackgroundColorEnabled", NO);
	backgroundAlphaColor = numberForValue(@"backgroundAlphaColor", 0);
	folderBackgroundBackgroundColor = colorForValue(@"folderBackgroundBackgroundColor");
	randomColorBackgroundEnabled = boolValueForKey(@"randomColorBackgroundEnabled", NO);
	folderBackgroundColorWithGradientEnabled = boolValueForKey(@"folderBackgroundColorWithGradientEnabled", NO);
	folderBackgroundColorWithGradient = colorForValue(@"folderBackgroundColorWithGradient");
	folderBackgroundColorWithGradientVerticalGradientEnabled = boolValueForKey(@"folderBackgroundColorWithGradientVerticalGradientEnabled", NO);
	hideFolderGridEnabled = boolValueForKey(@"hideFolderGridEnabled", NO);
	clearBackgroundIcons = boolValueForKey(@"clearBackgroundIcons", NO);
	customWallpaperBlurEnabled = boolValueForKey(@"customWallpaperBlurEnabled", NO);
	customWallpaperBlurFactor = numberForValue(@"customWallpaperBlurFactor", 1.0);
	tapToCloseEnabled = boolValueForKey(@"tapToCloseEnabled", NO);
	hideFolderIconBackground = boolValueForKey(@"hideFolderIconBackground", NO);
	hideDotsPref = numberForValue(@"hideDotsPref", 1);
	resizeFolderIconEnabled = boolValueForKey(@"resizeFolderIconEnabled", NO);
	resizeFactor = numberForValue(@"resizeFactor", 1.0);

	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Folded"
                               message:@"Folded has exported your settings and added a unique string to your pasteboard. You may enter this, or share with others, to restore to this preset at any time."
                               preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Awesome!" style:UIAlertActionStyleDefault
   		handler:^(UIAlertAction * action) {}];

		[alert addAction:defaultAction];

		NSString *newPasteboardData = [[arrayWithPrefs valueForKey:@"description"] componentsJoinedByString:@"f"];
		//The above line is my workaround for the fact that there is no perfect conversion of NSMutableArray to NSString
		//This removes the annoying line breaks and outer parenthesis that [arrayWithPrefs description] would return

		[UIPasteboard generalPasteboard].string = newPasteboardData;

		[self presentViewController:alert animated:YES completion:nil];
}


-(void)enterPrefs {
	UIAlertController *sucess = [UIAlertController alertControllerWithTitle:@"Folded"
							message:@"Your new preset has been applied. Your device will now respring."
							preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* yes = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
		handler:^(UIAlertAction * action) {
			NSTask *t = [[NSTask alloc] init];
			[t setLaunchPath:@"usr/bin/killall"];
			[t setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
			[t launch];
		}];

		[sucess addAction:yes];

	UIAlertController* invalid = [UIAlertController alertControllerWithTitle:@"Folded"
                               message:@"The preset found in your pasteboard is invalid."
                               preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* OK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
   		handler:^(UIAlertAction * action) {}];

		[invalid addAction:OK];

	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Folded"
                               message:@"Folded will get the preset from your pasteboard. Please be sure it is valid, or this will not work."
                               preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
   		handler:^(UIAlertAction * action) {}];

		UIAlertAction* proceed = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive
   		handler:^(UIAlertAction * action) {

			   @try{

				   NSUserDefaults *prefs = [[NSUserDefaults standardUserDefaults] init];
				   [prefs removePersistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

				   NSString *pasteboardData = [UIPasteboard generalPasteboard].string;

			       NSArray *list = [pasteboardData componentsSeparatedByString:@"f"];

				   NSMutableArray *listItems = [(NSArray*)list mutableCopy];
				   /*
				   NSMutableArray *possibleprefs = [[NSMutableArray alloc] init];
				   [possibleprefs addObjectsFromArray:@[@"enabled",@"backgroundAlphaEnabled",@"backgroundAlpha",@"cornerRadiusEnabled",@"cornerRadius",
				   		@"pinchToCloseEnabled",@"customFrameEnabled",@"customCenteredFrameEnabled",@"customFrameX",@"customFrameY",@"customFrameWidth",
						@"customFrameHeight",@"customLayoutEnabled",@"customLayoutRows",@"customLayoutColumns",@"hideTitleEnabled",@"customTitleFontSizeEnabled",
						@"customTitleFontSize",@"customTitleOffSetEnabled",@"customTitleOffSet",@"customTitleXOffSetEnabled",@"customTitleXOffSet",
						@"customFolderIconEnabled",@"folderIconRows",@"folderIconColumns",@"twoByTwoIconEnabled",@"titleFontWeight",@"titleAlignment",
						@"titleColorEnabled",@"titleColor",@"titleBackgroundEnabled",@"titleBackgroundColor",@"titleBackgroundCornerRadius",
						@"titleBackgroundBlurEnabled",@"showInjectionAlerts",@"customBlurBackgroundEnabled",@"customBlurBackground",@"folderBackgroundColorEnabled",
						@"folderBackgroundColor",@"customTitleFontEnabled",@"customTitleFont",@"seizureModeEnabled",@"folderBackgroundBackgroundColorEnabled",
						@"backgroundAlphaColor",@"folderBackgroundBackgroundColor",@"randomColorBackgroundEnabled",@"folderBackgroundColorWithGradientEnabled",
						@"folderBackgroundColorWithGradient",@"folderBackgroundColorWithGradientVerticalGradientEnabled",@"hideFolderGridEnabled",
						@"clearBackgroundIcons",@"customWallpaperBlurEnabled",@"customWallpaperBlurFactor",@"tapToCloseEnabled",@"hideFolderIconBackground",
						@"hideDotsPref",@"resizeFolderIconEnabled",@"resizeFactor"]];*/

				   [self setObjectInPreset:([listItems objectAtIndex:0]) forKey:@"enabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:1]) forKey:@"backgroundAlphaEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:2]) forKey:@"backgroundAlpha"];
				   [self setObjectInPreset:([listItems objectAtIndex:3]) forKey:@"cornerRadiusEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:4]) forKey:@"cornerRadius"];
				   [self setObjectInPreset:([listItems objectAtIndex:5]) forKey:@"pinchToCloseEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:6]) forKey:@"customFrameEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:7]) forKey:@"customCenteredFrameEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:8]) forKey:@"customFrameX"];
				   [self setObjectInPreset:([listItems objectAtIndex:9]) forKey:@"customFrameY"];
				   [self setObjectInPreset:([listItems objectAtIndex:10]) forKey:@"customFrameWidth"];
				   [self setObjectInPreset:([listItems objectAtIndex:11]) forKey:@"customFrameHeight"];
				   [self setObjectInPreset:([listItems objectAtIndex:12]) forKey:@"customLayoutEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:13]) forKey:@"customLayoutRows"];
				   [self setObjectInPreset:([listItems objectAtIndex:14]) forKey:@"customLayoutColumns"];
				   [self setObjectInPreset:([listItems objectAtIndex:15]) forKey:@"hideTitleEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:16]) forKey:@"customTitleFontSizeEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:17]) forKey:@"customTitleFontSize"];
				   [self setObjectInPreset:([listItems objectAtIndex:18]) forKey:@"customTitleOffSetEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:19]) forKey:@"customTitleOffSet"];
				   [self setObjectInPreset:([listItems objectAtIndex:20]) forKey:@"customTitleXOffSetEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:21]) forKey:@"customTitleXOffSet"];
				   [self setObjectInPreset:([listItems objectAtIndex:22]) forKey:@"customFolderIconEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:23]) forKey:@"folderIconRows"];
				   [self setObjectInPreset:([listItems objectAtIndex:24]) forKey:@"folderIconColumns"];
				   [self setObjectInPreset:([listItems objectAtIndex:25]) forKey:@"twoByTwoIconEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:26]) forKey:@"titleFontWeight"];
				   [self setObjectInPreset:([listItems objectAtIndex:27]) forKey:@"titleAlignment"];
				   [self setObjectInPreset:([listItems objectAtIndex:28]) forKey:@"titleColorEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:29]) forKey:@"titleColor"];
				   [self setObjectInPreset:([listItems objectAtIndex:30]) forKey:@"titleBackgroundEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:31]) forKey:@"titleBackgroundColor"];
				   [self setObjectInPreset:([listItems objectAtIndex:32]) forKey:@"titleBackgroundCornerRadius"];
				   [self setObjectInPreset:([listItems objectAtIndex:33]) forKey:@"titleBackgroundBlurEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:34]) forKey:@"showInjectionAlerts"];
				   [self setObjectInPreset:([listItems objectAtIndex:35]) forKey:@"customBlurBackgroundEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:36]) forKey:@"customBlurBackground"];
				   [self setObjectInPreset:([listItems objectAtIndex:37]) forKey:@"folderBackgroundColorEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:38]) forKey:@"folderBackgroundColor"];
				   [self setObjectInPreset:([listItems objectAtIndex:39]) forKey:@"customTitleFontEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:40]) forKey:@"customTitleFont"];
				   [self setObjectInPreset:([listItems objectAtIndex:41]) forKey:@"seizureModeEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:42]) forKey:@"folderBackgroundBackgroundColorEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:43]) forKey:@"backgroundAlphaColor"];
				   [self setObjectInPreset:([listItems objectAtIndex:44]) forKey:@"folderBackgroundBackgroundColor"];
				   [self setObjectInPreset:([listItems objectAtIndex:45]) forKey:@"randomColorBackgroundEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:46]) forKey:@"folderBackgroundColorWithGradientEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:47]) forKey:@"folderBackgroundColorWithGradient"];
				   [self setObjectInPreset:([listItems objectAtIndex:48]) forKey:@"folderBackgroundColorWithGradientVerticalGradientEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:49]) forKey:@"hideFolderGridEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:50]) forKey:@"clearBackgroundIcons"];
				   [self setObjectInPreset:([listItems objectAtIndex:51]) forKey:@"customWallpaperBlurEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:52]) forKey:@"customWallpaperBlurFactor"];
				   [self setObjectInPreset:([listItems objectAtIndex:53]) forKey:@"tapToCloseEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:54]) forKey:@"hideFolderIconBackground"];
				   [self setObjectInPreset:([listItems objectAtIndex:55]) forKey:@"hideDotsPref"];
				   [self setObjectInPreset:([listItems objectAtIndex:56]) forKey:@"resizeFolderIconEnabled"];
				   [self setObjectInPreset:([listItems objectAtIndex:57]) forKey:@"resizeFactor"];

				   [self presentViewController:sucess animated:YES completion:nil];

			   } @catch (NSException *exception) {
				   [self presentViewController:invalid animated:YES completion:nil];
			   }

		   }]; 
	
		[alert addAction:defaultAction];
		[alert addAction:proceed];

		[self presentViewController:alert animated:YES completion:nil];
}

@end