#import <Preferences/PSListController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListItemsController.h>
#import <Preferences/PSSliderTableCell.h>

@interface OPESubPageController : PSListController
@end

@interface NSTask : NSObject
@property(copy) NSArray *arguments;
@property(copy) NSString *launchPath;
- (id)init;
- (void)launch;
@end
