#include "OPERootListController.h"

@implementation OPERootListController

NSDictionary *preferences;
BOOL backgroundAlphaEnabled;
BOOL cornerRadiusEnabled;
BOOL customCenteredFrameEnabled;
BOOL customLayoutEnabled;
BOOL customTitleFontSizeEnabled;
BOOL customTitleOffSetEnabled;

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];

		NSArray *chosenLabels = @[@"backgroundAlpha",@"cornerRadius",@"customFrameX",@"customFrameY", @"customLayoutRows", @"customLayoutColumns", @"customTitleFontSize",@"customTitleOffSet"];
		self.mySavedSpecifiers = (!self.mySavedSpecifiers) ? [[NSMutableDictionary alloc] init] : self.mySavedSpecifiers;
		for(PSSpecifier *specifier in [self specifiers]) {
			if([chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
			[self.mySavedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
		}
	}

	return _specifiers;
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
         });
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
		[super setPreferenceValue:value specifier:specifier];

		preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];
		backgroundAlphaEnabled = [[preferences objectForKey:@"backgroundAlphaEnabled"] boolValue];
		cornerRadiusEnabled = [[preferences objectForKey:@"cornerRadiusEnabled"] boolValue];
		customCenteredFrameEnabled = [[preferences objectForKey:@"customCenteredFrameEnabled"] boolValue];
		customLayoutEnabled = [[preferences objectForKey:@"customLayoutEnabled"] boolValue];
		customTitleFontSizeEnabled = [[preferences objectForKey:@"customTitleFontSizeEnabled"] boolValue];
		customTitleOffSetEnabled = [[preferences objectForKey:@"customTitleOffSetEnabled"] boolValue];

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

}

-(void)removeSegments {
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];
	backgroundAlphaEnabled = [[preferences objectForKey:@"backgroundAlphaEnabled"] boolValue];
	cornerRadiusEnabled = [[preferences objectForKey:@"cornerRadiusEnabled"] boolValue];
	customCenteredFrameEnabled = [[preferences objectForKey:@"customCenteredFrameEnabled"] boolValue];
	customLayoutEnabled = [[preferences objectForKey:@"customLayoutEnabled"] boolValue];
	customTitleFontSizeEnabled = [[preferences objectForKey:@"customTitleFontSizeEnabled"] boolValue];
	customTitleOffSetEnabled = [[preferences objectForKey:@"customTitleOffSetEnabled"] boolValue];

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

	if(!customTitleFontSizeEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFontSize"]] animated:YES];
	}

	if(!customTitleOffSetEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleOffSet"]] animated:YES];
	}

}

@end
