#include "Tweak.h"

%group universal
%hook SBFloatyFolderView

-(void)setBackgroundAlpha:(double)arg1 { // returning the value from the slider cell in the settings for the bg alpha

	if(enabled && backgroundAlphaEnabled){
		%orig(backgroundAlpha);
	}
}

-(void)setCornerRadius:(double)arg1 { // returning the value from the slider cell in the settings for the corner radius

	if(enabled && cornerRadiusEnabled){
		%orig(cornerRadius);
	}
}

-(CGRect)_frameForScalingView { // modyfing the frame with the values from the settings

//Ok thomz, we need to rewrite this, there are issues with it.

if(enabled && customFrameEnabled){
		if(customCenteredFrameEnabled){
			return CGRectMake((self.bounds.size.width - frameWidth)/2, (self.bounds.size.height - frameHeight)/2,frameWidth,frameHeight); // simple calculation to center things
		} else if(!customCenteredFrameEnabled){
			if(frameWidth == 0 || frameHeight == 0){
				return %orig;
			} else {
				return CGRectMake(frameX,frameY,frameWidth,frameHeight);
			}
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

%hook SBIconListPageControl

-(void)layoutSubviews {

	%orig;
	if(enabled && hideDotsPref==2 && isInAFolder ) { // not working (look below thomz :D)
		self.hidden = 1; //now this works :D
		isInAFolder = NO;
	} else if(enabled && hideDotsPref==3) {
		self.hidden=1;
	} else {
		return %orig;
	}

}

%end

%hook SBFolderBackgroundMaterialSettings

-(UIColor *)baseOverlayColor { // this effect looks so sweet

	UIColor *color = [UIColor cscp_colorFromHexString:folderBackgroundBackgroundColor];

	if(enabled && folderBackgroundBackgroundColorEnabled && !randomColorBackgroundEnabled){
		return color;
	} else if(enabled && folderBackgroundBackgroundColorEnabled && randomColorBackgroundEnabled){
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

	isInAFolder = YES;

	%orig;

	UIColor *color = [UIColor cscp_colorFromHexString:titleColor];

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

	if (enabled && customTitleFontEnabled) {
    	[self setFont:[UIFont fontWithName:customTitleFont size:(self.font.pointSize)]];
	}

	CGFloat modifiedOriginX = self.frame.origin.x; //yeah, theres a reason this is frame and not bounds
	CGFloat modifiedOriginY = self.bounds.origin.y;

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

	if(enabled && (customTitleOffSetEnabled || customTitleXOffSetEnabled)) {
		[self setFrame: CGRectMake(
			modifiedOriginX,
			modifiedOriginY,
			self.bounds.size.width,
			self.bounds.size.height
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
	if(resizeFolderIconEnabled) {
		CGAffineTransform originalIconView = (self.transform);
		self.transform = CGAffineTransformMake(
			resizeFactor,
			originalIconView.b,
			originalIconView.c,
			resizeFactor,
			originalIconView.tx,
			originalIconView.ty
		);
	} else if((twoByTwoIconEnabled || (folderIconColumns==2 && folderIconRows==2))&& kCFCoreFoundationVersionNumber > 1600) {
		CGAffineTransform originalIconView = (self.transform);
		self.transform = CGAffineTransformMake(
			1.5,
			originalIconView.b,
			originalIconView.c,
			1.5,
			originalIconView.tx,
			originalIconView.ty
		);
	}
}

%end


%hook SBFolderBackgroundView
%property (nonatomic, retain) UIVisualEffectView *lightView;
%property (nonatomic, retain) UIVisualEffectView *darkView;
%property (nonatomic, retain) UIView *backgroundColorFrame;
%property (nonatomic, retain) CAGradientLayer *gradient;
-(void)layoutSubviews {

	%orig;

    self.lightView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
	self.lightView.frame = self.bounds;
	self.darkView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
	self.darkView.frame = self.bounds;
	self.backgroundColorFrame = [[UIView alloc] initWithFrame:self.bounds];
	UIColor *backgroundColor = [UIColor cscp_colorFromHexString:folderBackgroundColor];
	[self.backgroundColorFrame setBackgroundColor:backgroundColor];

	NSArray<id> *gradientColors = [StringForPreferenceKey(@"folderBackgroundColorWithGradient") cscp_gradientStringCGColors];

	self.gradient = [CAGradientLayer layer];
    self.gradient.frame = self.bounds;

	if(!folderBackgroundColorWithGradientVerticalGradientEnabled){
		self.gradient.startPoint = CGPointMake(0, 0.5);
		self.gradient.endPoint = CGPointMake(1, 0.5);
	} else if(folderBackgroundColorWithGradientVerticalGradientEnabled) {
		self.gradient.startPoint = CGPointMake(0.5, 0);
        self.gradient.endPoint = CGPointMake(0.5, 1);
	}

	self.gradient.colors = gradientColors;

	if(enabled && customBlurBackgroundEnabled && customBlurBackground == 1){
		MSHookIvar<UIVisualEffectView *>(self, "_blurView") = self.lightView;
		[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[self addSubview:self.lightView];

		if(kCFCoreFoundationVersionNumber > 1600) {
			if(cornerRadiusEnabled) {
				[self.lightView.layer setCornerRadius:cornerRadius];
			} else {
				[self.lightView.layer setCornerRadius:38];
			}
		}
	}

	if(enabled && customBlurBackgroundEnabled && customBlurBackground == 2){
		MSHookIvar<UIVisualEffectView *>(self, "_blurView") = self.darkView;
		[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[self addSubview:self.darkView];

		if(kCFCoreFoundationVersionNumber > 1600) {
			if(cornerRadiusEnabled) {
				[self.darkView.layer setCornerRadius:cornerRadius];
			} else {
				[self.darkView.layer setCornerRadius:38];
			}
		}
	}

	if(enabled && folderBackgroundColorEnabled){
		[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[self addSubview:self.backgroundColorFrame];

		if(kCFCoreFoundationVersionNumber > 1600) {
			if(cornerRadiusEnabled) {
				[self.backgroundColorFrame.layer setCornerRadius:cornerRadius];
			} else {
				[self.backgroundColorFrame.layer setCornerRadius:38];
			}
		}
	}
	if(enabled &&  folderBackgroundColorWithGradientEnabled){
		[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[self.layer insertSublayer:self.gradient atIndex:0];

		if(kCFCoreFoundationVersionNumber > 1600) {
			if(cornerRadiusEnabled) {
				[self.gradient setCornerRadius:cornerRadius];
			} else {
				[self.gradient setCornerRadius:38];
			}
		}
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

//Here is just the way we resize the icon spacing in 2x2 mode, meaning it looks just like it should, and won't be excessively small

+ (CGSize)cellSpacing {
    CGSize orig = %orig;
    if(enabled && twoByTwoIconEnabled){	
		return CGSizeMake(orig.width * 1.5, orig.height);
	} else {return %orig;}
}
//////////
//This method used to be at leas 3 times the size. I've simplified it to this

+(id)gridImageForLayout:(id)arg1 previousGridImage:(id)arg2 previousGridCellIndexToUpdate:(unsigned long long)arg3 pool:(id)arg4 cellImageDrawBlock:(id)arg5 {
  //I figured out the hard way that this is in fact a class method, and not an instance method.
  //This means we can't use instance logic to save the individual icon cache. However, this makes it
  //even easier, because all we need to do is store the working original value in one variable!
  //It will save the preview of all folder icons! In one neat variable package!
  if (enabled) {
		@try{
			return %orig;
			lastIconSucess = %orig;
		} @catch (NSException *exception) {
			NSLog(@"[Folded]: The following exception was caught:%@", exception);
			return lastIconSucess;
		}
  } else {
	return %orig;
  }
}

///////////////////

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

%hook SBIconListFlowLayout

-(unsigned long long)maximumIconCount { //Yes. This damn method is what prevented the addition of icons beyond what the folder icon was.
										//That's because, like the folder icon SBIconListGridLayoutConfiguration, this cannot be dynamically
										//adjusted. So, I hook it initially to allow for the extra icons.
	unsigned long long original = %orig;

	if(enabled && customFolderIconEnabled && ((original==9) || (original==folderIconRows*folderIconColumns))) {
		return(customLayoutRows*customLayoutColumns);
	} else {
		return %orig;
	}
}

%end


//This part is crucial to my methods :devil_face:
%hook SBIconController

-(void)viewDidAppear:(BOOL)arg1 {
  %orig;

  hasProcessLaunched = YES;

  UIAlertController* blankIconAlert = [UIAlertController alertControllerWithTitle:@"Folded"
                               message:@"Folded has blanked out some folder icons due to you editing icons in a folder (respring to fix.) Please note Folded has prevented a crash that would have occured due to this."
                               preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
   		handler:^(UIAlertAction * action) {}];

		[blankIconAlert addAction:dismiss];

  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Folded"
                               message:@"Folded has failed to inject a custom folder icon layout. This is due to another tweak interfering with Folded, or due to you editing icons in a folder (respring to fix.) Please note Folded has prevented a crash that would have occured due to this."
                               preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
   		handler:^(UIAlertAction * action) {}];

		[alert addAction:defaultAction];

  if (enabled && hasInjectionFailed && showInjectionAlerts && (!hasShownFailureAlert)) {
		[self presentViewController:alert animated:YES completion:nil];
	  hasShownFailureAlert = YES;
  }
  if(enabled && showInjectionAlerts && blankIconAlertShouldShow) {
	  [self presentViewController:blankIconAlert animated:YES completion:nil];
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
  //I rewrote this so many times, and ended up with this insanley dumb and long, but rock solid method
  //DON'T QUESTION IT. JUST DON'T!

    if (self.isFolder && enabled && (customLayoutEnabled || customFolderIconEnabled)) {
		if (customFolderIconEnabled && customLayoutEnabled) {
			if (hasProcessLaunched) { 
				return (customLayoutColumns);
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
		} else if(!customLayoutEnabled && customFolderIconEnabled) {
			if (!hasProcessLaunched) {
				@try {
						return (folderIconColumns);
					} @catch (NSException *exception) {
					return %orig;
					hasInjectionFailed = YES;
					}
			}
		}
  } else {
    return (%orig);
  }
}

-(NSUInteger)numberOfPortraitRows {
  [self getLocations];
    if (self.isFolder && enabled && (customLayoutEnabled || customFolderIconEnabled)) {
		if (customFolderIconEnabled && customLayoutEnabled) {
			if (hasProcessLaunched) { 
				return (customLayoutRows);
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
		} else if(!customLayoutEnabled && customFolderIconEnabled) {
			if (!hasProcessLaunched) {
				@try {
						return (folderIconRows);
					} @catch (NSException *exception) {
					return %orig;
					hasInjectionFailed = YES;
					}
			}
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
	if(kCFCoreFoundationVersionNumber < 1600){
		%init(ios12);
	} else {
		%init(ios13);
	}
	NSLog(@"[Folded]: Tweak initialized.");
}


//Well, that's all for now, folks! It's been awesome working with Thomz, I hope to make more tweaks with him!
//yeet :)
//Ah, I see you're a man of culture as well.