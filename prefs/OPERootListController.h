#import <Preferences/PSListController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListItemsController.h>
#import <Preferences/PSSliderTableCell.h>

@interface OPERootListController : PSListController{
        UITableView * _table;
}
@property (nonatomic, strong) NSMutableDictionary *mySavedSpecifiers;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconView;
@end

@interface PSListController (iOS12Plus)
-(BOOL)containsSpecifier:(id)arg1;
@end

@interface Thomz_TwitterCell : PSTableCell
@end

@interface FoldedHeaderCell : PSTableCell
@end

@interface getThomzAniPhone : PSTableCell
@end

@interface NSTask : NSObject
@property(copy) NSArray *arguments;
@property(copy) NSString *launchPath;
- (id)init;
- (void)waitUntilExit;
- (void)launch;
@end