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

	[[UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:0.06 green:0.56 blue:1.00 alpha:1.0]];
    [[UISwitch appearanceWhenContainedInInstancesOfClasses:@[self.class]] setOnTintColor:[UIColor colorWithRed:0.06 green:0.56 blue:1.00 alpha:1.0]];
    [[UISlider appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:0.06 green:0.56 blue:1.00 alpha:1.0]];

    [super viewWillAppear:animated];
}

-(void)viewDidLoad {
	[super viewDidLoad];
	hasShownApplyAlert = NO;

	UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(apply:)];
    self.navigationItem.rightBarButtonItem = applyButton;

	self.navigationItem.titleView = [UIView new];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,10,10)];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.text = @"Folded";
		self.titleLabel.alpha = 0.0;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.navigationItem.titleView addSubview:self.titleLabel];

        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,10,10)];
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconView.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/Folded.bundle/icon@3x.png"];
        self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
        self.iconView.alpha = 1.0;
        [self.navigationItem.titleView addSubview:self.iconView];

		[NSLayoutConstraint activateConstraints:@[
            [self.titleLabel.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
            [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
            [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
            [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],
            [self.iconView.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
            [self.iconView.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
            [self.iconView.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
            [self.iconView.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],
        ]];
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
		//If you get a deprecation error using DragonBuild and an ios > 10 sdk, modify the headers, its not recommended, but do it
}

-(void)linkReddit {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.reddit.com/user/Burrit0z_Dev"]];
}

-(void)linkTwitterBossgfx {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/bossgfx_"]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;

    if (offsetY > 125) {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 0.0;
            self.titleLabel.alpha = 1.0;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 1.0;
            self.titleLabel.alpha = 0.0;
        }];
    }
}

@end

@implementation Thomz_TwitterCell // lil copy of HBTwitterCell from Cephei
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier  {

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self)
    {
        UILabel *User = [[UILabel alloc] initWithFrame:CGRectMake(70,17.5,200,20)];
        [User setText:specifier.properties[@"user"]];
		[User setFont:[User.font fontWithSize:15]];

		UILabel *Description = [[UILabel alloc]initWithFrame:CGRectMake(70,35,200,20)];
		[Description setText:specifier.properties[@"description"]];
		[Description setFont:[Description.font fontWithSize:10]];

		NSBundle *bundle = [[NSBundle alloc]initWithPath:@"/Library/PreferenceBundles/Folded.bundle"];

		UIImage *profilePicture;
        profilePicture = [UIImage imageWithContentsOfFile:[bundle pathForResource:specifier.properties[@"image"] ofType:@"png"]];
		UIImageView *profilePictureView = [[UIImageView alloc] initWithImage:profilePicture];
		[profilePictureView setFrame:CGRectMake(12.5,15,40,40)];

        [self addSubview:User];
		[self addSubview:Description];
		[self addSubview:profilePictureView];
		
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

@implementation FoldedHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

    if (self) {
		UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(90,25,500,30)];
		[title setNumberOfLines:0];
		[title setText:@"Folded"];
		[title setFont:[UIFont systemFontOfSize:30]];

		UILabel *developers = [[UILabel alloc] initWithFrame:CGRectMake(90,55,500,20)];
		[developers setNumberOfLines:0];
		[developers setText:@"Folders, your way"];
		[developers setFont:[UIFont systemFontOfSize:15]];

		NSBundle *bundle = [[NSBundle alloc]initWithPath:@"/Library/PreferenceBundles/Folded.bundle"];
		UIImage *logo = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"fullSizedIcon" ofType:@"png"]];
		UIImageView *icon = [[UIImageView alloc]initWithImage:logo];
		[icon setFrame:CGRectMake(20,22.5,55,55)];

		[self addSubview:title];
		[self addSubview:developers];
		[self addSubview:icon];
	}

	return self;
}

@end
