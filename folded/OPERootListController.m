#include "OPERootListController.h"

@implementation OPERootListController

NSDictionary *preferences;
BOOL hasShownApplyAlert;

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

- (void)viewWillAppear:(BOOL)animated {

	[[UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:1.00 green:0.94 blue:0.27 alpha:1.0]];
    [[UISwitch appearanceWhenContainedInInstancesOfClasses:@[self.class]] setOnTintColor:[UIColor colorWithRed:1.00 green:0.94 blue:0.27 alpha:1.0]];
    [[UISlider appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:1.00 green:0.94 blue:0.27 alpha:1.0]];

    [super viewWillAppear:animated];
}

-(void)viewDidLoad {
	[super viewDidLoad];
	hasShownApplyAlert = NO;
	UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(apply:)];
    self.navigationItem.rightBarButtonItem = applyButton;
}

-(void)apply:(PSSpecifier *)specifier {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("xyz.burritoz.thomz.folded.prefs/reload"), nil, nil, true);
	   [self.view endEditing:YES]; //Hides the keyboard, if present -Burrit0z // omg thank you that was so annoying lmao
	   							   //Lmao no problem Thomz ;) -Burrit0z
         });
	
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

	if (!hasShownApplyAlert) {
		UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Folded"
								message:@"Your settings have been applied. Some settings, not many, may require a respring."
								preferredStyle:UIAlertControllerStyleAlert];
	
			UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cool!" style:UIAlertActionStyleDefault
			handler:^(UIAlertAction * action) {}];
	
			[alert addAction:defaultAction];
			[self presentViewController:alert animated:YES completion:nil];
			
			hasShownApplyAlert = YES;
	}
}

-(void)linkTwitter {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/Thomzi07"]];
}

-(void)linkReddit {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.reddit.com/user/Burrit0z_Dev"]];
}

-(void)linkTwitterBossgfx {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/bossgfx_"]];
}

@end

@implementation Thomz_TwitterCell // lil copy of HBTwitterCell from Cephei
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier  {

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self)
    {
        UILabel *User = [[UILabel alloc] initWithFrame:CGRectMake(80,20,200,20)];
        [User setText:specifier.properties[@"user"]];
		[User setFont:[User.font fontWithSize:15]];

		UILabel *Description = [[UILabel alloc]initWithFrame:CGRectMake(80,40,200,20)];
		[Description setText:specifier.properties[@"description"]];
		[Description setFont:[Description.font fontWithSize:10]];

		NSBundle *bundle = [[NSBundle alloc]initWithPath:@"/Library/PreferenceBundles/Folded.bundle"];

		UIImage *profilePicture; 
        profilePicture = [UIImage imageWithContentsOfFile:[bundle pathForResource:specifier.properties[@"image"] ofType:@"png"]];
		UIImageView *profilePictureView = [[UIImageView alloc] initWithImage:profilePicture];
		[profilePictureView setFrame:CGRectMake(12.5,17.5,41.25,41.25)];

		UIImage *twitter;
		twitter = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"twitter" ofType:@"png"]];
		UIImageView *twitterIcon = [[UIImageView alloc] initWithImage:twitter];
		twitterIcon.image = [twitterIcon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		[twitterIcon setTintColor:[UIColor colorWithRed:1.00 green:0.94 blue:0.27 alpha:1.0]];
		[twitterIcon setFrame:CGRectMake((self.bounds.size.width) + 20,32.5,15,15)];

		UIImage *reddit;
		reddit = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"reddit" ofType:@"png"]];
		UIImageView *redditIcon = [[UIImageView alloc] initWithImage:reddit];
		redditIcon.image = [redditIcon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		[redditIcon setTintColor:[UIColor colorWithRed:1.00 green:0.94 blue:0.27 alpha:1.0]];
		[redditIcon setFrame:CGRectMake((self.bounds.size.width) + 20,30,20,20)];

        [self addSubview:User];
		[self addSubview:Description];
		[self addSubview:profilePictureView];
		if([specifier.properties[@"reddit"] isEqual:@"true"]){
			[self addSubview:redditIcon];
		} else {
			[self addSubview:twitterIcon];
		}
    }

    return self;
}

@end

@implementation Burrit0z_TitleCell //A temporary one

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

    if (self) {
	
	}
	
	return self;
}
@end