#include "OPESubPageController.h"

@implementation OPESubPageController

NSDictionary *preferences;
BOOL customTitleFontSizeEnabled;
BOOL customTitleOffSetEnabled;
BOOL titleColorEnabled;
BOOL titleBackgroundEnabled;
BOOL hasShownApplyAlert;

- (void)setSpecifier:(PSSpecifier *)specifier {
    [self loadFromSpecifier:specifier];
    [super setSpecifier:specifier];
}


- (void)loadFromSpecifier:(PSSpecifier *)specifier {
	if (!_specifiers) {
		NSString *sub = [specifier propertyForKey:@"pageKey"];

		if ([sub isEqualToString:@"Title"]) {
			self.chosenLabels = [NSMutableArray arrayWithCapacity:4];
			[self.chosenLabels addObject:@"customTitleFontSize"];
			[self.chosenLabels addObject:@"customTitleOffSet"];
			[self.chosenLabels addObject:@"titleColor"];
			[self.chosenLabels addObject:@"titleBackgroundColor"];
			[self.chosenLabels addObject:@"titleBackgroundCornerRadius"];
		}

		_specifiers = [self loadSpecifiersFromPlistName:sub target:self];

		self.mySavedSpecifiers = (!self.mySavedSpecifiers) ? [[NSMutableDictionary alloc] init] : self.mySavedSpecifiers;
		for(PSSpecifier *specifier in [self specifiers]) {
			if([self.chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
			[self.mySavedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
		}
	}
}

- (void)viewWillAppear:(BOOL)animated {

	[[UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:1.00 green:0.94 blue:0.27 alpha:1.0]];
    [[UISwitch appearanceWhenContainedInInstancesOfClasses:@[self.class]] setOnTintColor:[UIColor colorWithRed:1.00 green:0.94 blue:0.27 alpha:1.0]];
    [[UISlider appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:1.00 green:0.94 blue:0.27 alpha:1.0]];

    [super viewWillAppear:animated];
}

-(void)viewDidLoad {
	[super viewDidLoad];
	//[self removeSegments];
	hasShownApplyAlert = NO;
	UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(apply:)];
    self.navigationItem.rightBarButtonItem = applyButton;
}

-(void)reloadSpecifiers {
	//[self removeSegments];
}

-(void)apply:(PSSpecifier *)specifier {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("xyz.burritoz.thomz.folded.prefs/reload"), nil, nil, true);
	   [self.view endEditing:YES]; //Hides the keyboard, if present -Burrit0z // omg thank you that was so annoying lmao
	   							   //Lmao no problem Thomz ;) -Burrit0z
         });
	
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

	if (!hasShownApplyAlert) {
		UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Folded"
								message:@"Your settings have been applied. Some settings, not many, may require a respring."
								preferredStyle:UIAlertControllerStyleAlert];
	
			UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cool!" style:UIAlertActionStyleDefault
			handler:^(UIAlertAction * action) {}];
	
			[alert addAction:defaultAction];
			[self presentViewController:alert animated:YES completion:nil];
			
			hasShownApplyAlert = YES;
	}
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
		[super setPreferenceValue:value specifier:specifier];

		preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

		for (int x = 0; x < [self.chosenLabels count]; x++) {

			NSString *key = [self.chosenLabels objectAtIndex:x];

			NSString *currentSpecifier = [preferences objectForKey:key];

			BOOL isCurrentEnabled = [[preferences objectForKey:key] boolValue];

			NSDictionary *tempDictionary = @{key: currentSpecifier};
			NSMutableDictionary *dict =  [NSMutableDictionary dictionary];
			[dict setDictionary:tempDictionary];

			if(!isCurrentEnabled){
				[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[key]] animated:YES];
			} else if(isCurrentEnabled && ![self containsSpecifier:self.mySavedSpecifiers[key]]) {
				[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[key]] afterSpecifierID:key animated:YES];
			}
		} 

}

-(void)removeSegments {
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];
	
	for (int x = 0; x < [self.chosenLabels count]; x++) {

		NSString *key = [self.chosenLabels objectAtIndex:x];

		NSString *currentSpecifier = [preferences objectForKey:key];

		BOOL isCurrentEnabled = [[preferences objectForKey:key] boolValue];

		NSDictionary *tempDictionary = @{key: currentSpecifier};
		NSMutableDictionary *dict =  [NSMutableDictionary dictionary];
		[dict setDictionary:tempDictionary];

		if(!isCurrentEnabled){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[key]] animated:YES];
		}
	}
/*
	if(!customTitleFontSizeEnabled){
		[self removeContiguousSpecifiers:@[self.chosenLabels[@"customTitleFontSize"]] animated:YES];
	}

	if(!customTitleOffSetEnabled){
		[self removeContiguousSpecifiers:@[self.chosenLabels[@"customTitleOffSet"]] animated:YES];
	}

	if(!titleColorEnabled){
		[self removeContiguousSpecifiers:@[self.chosenLabels[@"titleColor"]] animated:YES];
	}

	if(!titleBackgroundEnabled){
		[self removeContiguousSpecifiers:@[self.chosenLabels[@"titleBackgroundColor"], self.chosenLabels[@"titleBackgroundCornerRadius"]] animated:YES];
	} */

}

@end

@implementation KRLabeledSliderCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier 
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

    if (self)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15,15,200,20)];
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

@implementation Thomz_LabeledSegmentCell

- (instancetype)initWithStyle:(long long)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier 
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

    if (self)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15,5,200,20)];
        label.text = specifier.properties[@"label"];
        [self.contentView addSubview:label];
        [self.control setFrame:CGRectOffset(self.control.frame, 0, 15)];
    }

    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.control setFrame:CGRectOffset(self.control.frame, 0, 30)];
}
@end 


