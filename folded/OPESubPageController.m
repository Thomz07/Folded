#include "OPESubPageController.h"

@implementation OPESubPageController

NSDictionary *preferences;
BOOL customTitleFontSizeEnabled;
BOOL customTitleOffSetEnabled;
BOOL titleColorEnabled;
BOOL titleBackgroundEnabled;

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
	[self removeSegments];
	UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(apply:)];
    self.navigationItem.rightBarButtonItem = applyButton;
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
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
		[super setPreferenceValue:value specifier:specifier];

		preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

		for (int x = 0; x < [self.chosenLabels count]; x++) {

			id key = [self.chosenLabels objectAtIndex:x];

			id currentSpecifier = [preferences objectForKey:key];

			BOOL isCurrentEnabled = [currentSpecifier boolValue];

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

		id key = [self.chosenLabels objectAtIndex:x];

		id currentSpecifier = [preferences objectForKey:key];

		BOOL isCurrentEnabled = [currentSpecifier boolValue];

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
