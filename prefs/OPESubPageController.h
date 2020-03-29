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
