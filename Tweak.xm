#include "Tweak.h"

%group SBFloatyFolderView
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

%end
%end

%group SBFolderTitleTextField
%hook SBFolderTitleTextField

-(CGRect)textRectForBounds:(CGRect)arg1 { // title offset
	
	CGRect original = %orig;

	if(enabled && customTitleOffSetEnabled){
		return CGRectMake(
			original.origin.x,
			(original.origin.y)-customTitleOffSet,
			original.size.width,
			original.size.height
		    ); // everything original except the y
	} else {return original;}
}

%end
%end

%group pinchToClose12
%hook SBFolderSettings

-(BOOL)pinchToClose { // enable pinch to close 

	if(enabled && pinchToCloseEnabled){
		return YES;
	} else {
		return NO;
	}
}

%end
%end

%group pinchToClose13
%hook SBHFolderSettings

-(BOOL)pinchToClose { // enable pinch to close again

	if(enabled && pinchToCloseEnabled){
		return YES;
	} else {
		return NO;
	}
}

%end
%end

%group layout12
%hook SBFolderIconListView

+ (unsigned long long)maxVisibleIconRowsInterfaceOrientation:(long long)arg1 {
	/* NOTE: 
	Thomz said: // return a number depending on the position of the segment cell, 
	i'm too lazy to make it return directly the number from the cell lmao

	Well guess what? I adjusted it for you, and saved a lot of lines :P */

	if(enabled && customLayoutEnabled){
		return (customLayoutRows);
	} else {return %orig;}
}

+ (unsigned long long)iconColumnsForInterfaceOrientation:(long long)arg1 { // same for columns

	if(enabled && customLayoutEnabled){
    	return (customLayoutColumns);
	} else {return %orig;}
}

%end
%end

%group layout13

//This part is crucial to my method :devil_face:
%hook SBIconController

-(void)viewDidAppear:(BOOL)arg1 {
  %orig;
  hasProcessLaunched = YES;

  if (hasInjectionFailed && !hasShownFailureAlert) {
	  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Folded"
                               message:@"Folded has failed to inject a custom folder icon layout. This is due to aother tweak interfering with Folded. Please note Cartella has prevented a crash that would have occured due to this."
                               preferredStyle:UIAlertControllerStyleAlert];
 
		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
   		handler:^(UIAlertAction * action) {}];
 
		[alert addAction:defaultAction];
		[self presentViewController:alert animated:YES completion:nil];
                hasShownFailureAlert = YES;
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
    if (hasProcessLaunched) {
    return (folderColumns);
    } else {
      @try {
      return (folderIconColumns);
      } @catch (NSException *exception) {
      return folderColumns;
	  hasInjectionFailed = YES;
      }
    }
  } else {
    return (%orig);
  }
}

-(NSUInteger)numberOfPortraitRows {
  [self getLocations];
  if (self.isFolder && enabled) {
    if (hasProcessLaunched) {
    return (folderRows);
    } else {
      @try {
      return (folderIconRows);
      } @catch (NSException *exception) {
      return folderRows;
	  hasInjectionFailed = YES;
      }
    }
  } else {
    return (%orig);
  }
}

%end
%end

%hook universalIconControl

%hook SBIconGridImage

//ios 12 stuff
-(NSUInteger)numberOfColumns {
  return folderIconColumns;
}

-(NSUInteger)numberOfCells {
  return (folderIconColumns*folderIconRows);
}

-(NSUInteger)numberOfRows {
  return folderIconRows;
}
///

//Haha this next part is my genius method of stopping SpringBoard crashes!
//Ngl surprised my dumb self thought of this. :D
+(id)gridImageForLayout:(id)arg1 previousGridImage:(id)arg2 previousGridCellIndexToUpdate:(unsigned long long)arg3 pool:(id)arg4 cellImageDrawBlock:(id)arg5 {
  @try {
    return %orig;
  } @catch (NSException *exception) {
    return nil;
  }
}
+(id)gridImageForLayout:(id)arg1 cellImageDrawBlock:(id)arg2 {
  @try {
    return %orig;
  } @catch (NSException *exception) {
    return nil;
  }
}

+(id)gridImageForLayout:(id)arg1 pool:(id)arg2 cellImageDrawBlock:(id)arg3 {
  @try {
    return %orig;
  } @catch (NSException *exception) {
    return nil;
  }
}

%end
%end

%ctor{ // reloading prefs
	reloadPrefs();
	hasProcessLaunched = NO;
	hasInjectionFailed = NO;
        hasShownFailureAlert = NO;

	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, CFSTR("xyz.burritoz.thomz.folded.prefs/reload"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	
	%init(SBFloatyFolderView);
	%init(SBFolderTitleTextField);
	%init(universalIconControl);
	if(kCFCoreFoundationVersionNumber < 1600)){
		%init(pinchToClose12);
		%init(layout12);
	} else {
		%init(pinchToClose13);
		%init(layout13);
	}
}
