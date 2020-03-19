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

//DO NOT USE THESE NEXT TWO INTERFACES, THEY ARE MOSTLY INACCURATE, SAME ONES I USED IN CARTELLA
@interface SBWallpaperEffectView : UIView
@property (nonatomic, retain) UIView *blurView;
@end

@interface SBFolderIconImageView : UIView
@property (nonatomic, retain) SBWallpaperEffectView *backgroundView; //This isn't really what the headers say...
@property (nonatomic, assign) CGFloat aplha;
@end

//////////////////

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
BOOL customTitleXOffSetEnabled;
double customTitleXOffSet;
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
BOOL hideFolderIconBackground;

BOOL hasProcessLaunched;
BOOL hasInjectionFailed;
BOOL hasShownFailureAlert;