#import <Foundation/Foundation.h>
//#import <UIKit/UIKitCore.h>
//Those two lines are only used when compiling via DragonBuild
//actually they make it uncompilable with theos
//i think my sdks are broken, why the hell UIKitCore is not found
//Dunno man.

#include <CSColorPicker/CSColorPicker.h>

#define PLIST_PATH @"/User/Library/Preferences/xyz.burritoz.thomz.folded.prefs.plist"
#define kIdentifier @"xyz.burritoz.thomz.folded.prefs.plist"
#define kSettingsPath @"/var/mobile/Library/Preferences/xyz.burritoz.thomz.folded.prefs.plist"
#define kSettingsChangedNotification (CFStringRef)@"xyz.burritoz.thomz.folded.prefs/reload"

inline NSString *StringForPreferenceKey(NSString *key) {
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] ? : [NSDictionary new];
    return prefs[key];
}

@interface SBIconController : UIAlertController
@end

@interface SBIconListGridLayoutConfiguration
@property (nonatomic, assign) BOOL isFolder;

- (BOOL)getLocations;
- (NSUInteger)numberOfPortraitColumns;
- (NSUInteger)numberOfPortraitRows;
@end

//I use this to change the folder icon on ios 12, and fix the crashes on ios 13
@interface SBIconGridImage
+(id)gridImageForLayout:(id)arg1 previousGridImage:(id)arg2 previousGridCellIndexToUpdate:(unsigned long long)arg3 pool:(id)arg4 cellImageDrawBlock:(id)arg5 ;
+(id)gridImageForLayout:(id)arg1 cellImageDrawBlock:(id)arg2 ;
+(id)gridImageForLayout:(id)arg1 pool:(id)arg2 cellImageDrawBlock:(id)arg3 ;
@end

@interface SBFloatyFolderView : UIView
-(void)layoutSubviews;
-(void)setBackgroundColor:(UIColor *)arg1;
-(UIColor *)randomColor;
@end

@interface SBFolderBackgroundMaterialSettings
-(UIColor *)randomColor;
@end

@interface SBFolderIconBackgroundView : UIView
@end

@interface SBFolderBackgroundView : UIView
-(void)layoutSubviews;
-(void)setBackgroundColor:(UIColor *)arg1;
@property (nonatomic, retain) UIVisualEffectView *lightView;
@property (nonatomic, retain) UIVisualEffectView *darkView;
@end

@interface SBFolderControllerBackgroundView : UIView
@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, assign) CGFloat aplha;
-(void)layoutSubviews;
@end

@interface SBWallpaperEffectView : UIView
@property (nonatomic, retain) UIView *blurView;
@end

@interface SBFolderIconImageView : UIView
@property (nonatomic, retain) SBWallpaperEffectView *backgroundView;
@property (nonatomic, assign) CGFloat aplha;
@property (nonatomic, assign) CGAffineTransform transform;
@end

@interface SBIconListPageControl : UIView
@property (nonatomic, assign) BOOL hidden;
@end

@interface _SBIconGridWrapperView : UIView
@property (nonatomic, assign) CGAffineTransform transform;
@end

@interface UITextFieldBorderView
@property (nonatomic, assign) BOOL hidden;
-(void)layoutSubviews;
@end

@class UITextField, UIFont;
@interface SBFolderTitleTextField : UITextField
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CGRect bounds;
@property (nonatomic, strong) UIFont *font;
-(void)setFont:(id)arg1 fullFontSize:(id)arg2 ambientOnly:(BOOL)arg3;
-(void)setTextCentersHorizontally:(BOOL)arg1;
-(void)layoutSubviews;
@end

// Defining global variables and methods

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
long long customLayoutRows;
long long customLayoutColumns;
BOOL hideTitleEnabled;
BOOL customTitleFontSizeEnabled;
double customTitleFontSize;
BOOL customTitleOffSetEnabled;
double customTitleOffSet;
BOOL customFolderIconEnabled;
long long folderIconRows;
long long folderIconColumns;
BOOL twoByTwoIconEnabled;
int titleFontWeight;
int titleAlignment;
BOOL titleColorEnabled;
NSString *titleColor;
BOOL titleBackgroundEnabled;
NSString *titleBackgroundColor;
double titleBackgroundCornerRadius;
BOOL titleBackgroundBlurEnabled;
BOOL showInjectionAlerts;
BOOL customBlurBackgroundEnabled;
int customBlurBackground;
BOOL folderBackgroundColorEnabled;
NSString *folderBackgroundColor;
BOOL customTitleFontEnabled;
NSString *customTitleFont;
BOOL seizureModeEnabled;
BOOL folderBackgroundBackgroundColorEnabled;
double backgroundAlphaColor;
NSString * folderBackgroundBackgroundColor;
BOOL randomColorBackgroundEnabled;
BOOL folderBackgroundColorWithGradientEnabled;
NSString *folderBackgroundColorWithGradient;
BOOL folderBackgroundColorWithGradientVerticalGradientEnabled; // bruh
BOOL hideFolderGridEnabled;

BOOL hasProcessLaunched;
BOOL hasInjectionFailed;
BOOL hasShownFailureAlert;

static void *observer = NULL;

static void reloadPrefs() {
    if ([NSHomeDirectory() isEqualToString:@"/var/mobile"]) {
        CFArrayRef keyList = CFPreferencesCopyKeyList((CFStringRef)kIdentifier, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);

        if (keyList) {
            preferences = (NSDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, (CFStringRef)kIdentifier, kCFPreferencesCurrentUser, kCFPreferencesAnyHost));

            if (!preferences) {
                preferences = [NSDictionary new];
            }
            CFRelease(keyList);
        }
    }
    else {
        preferences = [NSDictionary dictionaryWithContentsOfFile:kSettingsPath];
    }
}

static void prefsChanged() {
    CFPreferencesAppSynchronize((CFStringRef)kIdentifier);
    reloadPrefs();

	enabled = [preferences objectForKey:@"enabled"] ? [[preferences objectForKey:@"enabled"] boolValue] : YES;

	backgroundAlphaEnabled = [preferences objectForKey:@"backgroundAlphaEnabled"] ? 
				[[preferences objectForKey:@"backgroundAlphaEnabled"] boolValue] : NO;

	backgroundAlpha = [preferences objectForKey:@"backgroundAlpha"] ? [[preferences objectForKey:@"backgroundAlpha"] doubleValue] : 1;

	cornerRadiusEnabled = [preferences objectForKey:@"cornerRadiusEnabled"] ? 
				[[preferences objectForKey:@"cornerRadiusEnabled"] boolValue] : NO;

	cornerRadius = [preferences objectForKey:@"cornerRadius"] ? [[preferences objectForKey:@"cornerRadius"] doubleValue] : 30;

	pinchToCloseEnabled = [preferences objectForKey:@"pinchToCloseEnabled"] ? 
				[[preferences objectForKey:@"pinchToCloseEnabled"] boolValue] : NO;

	customFrameEnabled = [[preferences objectForKey:@"customFrameEnabled"] boolValue];

	customCenteredFrameEnabled = [[preferences objectForKey:@"customCenteredFrameEnabled"] boolValue];

	frameX = [preferences valueForKey:@"customFrameX"] ? [[preferences valueForKey:@"customFrameX"] floatValue] : 0;

	frameY = [preferences valueForKey:@"customFrameY"] ? [[preferences valueForKey:@"customFrameY"] floatValue] : 0;

	frameWidth = [preferences valueForKey:@"customFrameWidth"] ? [[preferences valueForKey:@"customFrameWidth"] floatValue] : 300;

	frameHeight = [preferences valueForKey:@"customFrameHeight"] ? [[preferences valueForKey:@"customFrameHeight"] floatValue] : 300;

	customLayoutEnabled = [preferences objectForKey:@"customLayoutEnabled"] ?
				[[preferences objectForKey:@"customLayoutEnabled"] boolValue] : NO;

	customLayoutRows = [preferences objectForKey:@"customLayoutRows"] ? 
				[[preferences objectForKey:@"customLayoutRows"] longLongValue] : 4;

	customLayoutColumns = [preferences objectForKey:@"customLayoutColumns"] ? 
				[[preferences objectForKey:@"customLayoutColumns"] longLongValue] : 4;

    hideTitleEnabled = [preferences objectForKey:@"hideTitleEnabled"] ? [[preferences objectForKey:@"hideTitleEnabled"] boolValue] : NO;

    customTitleFontSizeEnabled = [preferences objectForKey:@"customTitleFontSizeEnabled"] ? 
				[[preferences objectForKey:@"customTitleFontSizeEnabled"] boolValue] : NO;

    customTitleFontSize = [preferences objectForKey:@"customTitleFontSize"] ? 
				[[preferences objectForKey:@"customTitleFontSize"] doubleValue] : 36;

    customTitleOffSetEnabled = [preferences objectForKey:@"customTitleOffSetEnabled"] ? 
				[[preferences objectForKey:@"customTitleOffSetEnabled"] boolValue] : NO;

    customTitleOffSet = [preferences objectForKey:@"customTitleOffSet"] ? 
				[[preferences objectForKey:@"customTitleOffSet"] doubleValue] : 0;

	customFolderIconEnabled = [preferences objectForKey:@"customFolderIconEnabled"] ? 
				[[preferences objectForKey:@"customFolderIconEnabled"] boolValue] : NO;

    folderIconRows = [preferences objectForKey:@"folderIconRows"] ? [[preferences objectForKey:@"folderIconRows"] longLongValue] : 4;

	folderIconColumns = [preferences objectForKey:@"folderIconColumns"] ? 
				[[preferences objectForKey:@"folderIconColumns"] longLongValue] : 4;

	twoByTwoIconEnabled = ([preferences objectForKey:@"twoByTwoIconEnabled"] && kCFCoreFoundationVersionNumber < 1600) ? 
				[[preferences objectForKey:@"twoByTwoIconEnabled"] boolValue] : NO;

	titleFontWeight = [preferences objectForKey:@"titleFontWeight"] ? [[preferences objectForKey:@"titleFontWeight"] intValue] : 1;

	titleAlignment = [preferences objectForKey:@"titleAlignment"] ? [[preferences objectForKey:@"titleAlignment"] intValue] : 1;

	titleColorEnabled = [preferences objectForKey:@"titleColorEnabled"] ? [[preferences objectForKey:@"titleColorEnabled"] boolValue] : NO;

	titleColor = [preferences valueForKey:@"titleColor"];

	titleBackgroundEnabled = [preferences objectForKey:@"titleBackgroundEnabled"] ? 
				[[preferences objectForKey:@"titleBackgroundEnabled"] boolValue] : NO;

	titleBackgroundColor = [preferences valueForKey:@"titleBackgroundColor"];

	titleBackgroundCornerRadius = [preferences objectForKey:@"titleBackgroundCornerRadius"] ? 
				[[preferences objectForKey:@"titleBackgroundCornerRadius"] doubleValue] : 10;

	titleBackgroundBlurEnabled = [preferences objectForKey:@"titleBackgroundBlurEnabled"] ? 
				[[preferences objectForKey:@"titleBackgroundBlurEnabled"] boolValue] : NO;

	showInjectionAlerts = [preferences objectForKey:@"showInjectionAlerts"] ? 
				[[preferences objectForKey:@"showInjectionAlerts"] boolValue] : YES;

	customBlurBackgroundEnabled = [preferences objectForKey:@"customBlurBackgroundEnabled"] ? 
				[[preferences objectForKey:@"customBlurBackgroundEnabled"] boolValue] : NO;

	customBlurBackground = [preferences objectForKey:@"customBlurBackground"] ? 
				[[preferences objectForKey:@"customBlurBackground"] intValue] : 1;

	folderBackgroundColorEnabled = [preferences objectForKey:@"folderBackgroundColorEnabled"] ? 
				[[preferences objectForKey:@"folderBackgroundColorEnabled"] boolValue] : NO;

	folderBackgroundColor = [preferences valueForKey:@"folderBackgroundColor"];

	customTitleFontEnabled = [preferences valueForKey:@"customTitleFontEnabled"] ? 
				[[preferences valueForKey:@"customTitleFontEnabled"] boolValue] : NO;

	customTitleFont = [preferences valueForKey:@"customTitleFont"] ? [[preferences valueForKey:@"customTitleFont"] stringValue] : @"Helevicta-Neue";

	seizureModeEnabled = [preferences objectForKey:@"seizureModeEnabled"] ? 
				[[preferences objectForKey:@"seizureModeEnabled"] boolValue] : NO;

	folderBackgroundBackgroundColorEnabled = [preferences objectForKey:@"folderBackgroundBackgroundColorEnabled"] ? 
				[[preferences objectForKey:@"folderBackgroundBackgroundColorEnabled"] boolValue] : NO;

	backgroundAlphaColor = [preferences objectForKey:@"backgroundAlphaColor"]  ? 
				[[preferences objectForKey:@"backgroundAlphaColor"] doubleValue] : 1;
	
	folderBackgroundBackgroundColor = [preferences valueForKey:@"folderBackgroundBackgroundColor"];

	randomColorBackgroundEnabled = [preferences objectForKey:@"randomColorBackgroundEnabled"] ? 
				[[preferences objectForKey:@"randomColorBackgroundEnabled"] boolValue] : NO;

	folderBackgroundColorWithGradientEnabled = [preferences objectForKey:@"folderBackgroundColorWithGradientEnabled"] ? 
				[[preferences objectForKey:@"folderBackgroundColorWithGradientEnabled"] boolValue] : NO;

	folderBackgroundColorWithGradient = [preferences valueForKey:@"folderBackgroundColorWithGradient"];

	folderBackgroundColorWithGradientVerticalGradientEnabled = [preferences objectForKey:@"folderBackgroundColorWithGradientVerticalGradientEnabled"] ?
				[[preferences objectForKey:@"folderBackgroundColorWithGradientVerticalGradientEnabled"] boolValue] : NO;

	hideFolderGridEnabled = [preferences objectForKey:@"hideFolderGridEnabled"] ? 
				[[preferences objectForKey:@"hideFolderGridEnabled"] boolValue] : NO;
	
	NSLog(@"[Folded]: Prefs have been reloaded");


}
