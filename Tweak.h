@interface SBFloatyFolderView : UIView
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
BOOL customBiggerLayoutEnabled;
unsigned long long customBiggerLayoutRows;
unsigned long long customBiggerLayoutColumns;

static void reloadPrefs(){
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"com.burritoz.thomz.folded.prefs"];
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
	customBiggerLayoutEnabled = [[preferences objectForKey:@"customBiggerLayoutEnabled"] boolValue];
	customBiggerLayoutRows = [[preferences valueForKey:@"customBiggerLayoutRows"] unsignedLongLongValue];
	customBiggerLayoutColumns = [[preferences valueForKey:@"customBiggerLayoutColumns"] unsignedLongLongValue];
}
