#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

@interface OPERootListController : PSListController
@property (nonatomic, retain) NSMutableDictionary *mySavedSpecifiers;
@end

@interface PSListController (iOS12Plus)
-(BOOL)containsSpecifier:(id)arg1;
@end
