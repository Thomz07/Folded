#include "OPERootListController.h"

@implementation OPERootListController

NSDictionary *preferences;

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

- (void)viewWillAppear:(BOOL)animated {

	[[UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:0.00 green:0.54 blue:1.00 alpha:1.00]];
    [[UISwitch appearanceWhenContainedInInstancesOfClasses:@[self.class]] setOnTintColor:[UIColor colorWithRed:0.00 green:0.54 blue:1.00 alpha:1.00]];
    [[UISlider appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:0.00 green:0.54 blue:1.00 alpha:1.00]];

    [super viewWillAppear:animated];
}

-(void)viewDidLoad {
	[super viewDidLoad];

	UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(apply:)];
    self.navigationItem.rightBarButtonItem = applyButton;

	self.navigationItem.titleView = [UIView new];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,10,10)];
        self.titleLabel.font = [UIFont systemFontOfSize:19];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.text = @"Folded";
		self.titleLabel.alpha = 0.0;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.navigationItem.titleView addSubview:self.titleLabel];

        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,10,10)];
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconView.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/Folded.bundle/icon@2x.png"];
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

		UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Pirated :("
								message:@"Why would you pirate a free tweak? Redownload Folded from repo.packix.com if you want to use it."
								preferredStyle:UIAlertControllerStyleAlert];

		if ([[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/xyz.burritoz.thomz.folded.list"]){
			// nothing
		} else {
			[self presentViewController:alert animated:YES completion:nil];
		}
}

-(void)apply:(PSSpecifier *)specifier {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("xyz.burritoz.thomz.folded.prefs/reload"), nil, nil, true);
	   [self.view endEditing:YES]; //Hides the keyboard, if present -Burrit0z // omg thank you that was so annoying lmao
	   							   //Lmao no problem Thomz ;) -Burrit0z
         });

	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Folded"
							message:@"Your settings have been applied. Some settings, not many, may require a respring. \n Would you like to respring as well?"
							preferredStyle:UIAlertControllerStyleActionSheet];

		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel
		handler:^(UIAlertAction * action) {}];
		UIAlertAction* yes = [UIAlertAction actionWithTitle:@"Respring" style:UIAlertActionStyleDestructive
		handler:^(UIAlertAction * action) {
			NSTask *t = [[NSTask alloc] init];
			[t setLaunchPath:@"usr/bin/killall"];
			[t setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
			[t launch];
		}];

		[alert addAction:defaultAction];
		[alert addAction:yes];
		[self presentViewController:alert animated:YES completion:nil];

}

-(void)resetPrefs:(id)sender {

	preferences = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];

	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Reset Preferences"
							message:@"Are you sure you want to reset all of your preferences? This action CANNOT be undone! Your device will respring."
							preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
		handler:^(UIAlertAction * action) {}];
		UIAlertAction* yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive
		handler:^(UIAlertAction * action) {
		
		NSUserDefaults *prefs = [[NSUserDefaults standardUserDefaults] init];
		[prefs removePersistentDomainForName:@"xyz.burritoz.thomz.folded.prefs"];	

		NSString *domain = @"/var/mobile/Library/Preferences/xyz.burritoz.thomz.folded.prefs.plist";
		[[NSUserDefaults standardUserDefaults] setObject:@NO forKey:@"enabled" inDomain:domain];	
		[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"enabled" inDomain:domain];		

		 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("xyz.burritoz.thomz.folded.prefs/reload"), nil, nil, true);
         });

		NSTask *f = [[NSTask alloc] init];
		[f setLaunchPath:@"/usr/bin/killall"];
		[f setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
		[f launch];
		}];

		[alert addAction:defaultAction];
		[alert addAction:yes];
		[self presentViewController:alert animated:YES completion:nil];
}

-(void)linkTwitter {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/Thomzi07"]];
		//If you get a deprecation error using DragonBuild and an ios > 10 sdk, modify the headers, its not recommended, but do it
}

-(void)linkReddit {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.reddit.com/user/Burrit0z_Dev"]];
}

-(void)openPayPalPool {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/pools/c/8nPzkVjCKn"]];
}

-(void)openGithub {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/Thomz07/Folded"]];
}

-(void)openPackix {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://repo.packix.com/package/xyz.burritoz.thomz.folded"]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;

    if (offsetY > 80) {
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

@implementation FoldedHeaderCell // Header Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(id)reuseIdentifier specifier:(id)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {
    
    packageNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,70,self.contentView.bounds.size.width+30,50)];
	[packageNameLabel setTextAlignment:NSTextAlignmentRight];
    [packageNameLabel setFont:[UIFont systemFontOfSize:50 weight: UIFontWeightSemibold] ];
    packageNameLabel.textColor = [UIColor whiteColor];
    packageNameLabel.text = @"Folded";
    
    developerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,30,self.contentView.bounds.size.width+30,50)];
	[developerLabel setTextAlignment:NSTextAlignmentRight];
    [developerLabel setFont:[UIFont systemFontOfSize:22.5 weight: UIFontWeightMedium] ];
    developerLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.85];
	developerLabel.alpha = 0.8;
    developerLabel.text = @"Thomz + Burrit0z";
    
    
    versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,110,self.contentView.bounds.size.width+30,50)];
	[versionLabel setTextAlignment:NSTextAlignmentRight];
    [versionLabel setFont:[UIFont systemFontOfSize:22 weight: UIFontWeightMedium] ];
    versionLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
	versionLabel.alpha = 0.8;
    versionLabel.text = @"1.0.5";

	NSBundle *bundle = [[NSBundle alloc]initWithPath:@"/Library/PreferenceBundles/Folded.bundle"];
	UIImage *phone = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"headerPhone" ofType:@"png"]];
	UIImageView *phoneImage = [[UIImageView alloc]initWithImage:phone];
	[phoneImage setFrame:CGRectMake(20,0,120,174)];
    
    bgView.backgroundColor = [UIColor colorWithRed:0.46 green:0.72 blue:0.84 alpha:1.0];
    
    [self addSubview:packageNameLabel];
    [self addSubview:developerLabel];
    [self addSubview:versionLabel];
	[self addSubview:phoneImage];

    }
    	return self;

}

- (instancetype)initWithSpecifier:(PSSpecifier *)specifier {
	return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MultiplaHeaderCell" specifier:specifier];
}

- (void)setFrame:(CGRect)frame {
	frame.origin.x = 0;
	[super setFrame:frame];
}

- (CGFloat)preferredHeightForWidth:(CGFloat)arg1{
    return 200.0f;
}


-(void)layoutSubviews{
	[super layoutSubviews];

    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, 200)];

    UIColor *topColor = [UIColor colorWithRed: 0.00 green: 0.42 blue: 1.00 alpha: 1.00];
    UIColor *bottomColor = [UIColor colorWithRed: 0.00 green: 0.64 blue: 1.00 alpha: 1.00];

    CAGradientLayer *theViewGradient = [CAGradientLayer layer];
    theViewGradient.colors = [NSArray arrayWithObjects: (id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    theViewGradient.startPoint = CGPointMake(0.5, 0.0);
    theViewGradient.endPoint = CGPointMake(0.5, 1.0);
    theViewGradient.frame = bgView.bounds;

    //Add gradient to view
    [bgView.layer insertSublayer:theViewGradient atIndex:0];
    [self insertSubview:bgView atIndex:0];

}


- (CGFloat)preferredHeightForWidth:(CGFloat)width inTableView:(id)tableView {
	return [self preferredHeightForWidth:width];
}

@end
