#import <Preferences/PSListController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>

@interface TitleRootListController : PSListController
@property (nonatomic, retain) NSMutableDictionary *mySavedSpecifiers;
@end

@interface PSListController (iOS12Plus)
-(BOOL)containsSpecifier:(id)arg1;
@end