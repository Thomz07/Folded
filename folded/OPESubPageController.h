#import <Preferences/PSListController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListItemsController.h>
#import <Preferences/PSSliderTableCell.h>
//#import <Preferences/PSSegmentTableCell.h>

@interface OPESubPageController : PSListController
@property (nonatomic, retain) NSMutableArray *chosenLabels;
@property (nonatomic, retain) NSMutableDictionary *mySavedSpecifiers;
@end

@interface PSListController (iOS12Plus)
-(BOOL)containsSpecifier:(id)arg1;
@end

@interface KRLabeledSliderCell : PSSliderTableCell
@end

@interface PSSegmentTableCell : PSControlTableCell {
    NSDictionary * _titleDict;
    NSArray * _values;
}


- (bool)canReload;
- (id)controlValue;
- (id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2 specifier:(id)arg3;
- (void)layoutSubviews;
- (id)newControl;
- (void)prepareForReuse;
- (void)refreshCellContentsWithSpecifier:(id)arg1;
- (void)setValue:(id)arg1;
- (void)setValues:(id)arg1 titleDictionary:(id)arg2;
- (id)titleLabel;

@end

@interface Thomz_LabeledSegmentCell : PSSegmentTableCell
@end
