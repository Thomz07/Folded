#import <Preferences/PSListController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListItemsController.h>

@interface OPESubPageController : PSListController
@property (nonatomic, retain) NSMutableDictionary *chosenLabels;
@property (nonatomic, retain) NSArray *recievedLabels;
@end

@interface PSListController (iOS12Plus)
-(BOOL)containsSpecifier:(id)arg1;
@end
