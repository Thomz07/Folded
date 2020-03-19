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

- (void)setSpecifier:(PSSpecifier *)specifier {
    [self loadFromSpecifier:specifier];
    [super setSpecifier:specifier];
}


- (void)loadFromSpecifier:(PSSpecifier *)specifier {
	if (!_specifiers) {
		self.sub = [specifier propertyForKey:@"pageKey"];

		_specifiers = [self loadSpecifiersFromPlistName:_sub target:self];

		if ([[specifier propertyForKey:@"pageKey"] isEqualToString:@"Title"]) {
			NSArray *chosenLabels = @[@"customTitleFontSize", @"customTitleOffSet", @"titleColor", @"customTitleColor", @"customTitleFont", @"titleBackgroundEnabled"];
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("xyz.burritoz.thomz.folded.prefs/reload"), nil, nil, true);
	   [self.view endEditing:YES]; //Hides the keyboard, if present -Burrit0z // omg thank you that was so annoying lmao
	   							   //Lmao no problem Thomz ;) -Burrit0z
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
			//customTitleFontEnabled = [[preferences objectForKey:@"customTitleFontEnabled"] boolValue];
			//titleBackgroundEnabled = [[preferences objectForKey:@"titleBackgroundEnabled"] boolValue];

			if(!customTitleFontSizeEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFontSize"]] animated:YES];
			} else if(customTitleFontSizeEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customTitleFontSize"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFontSize"]] afterSpecifierID:@"Custom Title Font Size" animated:YES];
			}

			if(!customTitleOffSetEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleOffSet"]] animated:YES];
			} else if(customTitleOffSetEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customTitleOffSet"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleOffSet"]] afterSpecifierID:@"Custom Title Offset" animated:YES];
			}

			if(!titleColorEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleColor"]] animated:YES];
			} else if(titleColorEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"titleColor"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleColor"]] afterSpecifierID:@"Custom Title Color" animated:YES];
			}

			/*if(!customTitleFontEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFont"]] animated:YES];
			} else if(customTitleOffSetEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customTitleFont"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFont"]] afterSpecifierID:@"Custom Title Font" animated:YES];
			}

			if(!titleBackgroundEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleBackgroundColor"]] animated:YES];
			} else if(customTitleOffSetEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"titleBackgroundColor"]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleBackgroundColor"]] afterSpecifierID:@"Title Background" animated:YES];
			}*/
		}

		if ([self.sub isEqualToString:@"Layout"]) {
			
		}

}

-(void)removeSegments {
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

	if ([self.sub isEqualToString:@"Title"]) {
	
		customTitleFontSizeEnabled = [[preferences objectForKey:@"customTitleFontSizeEnabled"] boolValue];
		customTitleOffSetEnabled = [[preferences objectForKey:@"customTitleOffSetEnabled"] boolValue];
		titleColorEnabled = [[preferences objectForKey:@"titleColorEnabled"] boolValue];
		//customTitleFontEnabled = [[preferences objectForKey:@"customTitleFontEnabled"] boolValue];
		//titleBackgroundEnabled = [[preferences objectForKey:@"titleBackgroundEnabled"] boolValue];

		if(!customTitleFontSizeEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFontSize"]] animated:YES];
		}

		if(!customTitleOffSetEnabled){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleOffSet"]] animated:YES];
		}

		if(!titleColorEnabled){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleColor"]] animated:YES];
		}

		/*if(!customTitleFontEnabled){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFont"]] animated:YES];
		}

		if(!titleBackgroundEnabled){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleBackgroundColor"]] animated:YES];
		} */
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

@implementation ThomzScreenSizeCell // lil copy of HBTwitterCell from Cephei
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
