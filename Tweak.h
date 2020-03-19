#import <Foundation/Foundation.h>
//#import <UIKit/UIKitCore.h>
//Those two lines are only used when compiling via DragonBuild
//actually they make it uncompilable with theos
//i think my sdks are broken, why the hell UIKitCore is not found

#include <CSColorPicker/CSColorPicker.h>

#define PLIST_PATH @"/User/Library/Preferences/xyz.burritoz.thomz.folded.prefs.plist"
NSDictionary *prefs = nil;

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
BOOL enabled = YES;
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
BOOL clearBackgroundIcons;
BOOL customWallpaperBlurEnabled;
double customWallpaperBlurFactor;
BOOL tapToCloseEnabled;
BOOL customTitleBoxWidthEnabled;
double customTitleBoxWidth;
BOOL customTitleBoxHeightEnabled;
double customTitleBoxHeight;

BOOL hasProcessLaunched;
BOOL hasInjectionFailed;
BOOL hasShownFailureAlert;

/*
//Reloading the prefs (duh) 
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
	customLayoutRows = [[preferences objectForKey:@"customLayoutRows"] longLongValue];
	customLayoutColumns = [[preferences objectForKey:@"customLayoutColumns"] longLongValue];
    hideTitleEnabled = [[preferences objectForKey:@"hideTitleEnabled"] boolValue];
    customTitleFontSizeEnabled = [[preferences objectForKey:@"customTitleFontSizeEnabled"] boolValue];
    customTitleFontSize = [[preferences objectForKey:@"customTitleFontSize"] doubleValue];
    customTitleOffSetEnabled = [[preferences objectForKey:@"customTitleOffSetEnabled"] boolValue];
    customTitleOffSet = [[preferences objectForKey:@"customTitleOffSet"] doubleValue];
	customFolderIconEnabled = [[preferences objectForKey:@"customFolderIconEnabled"] boolValue];
    folderIconRows = [[preferences objectForKey:@"folderIconRows"] longLongValue];
	folderIconColumns = [[preferences objectForKey:@"folderIconColumns"] longLongValue];
	twoByTwoIconEnabled = [[preferences objectForKey:@"twoByTwoIconEnabled"] boolValue];
	titleFontWeight = [[preferences objectForKey:@"titleFontWeight"] intValue];
	titleAlignment = [[preferences objectForKey:@"titleAlignment"] intValue];
	titleColorEnabled = [[preferences objectForKey:@"titleColorEnabled"] boolValue];
	titleColor = [preferences valueForKey:@"titleColor"];
	titleBackgroundEnabled = [[preferences objectForKey:@"titleBackgroundEnabled"] boolValue];
	titleBackgroundColor = [preferences valueForKey:@"titleBackgroundColor"];
	titleBackgroundCornerRadius = [[preferences objectForKey:@"titleBackgroundCornerRadius"] doubleValue];
	titleBackgroundBlurEnabled = [[preferences objectForKey:@"titleBackgroundBlurEnabled"] boolValue];
	showInjectionAlerts = [[preferences objectForKey:@"showInjectionAlerts"] boolValue];
	customBlurBackgroundEnabled = [[preferences objectForKey:@"customBlurBackgroundEnabled"] boolValue];
	customBlurBackground = [[preferences objectForKey:@"customBlurBackground"] intValue];
	folderBackgroundColorEnabled = [[preferences objectForKey:@"folderBackgroundColorEnabled"] boolValue];
	folderBackgroundColor = [preferences valueForKey:@"folderBackgroundColor"];
	customTitleFontEnabled = [[preferences valueForKey:@"customTitleFontEnabled"] boolValue];
	customTitleFont = [[preferences valueForKey:@"customTitleFont"] stringValue];
	seizureModeEnabled = [[preferences objectForKey:@"seizureModeEnabled"] boolValue];
	folderBackgroundBackgroundColorEnabled = [[preferences objectForKey:@"folderBackgroundBackgroundColorEnabled"] boolValue];
	backgroundAlphaColor = [[preferences objectForKey:@"backgroundAlphaColor"] doubleValue];
	folderBackgroundBackgroundColor = [preferences valueForKey:@"folderBackgroundBackgroundColor"];
	randomColorBackgroundEnabled = [[preferences objectForKey:@"randomColorBackgroundEnabled"] boolValue];
	folderBackgroundColorWithGradientEnabled = [[preferences objectForKey:@"folderBackgroundColorWithGradientEnabled"] boolValue];
	folderBackgroundColorWithGradient = [preferences valueForKey:@"folderBackgroundColorWithGradient"];
	folderBackgroundColorWithGradientVerticalGradientEnabled = [[preferences objectForKey:@"folderBackgroundColorWithGradientVerticalGradientEnabled"] boolValue];
	hideFolderGridEnabled = [[preferences objectForKey:@"hideFolderGridEnabled"] boolValue];
}*/