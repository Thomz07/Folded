#include "TitleRootListController.h"

@implementation TitleRootListController

NSDictionary *preferences;
BOOL customTitleFontSizeEnabled;
BOOL customTitleOffSetEnabled;
BOOL titleColorEnabled;

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Title" target:self];

		NSArray *chosenLabels = @[@"customTitleFontSize", @"customTitleOffSet", @"titleColor"];
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
		customTitleFontSizeEnabled = [[preferences objectForKey:@"customTitleFontSizeEnabled"] boolValue];
		customTitleOffSetEnabled = [[preferences objectForKey:@"customTitleOffSetEnabled"] boolValue];
		titleColorEnabled = [[preferences objectForKey:@"titleColorEnabled"] boolValue];

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

}

-(void)removeSegments {
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];
	customTitleFontSizeEnabled = [[preferences objectForKey:@"customTitleFontSizeEnabled"] boolValue];
	customTitleOffSetEnabled = [[preferences objectForKey:@"customTitleOffSetEnabled"] boolValue];
	titleColorEnabled = [[preferences objectForKey:@"titleColorEnabled"] boolValue];

	if(!customTitleFontSizeEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFontSize"]] animated:YES];
	}

	if(!customTitleOffSetEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleOffSet"]] animated:YES];
	}

	if(!titleColorEnabled){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"titleColor"]] animated:YES];
	}

}

@end
