#import <Preferences/PSListController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListItemsController.h>
#import <Preferences/PSSliderTableCell.h>
//#import <Preferences/PSSegmentTableCell.h>

@interface OPESubPageController : PSListController
@property (nonatomic, strong) NSMutableArray *chosenLabels;
@property (nonatomic, strong) NSMutableDictionary *mySavedSpecifiers;
@property (nonatomic, assign) NSString *sub;
@end

@interface PSListController (iOS12Plus)
-(BOOL)containsSpecifier:(id)arg1;
@end

@interface KRLabeledSliderCell : PSSliderTableCell
@end

@interface ThomzScreenSizeCell : PSTableCell
@end

@interface getThomzAniPhone2 : PSTableCell
@end

@interface NSTask : NSObject
@property(copy) NSArray *arguments;
@property(copy) NSString *launchPath;
- (id)init;
- (void)launch;
@end

@interface TartinePreviewCell : PSTableCell
@end

@interface _UICustomBlurEffect : UIBlurEffect
@property (assign,nonatomic) double grayscaleTintLevel; 
@property (assign,nonatomic) double grayscaleTintAlpha; 
@property (assign,nonatomic) bool lightenGrayscaleWithSourceOver; 
@property (nonatomic,retain) UIColor* colorTint; 
@property (assign,nonatomic) double colorTintAlpha; 
@property (assign,nonatomic) double colorBurnTintLevel; 
@property (assign,nonatomic) double colorBurnTintAlpha; 
@property (assign,nonatomic) double darkeningTintAlpha; 
@property (assign,nonatomic) double darkeningTintHue; 
@property (assign,nonatomic) double darkeningTintSaturation; 
@property (assign,nonatomic) bool darkenWithSourceOver; 
@property (assign,nonatomic) double blurRadius; 
@property (assign,nonatomic) double saturationDeltaFactor; 
@property (assign,nonatomic) double scale; 
@property (assign,nonatomic) double zoom;
@end
