#include "OPESubPageController.h"

_UICustomBlurEffect *blurEffectNotification;
UIVisualEffectView *blurView;
NSDictionary *preferences;

@implementation OPESubPageController

BOOL customTitleFontSizeEnabled;
BOOL customTitleOffSetEnabled;
BOOL titleColorEnabled;
BOOL titleBackgroundEnabled;
BOOL hasShownApplyAlert;
BOOL customLayoutEnabled;
BOOL customTitleFontEnabled;
BOOL customTitleXOffSetEnabled;
BOOL customTitleBoxWidthEnabled;
BOOL customTitleBoxHeightEnabled;
BOOL customCenteredFrameEnabled;
BOOL folderBackgroundColorEnabled;
BOOL folderBackgroundColorWithGradientEnabled;
BOOL folderBackgroundBackgroundColorEnabled;
BOOL customBlurBackgroundEnabled;
BOOL customWallpaperBlurEnabled;
BOOL backgroundAlphaEnabled;
BOOL cornerRadiusEnabled;
BOOL resizeFolderIconEnabled;
BOOL customFolderIconEnabled;

void updateFolderBlurView() { 

	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

	blurEffectNotification = [[_UICustomBlurEffect alloc]init];

	double folders_container_blurFactor = [[preferences valueForKey:@"customBlurBlurFactor"] doubleValue];
	double folders_container_colorTintAlpha = [[preferences valueForKey:@"customBlurColorTintAlpha"] doubleValue];
	double folders_container_saturationDeltafactor = [[preferences valueForKey:@"customBlurSaturationDeltafactor"] doubleValue];
	double folders_container_redFactor = [[preferences valueForKey:@"customBlurRedFactor"] doubleValue];
	double folders_container_greenFactor = [[preferences valueForKey:@"customBlurGreenFactor"] doubleValue];
	double folders_container_blueFactor = [[preferences valueForKey:@"customBlurBlueFactor"] doubleValue];
	float folders_container_red_float = (float) folders_container_redFactor;
	float folders_container_green_float = (float) folders_container_greenFactor;
	float folders_container_blue_float = (float) folders_container_blueFactor;

	blurEffectNotification = [[_UICustomBlurEffect alloc] init];
	blurEffectNotification.blurRadius = folders_container_blurFactor;
	blurEffectNotification.colorTint = [UIColor colorWithRed:folders_container_red_float green:folders_container_green_float blue:folders_container_blue_float alpha:1.0];
	blurEffectNotification.colorTintAlpha = folders_container_colorTintAlpha;
	blurEffectNotification.saturationDeltaFactor = folders_container_saturationDeltafactor;
	blurEffectNotification.scale = ([UIScreen mainScreen].scale);

	blurView.effect = blurEffectNotification;
}

- (void)setSpecifier:(PSSpecifier *)specifier {
    [self loadFromSpecifier:specifier];
    [super setSpecifier:specifier];
}


- (void)loadFromSpecifier:(PSSpecifier *)specifier {
	if (!_specifiers) {
		self.sub = [specifier propertyForKey:@"pageKey"];

		_specifiers = [self loadSpecifiersFromPlistName:_sub target:self];

		if ([[specifier propertyForKey:@"pageKey"] isEqualToString:@"Title"]) {
			NSArray *chosenLabels = @[@"customTitleFontSize", @"customTitleOffSet", @"titleColor", @"customTitleColor", @"customTitleFont",@"customTitleXOffSet"];
			self.mySavedSpecifiers = (!self.mySavedSpecifiers) ? [[NSMutableDictionary alloc] init] : self.mySavedSpecifiers;
			for(PSSpecifier *specifier in [self specifiers]) {
			if([chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
			[self.mySavedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
		}
		}

		if ([[specifier propertyForKey:@"pageKey"] isEqualToString:@"Layout"]) {
			NSArray *chosenLabels = @[@"rowsAndColumnsGroupCell", @"customLayoutRows", @"customLayoutColumns"];
			self.mySavedSpecifiers = (!self.mySavedSpecifiers) ? [[NSMutableDictionary alloc] init] : self.mySavedSpecifiers;
			for(PSSpecifier *specifier in [self specifiers]) {
			if([chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
			[self.mySavedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
		}
		}

		if ([[specifier propertyForKey:@"pageKey"] isEqualToString:@"Icon"]) {
			NSArray *chosenLabels = @[@"rowsAndColumnsGroupCellIcon", @"folderIconRows", @"folderIconColumns",@"resizeFactor"];
			self.mySavedSpecifiers = (!self.mySavedSpecifiers) ? [[NSMutableDictionary alloc] init] : self.mySavedSpecifiers;
			for(PSSpecifier *specifier in [self specifiers]) {
			if([chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
			[self.mySavedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
		}
		}

		if ([[specifier propertyForKey:@"pageKey"] isEqualToString:@"Frame"]) {
			NSArray *chosenLabels = @[@"customFrameX",@"customFrameY"];
			self.mySavedSpecifiers = (!self.mySavedSpecifiers) ? [[NSMutableDictionary alloc] init] : self.mySavedSpecifiers;
			for(PSSpecifier *specifier in [self specifiers]) {
			if([chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
			[self.mySavedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
		}
		}

		if ([[specifier propertyForKey:@"pageKey"] isEqualToString:@"Appearance"]) {
			NSArray *chosenLabels = @[@"folderBackgroundColor",@"folderBackgroundColorWithGradientEnabled",@"folderBackgroundColorWithGradient",@"folderBackgroundColorWithGradientVerticalGradientEnabled",@"folderBackgroundBackgroundColor",@"randomColorBackgroundEnabled",@"customBlurBackground",@"customWallpaperBlurFactor",@"backgroundAlphaColor",@"enableCustomBlur",@"customBlurBlurFactor",@"customBlurColorTintAlpha",@"customBlurSaturationDeltafactor",@"customBlurRedFactor",@"customBlurGreenFactor",@"customBlurBlueFactor",@"previewCell"];
			self.mySavedSpecifiers = (!self.mySavedSpecifiers) ? [[NSMutableDictionary alloc] init] : self.mySavedSpecifiers;
			for(PSSpecifier *specifier in [self specifiers]) {
			if([chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
			[self.mySavedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
		}
		}

		if ([[specifier propertyForKey:@"pageKey"] isEqualToString:@"Miscellaneous"]) {
			NSArray *chosenLabels = @[@"backgroundAlpha",@"cornerRadius"];
			self.mySavedSpecifiers = (!self.mySavedSpecifiers) ? [[NSMutableDictionary alloc] init] : self.mySavedSpecifiers;
			for(PSSpecifier *specifier in [self specifiers]) {
			if([chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
			[self.mySavedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
		}
		}

	}
}

- (void)viewWillAppear:(BOOL)animated {

	[[UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:0.00 green:0.54 blue:1.00 alpha:1.00]];
    [[UISwitch appearanceWhenContainedInInstancesOfClasses:@[self.class]] setOnTintColor:[UIColor colorWithRed:0.00 green:0.54 blue:1.00 alpha:1.00]];
    [[UISlider appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:0.00 green:0.54 blue:1.00 alpha:1.00]];

    [super viewWillAppear:animated];
}

-(void)viewDidLoad {
	[super viewDidLoad];
	[self removeSegments];
	if (![self.sub isEqualToString:@"FAQ"]) {
		hasShownApplyAlert = NO;
		UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(apply:)];
		self.navigationItem.rightBarButtonItem = applyButton;
	}

	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)updateFolderBlurView, CFSTR("xyz.burritoz.thomz.folded.prefs/foldersBlurView"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}

-(void)reloadSpecifiers {
	[self removeSegments];
}

-(void)apply:(PSSpecifier *)specifier {
			
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("xyz.burritoz.thomz.folded.prefs/reload"), nil, nil, true);
	   [self.view endEditing:YES];
         });
	
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

	if (!hasShownApplyAlert && !([self.sub isEqualToString:@"Layout"] || [self.sub isEqualToString:@"Icon"])) {
		UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Folded"
								message:@"Your settings have been applied. Some settings, not many, may require a respring."
								preferredStyle:UIAlertControllerStyleAlert];
	
			UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
			handler:^(UIAlertAction * action) {}];
	
			[alert addAction:defaultAction];
			[self presentViewController:alert animated:YES completion:nil];
			
			hasShownApplyAlert = YES;
	} else if([self.sub isEqualToString:@"Layout"] || [self.sub isEqualToString:@"Icon"]) {
		UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Respring"
								message:@"This section requires a respring for changes to apply. Are you sure you want to respring?"
								preferredStyle:UIAlertControllerStyleAlert];

			UIAlertAction* yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive
			handler:^(UIAlertAction * action) {
				NSTask *t = [[NSTask alloc] init];
				[t setLaunchPath:@"/usr/bin/killall"];
				[t setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
				[t launch];
			}];

			UIAlertAction* no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
			handler:^(UIAlertAction * action) {}];

			[alert addAction:no];
			[alert addAction:yes];

			[self presentViewController:alert animated:YES completion:nil];
	}

	AudioServicesPlaySystemSound(1521);
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
		[super setPreferenceValue:value specifier:specifier];

		preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

		if ([self.sub isEqualToString:@"Title"]) {

			customTitleFontSizeEnabled = [[preferences objectForKey:@"customTitleFontSizeEnabled"] boolValue];
			customTitleOffSetEnabled = [[preferences objectForKey:@"customTitleOffSetEnabled"] boolValue];
			titleColorEnabled = [[preferences objectForKey:@"titleColorEnabled"] boolValue];
			customTitleFontEnabled = [[preferences objectForKey:@"customTitleFontEnabled"] boolValue];
			customTitleXOffSetEnabled = [[preferences objectForKey:@"customTitleXOffSetEnabled"] boolValue];

			if(!customTitleFontSizeEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFontSize"]] animated:YES];
			} else if(customTitleFontSizeEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customTitleFontSize"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFontSize"]] afterSpecifierID:@"Custom Title Font Size" animated:YES];
			}

			if(!customTitleOffSetEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleOffSet"]] animated:YES];
			} else if(customTitleOffSetEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customTitleOffSet"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleOffSet"]] afterSpecifierID:@"Custom Title Y Offset" animated:YES];
			}

			if(!titleColorEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleColor"]] animated:YES];
			} else if(titleColorEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"titleColor"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleColor"]] afterSpecifierID:@"Custom Title Color" animated:YES];
			}

			if(!customTitleFontEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFont"]] animated:YES];
			} else if(customTitleFontEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customTitleFont"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFont"]] afterSpecifierID:@"Custom Title Font" animated:YES];
			}

			if(!customTitleXOffSetEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleXOffSet"]] animated:YES];
			} else if(customTitleXOffSetEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customTitleXOffSet"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleXOffSet"]] afterSpecifierID:@"Custom Title X Offset" animated:YES];
			}
		}

		if ([self.sub isEqualToString:@"Frame"]) {

			customCenteredFrameEnabled = [[preferences objectForKey:@"customCenteredFrameEnabled"] boolValue];

			if(!customCenteredFrameEnabled&& ![self containsSpecifier:self.mySavedSpecifiers[@"customFrameX"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"customFrameY"]]){
 				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customFrameX"], self.mySavedSpecifiers[@"customFrameY"]] afterSpecifierID:@"Centered Frame" animated:YES];
 			} else if(customCenteredFrameEnabled) {
 				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customFrameX"], self.mySavedSpecifiers[@"customFrameY"]] animated:YES];
 			}
			
		}

		if ([self.sub isEqualToString:@"Appearance"]) {

			folderBackgroundColorEnabled = [[preferences objectForKey:@"folderBackgroundColorEnabled"] boolValue];
			folderBackgroundColorWithGradientEnabled = [[preferences objectForKey:@"folderBackgroundColorWithGradientEnabled"] boolValue];
			folderBackgroundBackgroundColorEnabled = [[preferences objectForKey:@"folderBackgroundBackgroundColorEnabled"] boolValue];
			customBlurBackgroundEnabled = [[preferences objectForKey:@"customBlurBackgroundEnabled"] boolValue];
			customWallpaperBlurEnabled = [[preferences objectForKey:@"customWallpaperBlurEnabled"] boolValue];

			if(!folderBackgroundColorEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderBackgroundColor"]] animated:YES];
			} else if(folderBackgroundColorEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"folderBackgroundColor"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderBackgroundColor"]] afterSpecifierID:@"Folder Background Color" animated:YES];
			}

			if(!folderBackgroundColorWithGradientEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderBackgroundColorWithGradient"], self.mySavedSpecifiers[@"folderBackgroundColorWithGradientVerticalGradientEnabled"]] animated:YES];
			} else if(folderBackgroundColorWithGradientEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"folderBackgroundColorWithGradient"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"folderBackgroundColorWithGradientVerticalGradientEnabled"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderBackgroundColorWithGradient"], self.mySavedSpecifiers[@"folderBackgroundColorWithGradientVerticalGradientEnabled"]] afterSpecifierID:@"Folder Background Gradient" animated:YES];
			}

			if(!folderBackgroundBackgroundColorEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderBackgroundBackgroundColor"], self.mySavedSpecifiers[@"randomColorBackgroundEnabled"], self.mySavedSpecifiers[@"backgroundAlphaColor"]] animated:YES];
			} else if(folderBackgroundBackgroundColorEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"folderBackgroundBackgroundColor"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"randomColorBackgroundEnabled"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"backgroundAlphaColor"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderBackgroundBackgroundColor"], self.mySavedSpecifiers[@"randomColorBackgroundEnabled"], self.mySavedSpecifiers[@"backgroundAlphaColor"]] afterSpecifierID:@"Add a Color to the Background" animated:YES];
			}

			if(!customBlurBackgroundEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customBlurBackground"],self.mySavedSpecifiers[@"previewCell"],self.mySavedSpecifiers[@"enableCustomBlur"],self.mySavedSpecifiers[@"customBlurBlurFactor"],self.mySavedSpecifiers[@"customBlurColorTintAlpha"],self.mySavedSpecifiers[@"customBlurSaturationDeltafactor"],self.mySavedSpecifiers[@"customBlurRedFactor"],self.mySavedSpecifiers[@"customBlurGreenFactor"],self.mySavedSpecifiers[@"customBlurBlueFactor"]] animated:YES];
			} else if(customBlurBackgroundEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customBlurBackground"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"previewCell"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"enableCustomBlur"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"customBlurBlurFactor"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"customBlurColorTintAlpha"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"customBlurSaturationDeltafactor"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"customBlurRedFactor"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"customBlurGreenFactor"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"customBlurBlueFactor"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customBlurBackground"],self.mySavedSpecifiers[@"previewCell"],self.mySavedSpecifiers[@"enableCustomBlur"],self.mySavedSpecifiers[@"customBlurBlurFactor"],self.mySavedSpecifiers[@"customBlurColorTintAlpha"],self.mySavedSpecifiers[@"customBlurSaturationDeltafactor"],self.mySavedSpecifiers[@"customBlurRedFactor"],self.mySavedSpecifiers[@"customBlurGreenFactor"],self.mySavedSpecifiers[@"customBlurBlueFactor"]] afterSpecifierID:@"Custom Blur Background" animated:YES];
			}

			if(!customWallpaperBlurEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customWallpaperBlurFactor"]] animated:YES];
			} else if(customWallpaperBlurEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customWallpaperBlurFactor"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customWallpaperBlurFactor"]] afterSpecifierID:@"Custom Wallpaper Blur Strength" animated:YES];
			}

		}

		if ([self.sub isEqualToString:@"Miscellaneous"]) {

			backgroundAlphaEnabled = [[preferences objectForKey:@"backgroundAlphaEnabled"] boolValue];
			cornerRadiusEnabled = [[preferences objectForKey:@"cornerRadiusEnabled"] boolValue];

			if(!backgroundAlphaEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"backgroundAlpha"]] animated:YES];
			} else if(backgroundAlphaEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"backgroundAlpha"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"backgroundAlpha"]] afterSpecifierID:@"Background Alpha for Folder Background" animated:YES];
			}

			if(!cornerRadiusEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"cornerRadius"]] animated:YES];
			} else if(cornerRadiusEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"cornerRadius"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"cornerRadius"]] afterSpecifierID:@"Corner Radius for Folder Background" animated:YES];
			}

		}

		if ([self.sub isEqualToString:@"Layout"]) {

			customLayoutEnabled = [[preferences objectForKey:@"customLayoutEnabled"] boolValue];

			if(!customLayoutEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"rowsAndColumnsGroupCell"], self.mySavedSpecifiers[@"customLayoutRows"], self.mySavedSpecifiers[@"customLayoutColumns"]] animated:YES];
			} else if(customLayoutEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"rowsAndColumnsGroupCell"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"customLayoutRows"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"customLayoutColumns"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"rowsAndColumnsGroupCell"], self.mySavedSpecifiers[@"customLayoutRows"], self.mySavedSpecifiers[@"customLayoutColumns"]] afterSpecifierID:@"Enable Custom Layout" animated:YES];
			}

		}

		if ([self.sub isEqualToString:@"Icon"]) {

			customFolderIconEnabled = [[preferences objectForKey:@"customFolderIconEnabled"] boolValue];
			resizeFolderIconEnabled = [[preferences objectForKey:@"resizeFolderIconEnabled"] boolValue];

			if(!customFolderIconEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"rowsAndColumnsGroupCellIcon"], self.mySavedSpecifiers[@"folderIconRows"], self.mySavedSpecifiers[@"folderIconColumns"]] animated:YES];
			} else if(customFolderIconEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"rowsAndColumnsGroupCellIcon"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"folderIconRows"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"folderIconColumns"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"rowsAndColumnsGroupCellIcon"], self.mySavedSpecifiers[@"folderIconRows"], self.mySavedSpecifiers[@"folderIconColumns"]] afterSpecifierID:@"Custom Folder Grid" animated:YES];
			}

			if(!resizeFolderIconEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"resizeFactor"]] animated:YES];
			} else if(resizeFolderIconEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"resizeFactor"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"resizeFactor"]] afterSpecifierID:@"Resize Folder Icon" animated:YES];
			}

		}

}

-(void)removeSegments {
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

	if ([self.sub isEqualToString:@"Title"]) {
	
		customTitleFontSizeEnabled = [[preferences objectForKey:@"customTitleFontSizeEnabled"] boolValue];
		customTitleOffSetEnabled = [[preferences objectForKey:@"customTitleOffSetEnabled"] boolValue];
		titleColorEnabled = [[preferences objectForKey:@"titleColorEnabled"] boolValue];
		customTitleFontEnabled = [[preferences objectForKey:@"customTitleFontEnabled"] boolValue];
		customTitleXOffSetEnabled = [[preferences objectForKey:@"customTitleXOffSetEnabled"] boolValue];

		if(!customTitleFontSizeEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFontSize"]] animated:YES];
		}

		if(!customTitleOffSetEnabled){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleOffSet"]] animated:YES];
		}

		if(!titleColorEnabled){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleColor"]] animated:YES];
		}

		if(!customTitleFontEnabled){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFont"]] animated:YES];
		}

		if(!customTitleXOffSetEnabled){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleXOffSet"]] animated:YES];
		}
	}

		if ([self.sub isEqualToString:@"Frame"]) {

			customCenteredFrameEnabled = [[preferences objectForKey:@"customCenteredFrameEnabled"] boolValue];

			if(customCenteredFrameEnabled) {
 				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customFrameX"], self.mySavedSpecifiers[@"customFrameY"]] animated:YES];
 			}
		}

		if ([self.sub isEqualToString:@"Appearance"]) {

			folderBackgroundColorEnabled = [[preferences objectForKey:@"folderBackgroundColorEnabled"] boolValue];
			folderBackgroundColorWithGradientEnabled = [[preferences objectForKey:@"folderBackgroundColorWithGradientEnabled"] boolValue];
			folderBackgroundBackgroundColorEnabled = [[preferences objectForKey:@"folderBackgroundBackgroundColorEnabled"] boolValue];
			customBlurBackgroundEnabled = [[preferences objectForKey:@"customBlurBackgroundEnabled"] boolValue];
			customWallpaperBlurEnabled = [[preferences objectForKey:@"customWallpaperBlurEnabled"] boolValue];

			if(!folderBackgroundColorEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderBackgroundColor"]] animated:YES];
			}

			if(!folderBackgroundColorWithGradientEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderBackgroundColorWithGradient"], self.mySavedSpecifiers[@"folderBackgroundColorWithGradientVerticalGradientEnabled"]] animated:YES];
			}

			if(!folderBackgroundBackgroundColorEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderBackgroundBackgroundColor"], self.mySavedSpecifiers[@"randomColorBackgroundEnabled"], self.mySavedSpecifiers[@"backgroundAlphaColor"]] animated:YES];
			}

			if(!customBlurBackgroundEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customBlurBackground"],self.mySavedSpecifiers[@"previewCell"],self.mySavedSpecifiers[@"enableCustomBlur"],self.mySavedSpecifiers[@"customBlurBlurFactor"],self.mySavedSpecifiers[@"customBlurColorTintAlpha"],self.mySavedSpecifiers[@"customBlurSaturationDeltafactor"],self.mySavedSpecifiers[@"customBlurRedFactor"],self.mySavedSpecifiers[@"customBlurGreenFactor"],self.mySavedSpecifiers[@"customBlurBlueFactor"]] animated:YES];
			}

			if(!customWallpaperBlurEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customWallpaperBlurFactor"]] animated:YES];
			}

		}

		if ([self.sub isEqualToString:@"Miscellaneous"]) {

			backgroundAlphaEnabled = [[preferences objectForKey:@"backgroundAlphaEnabled"] boolValue];
			cornerRadiusEnabled = [[preferences objectForKey:@"cornerRadiusEnabled"] boolValue];

			if(!backgroundAlphaEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"backgroundAlpha"]] animated:YES];
			} 

			if(!cornerRadiusEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"cornerRadius"]] animated:YES];
			} 

		}

		if ([self.sub isEqualToString:@"Layout"]) {

			customLayoutEnabled = [[preferences objectForKey:@"customLayoutEnabled"] boolValue];

			if(!customLayoutEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"rowsAndColumnsGroupCell"], self.mySavedSpecifiers[@"customLayoutRows"], self.mySavedSpecifiers[@"customLayoutColumns"]] animated:YES];
			}
		}

		if ([self.sub isEqualToString:@"Icon"]) {

			customFolderIconEnabled = [[preferences objectForKey:@"customFolderIconEnabled"] boolValue];
			resizeFolderIconEnabled = [[preferences objectForKey:@"resizeFolderIconEnabled"] boolValue];

			if(!customFolderIconEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"rowsAndColumnsGroupCellIcon"], self.mySavedSpecifiers[@"folderIconRows"], self.mySavedSpecifiers[@"folderIconColumns"]] animated:YES];
			} 

			if(!resizeFolderIconEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"resizeFactor"]] animated:YES];
			} 

		}

}


-(void)openPayPalPool {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/pools/c/8nPzkVjCKn"]];
}

@end

@implementation KRLabeledSliderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier 
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

    if (self)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15,15,300,20)];
        label.text = specifier.properties[@"label"];
        [self.contentView addSubview:label];
        [self.control setFrame:CGRectOffset(self.control.frame, 0, 15)];
		[self setBackgroundColor:[UIColor whiteColor]];
    }

    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.control setFrame:CGRectOffset(self.control.frame, 0, 15)];
}
@end // love you kritanta (yeah he's awesome -Burritoz)

@implementation ThomzScreenSizeCell 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier  {

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self)
    {

		UILabel *deviceInformation = [[UILabel alloc]initWithFrame:CGRectMake(15,14,300,20)];
        UILabel *ScreenWidth = [[UILabel alloc] initWithFrame:CGRectMake(15,40,300,20)];
		UILabel *ScreenHeight = [[UILabel alloc] initWithFrame:CGRectMake(15,60,300,20)];
		UILabel *deviceOS = [[UILabel alloc] initWithFrame:CGRectMake(15,80,300,20)];

		float width = [UIScreen mainScreen].bounds.size.width;
		float height = [UIScreen mainScreen].bounds.size.height;
		NSString *widthString = [NSString stringWithFormat:@"%0.1f", width];
		NSString *heightString = [NSString stringWithFormat:@"%0.1f", height];
		NSString *fullSentenceWidth = [NSString stringWithFormat:@"Your screen width is %@", widthString];
		NSString *fullSentenceHeight = [NSString stringWithFormat:@"Your screen height is %@", heightString];
		NSString *OS = [NSString stringWithFormat:@"Your iOS Version is %@", [[UIDevice currentDevice] systemVersion]];

		[deviceInformation setText:@"Device Information"];
		[deviceInformation setFont:[deviceInformation.font fontWithSize:17]];
        [ScreenWidth setText:fullSentenceWidth];
		[ScreenWidth setFont:[ScreenWidth.font fontWithSize:13]];
		[ScreenHeight setText:fullSentenceHeight];
		[ScreenHeight setFont:[ScreenHeight.font fontWithSize:13]];
		[deviceOS setText:OS];
		[deviceOS setFont:[deviceOS.font fontWithSize:13]];

		[self setBackgroundColor:[UIColor clearColor]];
		[self addSubview:deviceInformation];
		[self addSubview:ScreenWidth];
		[self addSubview:ScreenHeight];
		[self addSubview:deviceOS];

    }

    return self;
}


@end

@implementation getThomzAniPhone2
//This is very much like the twitter cell concept

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

    if (self) {

		NSBundle *bundle = [[NSBundle alloc]initWithPath:@"/Library/PreferenceBundles/Folded.bundle"];
		UIImage *logo = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"payPal" ofType:@"png"]];
		UIImageView *icon = [[UIImageView alloc]initWithImage:logo];
		[icon setFrame:CGRectMake(13,15,40,40)];

		UILabel *person = [[UILabel alloc] initWithFrame:CGRectMake(65,17.5,200,20)];
        [person setText:specifier.properties[@"who"]];
		[person setFont:[person.font fontWithSize:15]];

		UILabel *description = [[UILabel alloc]initWithFrame:CGRectMake(65,35,200,20)];
		[description setText:specifier.properties[@"why"]];
		[description setFont:[description.font fontWithSize:10]];

		[self addSubview:icon];
		[self addSubview:person];
		[self addSubview:description];
	}

	return self;
}

@end

@implementation TartinePreviewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(id)reuseIdentifier specifier:(id)specifier {

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if(self){

		updateFolderBlurView();
		
		blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffectNotification];
		blurView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 300)/2,20,300,60);
		blurView.layer.masksToBounds = YES;
		blurView.layer.cornerRadius = 20;

		NSBundle *bundle = [[NSBundle alloc]initWithPath:@"/var/mobile/Library/SpringBoard"];
		UIImage *wallpaperImage = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"LockBackgroundThumbnail" ofType:@"jpg"]];
		UIImageView *wallpaperView = [[UIImageView alloc]initWithImage:wallpaperImage];
		wallpaperView.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,100);

		UILabel *previewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,40,[UIScreen mainScreen].bounds.size.width,20)];
		previewLabel.text = @"Live preview blur";
		previewLabel.textAlignment = NSTextAlignmentCenter;

		[self addSubview:previewLabel];
		[self addSubview:blurView];
		[self addSubview:wallpaperView];
		[self bringSubviewToFront:blurView];
		[self bringSubviewToFront:previewLabel];

	}
	
	return self;
}

@end