#import <Preferences/PSListController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListItemsController.h>
#import <Preferences/PSSliderTableCell.h>
//#import <Preferences/PSSegmentTableCell.h>

@interface OPESubPageController : PSListController
@property (nonatomic, retain) NSMutableArray *chosenLabels;
@property (nonatomic, retain) NSMutableDictionary *mySavedSpecifiers;
@property (nonatomic, assign) NSString *sub;
-(void)removeSegments;
@end

@interface PSListController (iOS12Plus)
-(BOOL)containsSpecifier:(id)arg1;
@end

@interface KRLabeledSliderCell : PSSliderTableCell
@end

@interface Thomz_LabeledSegmentCell : PSTableCell
@end
