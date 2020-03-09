@interface SBFloatyFolderView : UIView
@end

@interface SBFolderTitleTextField : UIView
@end

// Defining global variables and methods
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

// Preferences keys
NSDictionary *preferences;
BOOL enabled;
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
int customLayoutRows;
int customLayoutColumns;
BOOL hideTitleEnabled;
BOOL customTitleFontSizeEnabled;
double customTitleFontSize;
BOOL customTitleOffSetEnabled;
double customTitleOffSet;

static void reloadPrefs(){
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];
	enabled = [[preferences objectForKey:@"enabled"] boolValue];
	backgroundAlphaEnabled = [[preferences objectForKey:@"backgroundAlphaEnabled"] boolValue];
	backgroundAlpha = [[preferences objectForKey:@"backgroundAlpha"] doubleValue];
	cornerRadiusEnabled = [[preferences objectForKey:@"cornerRadiusEnabled"] boolValue];
	cornerRadius = [[preferences objectForKey:@"cornerRadius"] doubleValue];
	pinchToCloseEnabled = [[preferences objectForKey:@"pinchToCloseEnabled"] boolValue];
	customFrameEnabled = [[preferences objectForKey:@"customFrameEnabled"] boolValue];
	customCenteredFrameEnabled = [[preferences objectForKey:@"customCenteredFrameEnabled"] boolValue];
	frameX = [[preferences valueForKey:@"customFrameX"] floatValue];
	frameY = [[preferences valueForKey:@"customFrameY"] floatValue];
	frameWidth = [[preferences valueForKey:@"customFrameWidth"] floatValue];
	frameHeight = [[preferences valueForKey:@"customFrameHeight"] floatValue];
	customLayoutEnabled = [[preferences objectForKey:@"customLayoutEnabled"] boolValue];
	customLayoutRows = [[preferences objectForKey:@"customLayoutRows"] intValue];
	customLayoutColumns = [[preferences objectForKey:@"customLayoutColumns"] intValue];
    hideTitleEnabled = [[preferences objectForKey:@"hideTitleEnabled"] boolValue];
    customTitleFontSizeEnabled = [[preferences objectForKey:@"customTitleFontSizeEnabled"] boolValue];
    customTitleFontSize = [[preferences objectForKey:@"customTitleFontSize"] doubleValue];
    customTitleOffSetEnabled = [[preferences objectForKey:@"customTitleOffSetEnabled"] boolValue];
    customTitleOffSet = [[preferences objectForKey:@"customTitleOffSet"] doubleValue];
}