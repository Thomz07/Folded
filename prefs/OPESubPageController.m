#include "OPESubPageController.h"

@implementation OPESubPageController

NSDictionary *preferences;
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

- (void)setSpecifier:(PSSpecifier *)specifier {
    [self loadFromSpecifier:specifier];
    [super setSpecifier:specifier];
}


- (void)loadFromSpecifier:(PSSpecifier *)specifier {
	if (!_specifiers) {
		self.sub = [specifier propertyForKey:@"pageKey"];

		_specifiers = [self loadSpecifiersFromPlistName:_sub target:self];

		if ([[specifier propertyForKey:@"pageKey"] isEqualToString:@"Title"]) {
			NSArray *chosenLabels = @[@"customTitleFontSize", @"customTitleOffSet", @"titleColor", @"customTitleColor", @"customTitleFont", @"titleBackgroundColor",@"titleBackgroundCornerRadius",@"customTitleBoxHeight",@"customTitleBoxWidth",@"customTitleXOffSet",@"customFrameX",@"customFrameY"];
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
			NSArray *chosenLabels = @[@"folderBackgroundColor",@"folderBackgroundColorWithGradientEnabled",@"folderBackgroundColorWithGradient",@"folderBackgroundColorWithGradientVerticalGradientEnabled",@"folderBackgroundBackgroundColor",@"randomColorBackgroundEnabled",@"customBlurBackground",@"customWallpaperBlurFactor"];
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
}

-(void)reloadSpecifiers {
	[self removeSegments];
}

-(void)apply:(PSSpecifier *)specifier {
	NSTask *f = [[NSTask alloc] init];
			[f setLaunchPath:@"/usr/bin/killall"];
			[f setArguments:[NSArray arrayWithObjects:@"cfprefsd", nil]];
			[f launch];
			
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("xyz.burritoz.thomz.folded.prefs/reload"), nil, nil, true);
	   [self.view endEditing:YES];
         });
	
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

	if (!hasShownApplyAlert && !([self.sub isEqualToString:@"Layout"] || [self.sub isEqualToString:@"Icon"])) {
		UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Folded"
								message:@"Your settings have been applied. Some settings, not many, may require a respring."
								preferredStyle:UIAlertControllerStyleAlert];
	
			UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cool!" style:UIAlertActionStyleDefault
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
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
		[super setPreferenceValue:value specifier:specifier];

		preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

		if ([self.sub isEqualToString:@"Title"]) {

			customTitleFontSizeEnabled = [[preferences objectForKey:@"customTitleFontSizeEnabled"] boolValue];
			customTitleOffSetEnabled = [[preferences objectForKey:@"customTitleOffSetEnabled"] boolValue];
			titleColorEnabled = [[preferences objectForKey:@"titleColorEnabled"] boolValue];
			customTitleFontEnabled = [[preferences objectForKey:@"customTitleFontEnabled"] boolValue];
			titleBackgroundEnabled = [[preferences objectForKey:@"titleBackgroundEnabled"] boolValue];
			customTitleXOffSetEnabled = [[preferences objectForKey:@"customTitleXOffSetEnabled"] boolValue];
			customTitleBoxWidthEnabled = [[preferences objectForKey:@"customTitleBoxWidthEnabled"] boolValue];
			customTitleBoxHeightEnabled = [[preferences objectForKey:@"customTitleBoxHeightEnabled"] boolValue];

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
			} else if(customTitleOffSetEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customTitleFont"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFont"]] afterSpecifierID:@"Custom Title Font" animated:YES];
			}

			if(!titleBackgroundEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleBackgroundColor"], self.mySavedSpecifiers[@"titleBackgroundCornerRadius"]] animated:YES];
			} else if(customTitleOffSetEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"titleBackgroundColor"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"titleBackgroundCornerRadius"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleBackgroundColor"], self.mySavedSpecifiers[@"titleBackgroundCornerRadius"]] afterSpecifierID:@"Title Background" animated:YES];
			}

			if(!customTitleXOffSetEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleXOffSet"]] animated:YES];
			} else if(customTitleXOffSetEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customTitleXOffSet"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleXOffSet"]] afterSpecifierID:@"Custom Title X Offset" animated:YES];
			}

			if(!customTitleBoxHeightEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleBoxHeight"]] animated:YES];
			} else if(customTitleBoxHeightEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customTitleBoxHeight"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleBoxHeight"]] afterSpecifierID:@"Custom Title Box Height" animated:YES];
			}

			if(!customTitleBoxWidthEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleBoxWidth"]] animated:YES];
			} else if(customTitleBoxWidthEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customTitleBoxWidth"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleBoxWidth"]] afterSpecifierID:@"Custom Title Box Width" animated:YES];
			}
		}

		if ([self.sub isEqualToString:@"Frame"]) {

			customCenteredFrameEnabled = [[preferences objectForKey:@"customCenteredFrameEnabled"] boolValue];

			if(!customCenteredFrameEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customFrameX"], self.mySavedSpecifiers[@"customFrameY"]] animated:YES];
			} else if(customCenteredFrameEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customFrameX"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"customFrameY"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customFrameX"], self.mySavedSpecifiers[@"customFrameY"]] afterSpecifierID:@"Centered Frame" animated:YES];
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
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderBackgroundColorWithGradient"], self.mySavedSpecifiers[@"folderBackgroundColorWithGradientVerticalGradientEnabled"]] afterSpecifierID:@"Use a Gradient" animated:YES];
			}

			if(!folderBackgroundBackgroundColorEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderBackgroundBackgroundColor"], self.mySavedSpecifiers[@"randomColorBackgroundEnabled"]] animated:YES];
			} else if(folderBackgroundBackgroundColorEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"folderBackgroundBackgroundColor"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"randomColorBackgroundEnabled"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderBackgroundBackgroundColor"], self.mySavedSpecifiers[@"randomColorBackgroundEnabled"]] afterSpecifierID:@"Add a Color to the Background" animated:YES];
			}

			if(!customBlurBackgroundEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customBlurBackground"]] animated:YES];
			} else if(customBlurBackgroundEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customBlurBackground"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customBlurBackground"]] afterSpecifierID:@"Custom Blur Background" animated:YES];
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

}

-(void)removeSegments {
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

	if ([self.sub isEqualToString:@"Title"]) {
	
		customTitleFontSizeEnabled = [[preferences objectForKey:@"customTitleFontSizeEnabled"] boolValue];
		customTitleOffSetEnabled = [[preferences objectForKey:@"customTitleOffSetEnabled"] boolValue];
		titleColorEnabled = [[preferences objectForKey:@"titleColorEnabled"] boolValue];
		customTitleFontEnabled = [[preferences objectForKey:@"customTitleFontEnabled"] boolValue];
		titleBackgroundEnabled = [[preferences objectForKey:@"titleBackgroundEnabled"] boolValue];
		customTitleXOffSetEnabled = [[preferences objectForKey:@"customTitleXOffSetEnabled"] boolValue];
		customTitleBoxWidthEnabled = [[preferences objectForKey:@"customTitleBoxWidthEnabled"] boolValue];
		customTitleBoxHeightEnabled = [[preferences objectForKey:@"customTitleBoxHeightEnabled"] boolValue];

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

		if(!titleBackgroundEnabled){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleBackgroundColor"], self.mySavedSpecifiers[@"titleBackgroundCornerRadius"]] animated:YES];
		} 

		if(!customTitleXOffSetEnabled){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleXOffSet"]] animated:YES];
		}

		if(!customTitleBoxHeightEnabled){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleBoxHeight"]] animated:YES];
		}

		if(!customTitleBoxWidthEnabled){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleBoxWidth"]] animated:YES];
		}
	}

		if ([self.sub isEqualToString:@"Frame"]) {

			customCenteredFrameEnabled = [[preferences objectForKey:@"customCenteredFrameEnabled"] boolValue];

			if(!customCenteredFrameEnabled){
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
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderBackgroundBackgroundColor"], self.mySavedSpecifiers[@"randomColorBackgroundEnabled"]] animated:YES];
			}

			if(!customBlurBackgroundEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customBlurBackground"]] animated:YES];
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
@end // love you kritanta (yeah [s]he's awesome -Burritoz)

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
		[deviceInformation setFont:[deviceInformation.font fontWithSize:20]];
        [ScreenWidth setText:fullSentenceWidth];
		[ScreenWidth setFont:[ScreenWidth.font fontWithSize:15]];
		[ScreenHeight setText:fullSentenceHeight];
		[ScreenHeight setFont:[ScreenHeight.font fontWithSize:15]];
		[deviceOS setText:OS];
		[deviceOS setFont:[deviceOS.font fontWithSize:15]];

		[self setBackgroundColor:[UIColor clearColor]];
		[self addSubview:deviceInformation];
		[self addSubview:ScreenWidth];
		[self addSubview:ScreenHeight];
		[self addSubview:deviceOS];

    }

    return self;
}


@end
