#include "OPERootListController.h"

@implementation OPERootListController

NSDictionary *preferences;
BOOL backgroundAlphaEnabled;
BOOL cornerRadiusEnabled;
BOOL customCenteredFrameEnabled;
BOOL customLayoutEnabled;
BOOL customFolderIconEnabled;

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];

		NSArray *chosenLabels = @[@"backgroundAlpha",@"cornerRadius",@"customFrameX",@"customFrameY", @"customLayoutRows", @"customLayoutColumns", @"folderIconRows", @"folderIconColumns"];
		self.mySavedSpecifiers = (!self.mySavedSpecifiers) ? [[NSMutableDictionary alloc] init] : self.mySavedSpecifiers;
		for(PSSpecifier *specifier in [self specifiers]) {
			if([chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
			[self.mySavedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
		}
	}

	return _specifiers;
}

- (void)viewWillAppear:(BOOL)animated {

	[UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[self.class]].tintColor = [UIColor colorWithRed:0.93 green:0.76 blue:0.07 alpha:1.0];
    [[UISwitch appearanceWhenContainedInInstancesOfClasses:@[self.class]] setOnTintColor:[UIColor colorWithRed:0.93 green:0.76 blue:0.07 alpha:1.0]];
    [[UISlider appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:0.93 green:0.76 blue:0.07 alpha:1.0]];

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
	   [self.view endEditing:YES];
         });
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
		[super setPreferenceValue:value specifier:specifier];

		preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];
		backgroundAlphaEnabled = [[preferences objectForKey:@"backgroundAlphaEnabled"] boolValue];
		cornerRadiusEnabled = [[preferences objectForKey:@"cornerRadiusEnabled"] boolValue];
		customCenteredFrameEnabled = [[preferences objectForKey:@"customCenteredFrameEnabled"] boolValue];
		customLayoutEnabled = [[preferences objectForKey:@"customLayoutEnabled"] boolValue];
		customFolderIconEnabled = [[preferences objectForKey:@"customFolderIconEnabled"] boolValue];

		if(!backgroundAlphaEnabled){
         	[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"backgroundAlpha"]] animated:YES];
		} else if(backgroundAlphaEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"backgroundAlpha"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"backgroundAlpha"]] afterSpecifierID:@"Background Alpha" animated:YES];
		}

		if(!cornerRadiusEnabled){
         	[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"cornerRadius"]] animated:YES];
		} else if(cornerRadiusEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"cornerRadius"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"cornerRadius"]] afterSpecifierID:@"Corner Radius" animated:YES];
		}

		if(customCenteredFrameEnabled){
         	[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customFrameX"], self.mySavedSpecifiers[@"customFrameY"]] animated:YES];
		} else if(!customCenteredFrameEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customFrameX"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"customFrameY"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customFrameX"], self.mySavedSpecifiers[@"customFrameY"]] afterSpecifierID:@"Centered Frame" animated:YES];
		}

		if(!customLayoutEnabled){
         	[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customLayoutRows"], self.mySavedSpecifiers[@"customLayoutColumns"]] animated:YES];
		} else if(customLayoutEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"customLayoutRows"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"customLayoutColumns"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customLayoutRows"], self.mySavedSpecifiers[@"customLayoutColumns"]] afterSpecifierID:@"Enable Custom Layout" animated:YES];
		}

		if(!customFolderIconEnabled){
         	[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderIconRows"], self.mySavedSpecifiers[@"folderIconColumns"]] animated:YES];
		} else if(customFolderIconEnabled && ![self containsSpecifier:self.mySavedSpecifiers[@"folderIconRows"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"folderIconColumns"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderIconRows"], self.mySavedSpecifiers[@"folderIconColumns"]] afterSpecifierID:@"Custom Folder Grid" animated:YES];
		}

}

-(void)removeSegments {
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];
	backgroundAlphaEnabled = [[preferences objectForKey:@"backgroundAlphaEnabled"] boolValue];
	cornerRadiusEnabled = [[preferences objectForKey:@"cornerRadiusEnabled"] boolValue];
	customCenteredFrameEnabled = [[preferences objectForKey:@"customCenteredFrameEnabled"] boolValue];
	customLayoutEnabled = [[preferences objectForKey:@"customLayoutEnabled"] boolValue];
	customFolderIconEnabled = [[preferences objectForKey:@"customFolderIconEnabled"] boolValue];

	if(!backgroundAlphaEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"backgroundAlpha"]] animated:YES];
	}

	if(!cornerRadiusEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"cornerRadius"]] animated:YES];
	}

	if(customCenteredFrameEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customFrameX"], self.mySavedSpecifiers[@"customFrameY"]] animated:YES];
	}

	if(!customLayoutEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customLayoutRows"], self.mySavedSpecifiers[@"customLayoutColumns"]] animated:YES];
	}

	if(!customFolderIconEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"folderIconRows"], self.mySavedSpecifiers[@"folderIconColumns"]] animated:YES];
	}

}

@end
