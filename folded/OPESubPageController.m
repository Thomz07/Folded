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

		//NSString *location = [sub stringByAppendingString:@".txt"];
		//NSString *contents = [NSString stringWithContentsOfFile:location encoding:NSUTF8StringEncoding error:nil];

    	//self.recievedLabels = [contents componentsSeparatedByString:@","];
		//NSUInteger count = [_recievedLabels count];
		//self.chosenLabels = [NSDictionary dictionaryWithObjects:nil forKeys:self.recievedLabels count:count];

		//NSArray *chosenLabels = @[@"customTitleFontSize", @"customTitleOffSet", @"titleColor", @"titleBackgroundColor", @"titleBackgroundCornerRadius"];

		_specifiers = [self loadSpecifiersFromPlistName:sub target:self];

		/*self.chosenLabels = (!self.chosenLabels) ? [[NSMutableDictionary alloc] init] : self.chosenLabels;
		for(PSSpecifier *specifier in [self specifiers]) {
			if([chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
				self.chosenLabels setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
		}*/
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
}
/*
-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
		[super setPreferenceValue:value specifier:specifier];

		preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

		for (int x = 0; x < [self.recievedLabels count]; x++) {
			[self.chosenLabels setObject:([[preferences objectForKey:[[self.recievedLabels] objectAtIndex:x]] boolValue]) 
																forKey:[[self.recievedLabels] objectAtIndex:x]];

			if(![self.chosenLabels objectForKey:[self.recievedLabels objectAtIndex:x]]){
				[self removeContiguousSpecifiers:@[self.recievedLabels objectAtIndex:x] animated:YES];
			} else if([self.chosenLabels objectForKey:[self.recievedLabels objectAtIndex:x]]) {
				[self insertContiguousSpecifiers:c afterSpecifierID:[[self.recievedLabels] objectAtIndex:x] animated:YES];
			}
		}

}

-(void)removeSegments {
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

	for (int x = 0; x < [self.recievedLabels count]; x++) {
			[self.chosenLabels setObject:([[preferences objectForKey:[[self.recievedLabels] objectAtIndex:x]] boolValue]) 
																forKey:[[self.recievedLabels] objectAtIndex:x]];

			[self removeContiguousSpecifiers:@[self.recievedLabels objectAtIndex:x] animated:YES];
		}

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
	}

} */

@end
