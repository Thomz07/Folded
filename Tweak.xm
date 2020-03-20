#include "Tweak.h"

%group universal
%hook SBFloatyFolderView

-(void)setBackgroundAlpha:(double)arg1 { // returning the value from the slider cell in the settings for the bg alpha

	if(enabled && backgroundAlphaEnabled){
		return %orig(backgroundAlpha);
	}
}

-(void)setCornerRadius:(double)arg1 { // returning the value from the slider cell in the settings for the corner radius

	if(enabled && cornerRadiusEnabled){
		return %orig(cornerRadius);
	}
}

-(CGRect)_frameForScalingView { // modyfing the frame with the values from the settings

	if(enabled && customFrameEnabled){
		if(customCenteredFrameEnabled){
			return CGRectMake((self.bounds.size.width - frameWidth)/2, (self.bounds.size.height - frameHeight)/2,frameWidth,frameHeight); // simple calculation to center things
		} else if(!customCenteredFrameEnabled){
			return CGRectMake(frameX,frameY,frameWidth,frameHeight);
		} else {return %orig;}
	} else {return %orig;}
}

-(BOOL)_showsTitle { // simply hide the title

	if(enabled && hideTitleEnabled){
		return NO;
	} else {
		return YES;
	}
}

-(double)_titleFontSize { // return the value from the slider for the font size

	if(enabled && customTitleFontSizeEnabled){
		return customTitleFontSize;
	} else {return %orig;}
}

-(void)scrollViewDidScroll:(id)arg1 {
	if(enabled && seizureModeEnabled){
		[self setBackgroundColor:[self randomColor]];
	}
}

-(BOOL)_tapToCloseGestureRecognizer:(id)arg1 shouldReceiveTouch:(id)arg2 {
  %orig;
  if (enabled && tapToCloseEnabled) {
    return (YES); //This lets the tap recognizer recieve touch everywhere, even on the folder background itself.
  } else {
    return %orig;
  }
}

%new
- (UIColor *)randomColor {

	int r = arc4random_uniform(256);
	int g = arc4random_uniform(256);
	int b = arc4random_uniform(256);

	return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

%end

%hook SBFolderBackgroundMaterialSettings

-(UIColor *)baseOverlayColor { // this effect looks so sweet

	UIColor *color = [UIColor cscp_colorFromHexString:folderBackgroundBackgroundColor];

	if(enabled && folderBackgroundBackgroundColorEnabled){
		return color;
	} else if(enabled && randomColorBackgroundEnabled){
		return [self randomColor];
	} else {return %orig;}
}

-(double)baseOverlayTintAlpha {

	if(enabled && folderBackgroundBackgroundColorEnabled){
		return backgroundAlphaColor;
	} else if(enabled && randomColorBackgroundEnabled){
		return backgroundAlphaColor;
	} else {return %orig;}
}

%new
- (UIColor *)randomColor {

	int r = arc4random_uniform(256);
	int g = arc4random_uniform(256);
	int b = arc4random_uniform(256);

	return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

%end

%hook SBFolderTitleTextField

-(void)layoutSubviews {

	%orig;

	UIColor *color = [UIColor cscp_colorFromHexString:titleColor];
	UIColor *color2 = [UIColor cscp_colorFromHexString:titleBackgroundColor];

	if(enabled && titleFontWeight == 1){
		// nothing
	} else if(enabled && titleFontWeight == 2){
		[self setFont:[UIFont systemFontOfSize:(self.font.pointSize)]]; // for some reason, systemFontOfSize is bigger than the title font
	} else if(enabled && titleFontWeight == 3){
		[self setFont:[UIFont boldSystemFontOfSize:(self.font.pointSize)]];
	}

	if(enabled && titleAlignment == 1){
		[self setTextAlignment:NSTextAlignmentLeft];
	} else if(enabled && titleAlignment == 2){
		// nothing
	} else if(enabled && titleAlignment == 3){
		[self setTextAlignment:NSTextAlignmentRight];
	}

	if(enabled && titleColorEnabled){
		[self setTextColor:color];
	}

	if(enabled && titleBackgroundEnabled){
		[self setBackgroundColor:color2];
		[self.layer setMasksToBounds:true];
		[self.layer setCornerRadius:titleBackgroundCornerRadius];
	}

	if (enabled && customTitleFontEnabled) {
    	[self setFont:[UIFont fontWithName:customTitleFont size:(self.font.pointSize)]];
	}

	CGFloat modifiedOriginX = self.frame.origin.x; //yeah, theres a reason this is frame and not bounds
	CGFloat modifiedOriginY = self.bounds.origin.y;
	CGFloat modifiedWidth = self.bounds.size.width;
	CGFloat modifiedHeight = self.bounds.size.height;

	if(enabled && customTitleXOffSetEnabled) {
		modifiedOriginX = customTitleXOffSet;
	} else {
		modifiedOriginX = self.frame.origin.x;
	}

	if(enabled && customTitleOffSetEnabled){
		modifiedOriginY = (modifiedOriginY + customTitleOffSet);
	} else {
		modifiedOriginY = self.bounds.origin.y;
	}

	if(enabled && customTitleBoxWidthEnabled) {
		modifiedWidth = customTitleBoxWidth;
	} else {
		modifiedWidth = self.bounds.size.width;
	}

	if(enabled && customTitleBoxHeightEnabled) {
		modifiedHeight = customTitleBoxHeight;
	} else {
		modifiedHeight = self.bounds.size.height;
	}

	if(enabled && (customTitleBoxWidthEnabled || customTitleBoxHeightEnabled || customTitleOffSetEnabled || customTitleXOffSetEnabled)) {
		[self setFrame: CGRectMake(
			modifiedOriginX,
			modifiedOriginY,
			modifiedWidth,
			modifiedHeight
		)];
	}

}

%end

%hook _SBIconGridWrapperView

-(void)layoutSubviews {
    %orig;
    if(enabled && hideFolderGridEnabled){
		[self setHidden:true];
	}
}

%end


%hook SBFolderBackgroundView
%property (nonatomic, retain) UIVisualEffectView *lightView;
%property (nonatomic, retain) UIVisualEffectView *darkView;
-(void)layoutSubviews {

	%orig;

    self.lightView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
	self.lightView.frame = self.bounds;
	self.darkView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
	self.darkView.frame = self.bounds;
	UIView *backgroundColorFrame = [[UIView alloc] initWithFrame:self.bounds];
	UIColor *backgroundColor = [UIColor cscp_colorFromHexString:folderBackgroundColor];
	[backgroundColorFrame setBackgroundColor:backgroundColor];

	NSArray<id> *gradientColors = [StringForPreferenceKey(@"folderBackgroundColorWithGradient") cscp_gradientStringCGColors];

	CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;

	if(!folderBackgroundColorWithGradientVerticalGradientEnabled){
		gradient.startPoint = CGPointMake(0, 0.5);
		gradient.endPoint = CGPointMake(1, 0.5);
	} else if(folderBackgroundColorWithGradientVerticalGradientEnabled) {
		gradient.startPoint = CGPointMake(0.5, 0);
        gradient.endPoint = CGPointMake(0.5, 1);
	}

	gradient.colors = gradientColors;

	if(enabled && customBlurBackgroundEnabled && customBlurBackground == 1){
		MSHookIvar<UIVisualEffectView *>(self, "_blurView") = self.lightView;
		[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[self addSubview:self.lightView];
	}

	if(enabled && customBlurBackgroundEnabled && customBlurBackground == 2){
		MSHookIvar<UIVisualEffectView *>(self, "_blurView") = self.darkView;
		[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[self addSubview:self.darkView];
	}

	if(enabled && folderBackgroundColorEnabled && !folderBackgroundColorWithGradientEnabled){
		[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[self addSubview:backgroundColorFrame];
	} else if(enabled && folderBackgroundColorEnabled && folderBackgroundColorWithGradientEnabled){
		[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[self.layer insertSublayer:gradient atIndex:0];
	}
}
%end

%hook SBFolderController
-(BOOL)_homescreenAndDockShouldFade {
  if (enabled && clearBackgroundIcons) {
    return YES;
  } else {
    return %orig;
  }
}
%end

%hook SBFolderControllerBackgroundView

-(void)layoutSubviews {
    %orig;
	if (enabled && customWallpaperBlurEnabled) self.alpha = customWallpaperBlurFactor;
}

%end

%end

%group ios12
%hook SBFolderSettings

-(BOOL)pinchToClose { // enable pinch to close

	if(enabled && pinchToCloseEnabled){
		return YES;
	} else {
		return NO;
	}
}

%end

%hook SBIconBlurryBackgroundView

-(BOOL)isBlurring {
  if (enabled && hideFolderIconBackground) {
    return NO;
  } else {
    return %orig;
  }
}

%end

%hook SBFolderIconListView // layout for iOS 12

+ (unsigned long long)maxVisibleIconRowsInterfaceOrientation:(long long)arg1 {

	if(enabled && customLayoutEnabled){
		return (customLayoutRows);
	} else {return %orig;}
}

+ (unsigned long long)iconColumnsForInterfaceOrientation:(long long)arg1 {

	if(enabled && customLayoutEnabled){
    	return (customLayoutColumns);
	} else {return %orig;}
}

%end

%hook SBIconGridImage

+ (unsigned long long)numberOfColumns {

	if(enabled && twoByTwoIconEnabled){
		return 2;
	} else {return %orig;}
}

+ (unsigned long long)numberOfRowsForNumberOfCells:(unsigned long long)arg1 {

	if(enabled && twoByTwoIconEnabled){
		return 2;
	} else {return %orig;}
}

+ (CGSize)cellSize {
    CGSize orig = %orig;
	if(enabled && twoByTwoIconEnabled){
		return CGSizeMake(orig.width * 1.5, orig.height);
	} else {return %orig;}
}

+ (CGSize)cellSpacing {
    CGSize orig = %orig;
    if(enabled && twoByTwoIconEnabled){
		return CGSizeMake(orig.width * 1.5, orig.height);
	} else {return %orig;}
}

%end

%hook SBFolderIconImageView

-(void)layoutSubviews { //I'm sorry for using layoutSubviews, there's probably a better way
  %orig; //I want to run the original stuff first
  if (enabled && hideFolderIconBackground) {
    self.backgroundView.alpha = 0;
    self.backgroundView.hidden = 1;
  }
}

%end

///////////////
%end

%group ios13

%hook SBIconGridImage

-(NSUInteger)numberOfColumns {
	if(enabled && customFolderIconEnabled){
  		return folderIconColumns;
  	} else {return %orig;}
}

-(NSUInteger)numberOfCells {
	if(enabled && customFolderIconEnabled){
  		return (folderIconColumns*folderIconRows);
  	} else {return %orig;}
}

-(NSUInteger)numberOfRows {
	if(enabled && customFolderIconEnabled){
  		return folderIconRows;
  	} else {return %orig;}
}
///

//Haha this next part is my genius method of stopping SpringBoard crashes!
//Ngl surprised my dumb self thought of this. :D
+(id)gridImageForLayout:(id)arg1 previousGridImage:(id)arg2 previousGridCellIndexToUpdate:(unsigned long long)arg3 pool:(id)arg4 cellImageDrawBlock:(id)arg5 {
  if (enabled) {
	@try {
		return %orig;
	} @catch (NSException *exception) {
		return nil;
	}
  } else {
	  return %orig;
  }
}
+(id)gridImageForLayout:(id)arg1 cellImageDrawBlock:(id)arg2 {
  if (enabled) {
	@try {
		return %orig;
	} @catch (NSException *exception) {
		return nil;
	}
  } else {
	  return %orig;
  }
}

+(id)gridImageForLayout:(id)arg1 pool:(id)arg2 cellImageDrawBlock:(id)arg3 {
  if (enabled) {
	@try {
		return %orig;
	} @catch (NSException *exception) {
		return nil;
	}
  } else {
	  return %orig;
  }
}

%end

%hook SBHFolderSettings

-(BOOL)pinchToClose { // enable pinch to close again

	if(enabled && pinchToCloseEnabled){
		return YES;
	} else {
		return NO;
	}
}

%end

//This part is crucial to my method :devil_face:
%hook SBIconController

-(void)viewDidAppear:(BOOL)arg1 {
  %orig;

  hasProcessLaunched = YES;

  if (hasInjectionFailed && showInjectionAlerts && !hasShownFailureAlert) {
	  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Folded"
                               message:@"Folded has failed to inject a custom folder icon layout. This is due to another tweak interfering with Folded. Please note Folded has prevented a crash that would have occured due to this."
                               preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
   		handler:^(UIAlertAction * action) {}];

		[alert addAction:defaultAction];
		[self presentViewController:alert animated:YES completion:nil];
                hasShownFailureAlert = YES;
  }

}

%end

%hook SBFolderIconImageView

-(void)layoutSubviews { //I'm sorry for using layoutSubviews, there's probably a better way
  %orig; //I want to run the original stuff first
  if (enabled && hideFolderIconBackground) {
    self.backgroundView.alpha = 0;
    self.backgroundView.hidden = 1;
  }
}

%end

%hook SBIconListGridLayoutConfiguration
%property (nonatomic, assign) BOOL isFolder;

%new
-(BOOL)getLocations {

  NSUInteger locationColumns = MSHookIvar<NSUInteger>(self, "_numberOfPortraitColumns");
  NSUInteger locationRows = MSHookIvar<NSUInteger>(self, "_numberOfPortraitRows");
  if (locationColumns == 3 && locationRows == 3) {
    self.isFolder = YES;
  } else {
    self.isFolder = NO;
  }
  return self.isFolder;
}

-(NSUInteger)numberOfPortraitColumns {
  [self getLocations];
    if (self.isFolder && enabled) {
		if (customFolderIconEnabled) {
			if (hasProcessLaunched) {
				return (customLayoutColumns != nil) ? (customLayoutColumns) : %orig;
			} else {
				@try {
					return (folderIconColumns);
				} @catch (NSException *exception) {
				return %orig;
				hasInjectionFailed = YES;
				}	
			}
		} else if(customLayoutEnabled && !customFolderIconEnabled) {
			return customLayoutColumns;
		}
  } else {
    return (%orig);
  }
}

-(NSUInteger)numberOfPortraitRows {
  [self getLocations];
    if (self.isFolder && enabled) {
		if (customFolderIconEnabled) {
			if (hasProcessLaunched) {
				return (customLayoutRows != nil) ? (customLayoutRows) : %orig;
			} else {
				@try {
					return (folderIconRows);
				} @catch (NSException *exception) {
				return %orig;
				hasInjectionFailed = YES;
				}	
			}
		} else if(customLayoutEnabled && !customFolderIconEnabled) {
			return customLayoutRows;
		}
  } else {
    return (%orig);
  }
}

%end

%end

%ctor
{
    preferencesChanged();

    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        &observer,
        (CFNotificationCallback)preferencesChanged,
        kSettingsChangedNotification,
        NULL,
        CFNotificationSuspensionBehaviorDeliverImmediately
    );
	hasProcessLaunched = NO;
	hasInjectionFailed = NO;
    hasShownFailureAlert = NO;
	%init(universal);
	//if(kCFCoreFoundationVersionNumber < 1600){
	//	%init(ios12);
	//} else {
	//	%init(ios13);
	//}
	%init(ios12);
	%init(ios13);
	
	NSLog(@"[Folded]: Tweak initialized.");
}


//Well, that's all for now, folks! It's been awesome working with Thomz, I hope to make more tweaks with him!
//yeet :)
//Ah, I see you're a man of culture as well.
