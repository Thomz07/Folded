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
		return CGRectMake(original.origin.x,(original.origin.y)-customTitleOffSet,original.size.width,original.size.height); // everything original except the y
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

+ (unsigned long long)maxVisibleIconRowsInterfaceOrientation:(long long)arg1 { // return a number depending on the position of the segment cell, i'm too lazy to make it return directly the number from the cell lmao

	if(enabled && customLayoutEnabled){
		if(customLayoutRows == 0){
			return 1;
		} else if(customLayoutRows == 1){
			return 2;
		} else if(customLayoutRows == 2){
			return 3;
		} else if(customLayoutRows == 3){
			return 4;
		} else if(customLayoutRows == 4){
			return 5;
		} else if(customLayoutRows == 5){
			return 6;
		} else if(customLayoutRows == 6){
			return 7;
		} else {return %orig;}
	} else {return %orig;}
}

+ (unsigned long long)iconColumnsForInterfaceOrientation:(long long)arg1 { // same for columns

	if(enabled && customLayoutEnabled){
		if(customLayoutColumns == 0){
			return 1;
		} else if(customLayoutColumns == 1){
			return 2;
		} else if(customLayoutColumns == 2){
			return 3;
		} else if(customLayoutColumns == 3){
			return 4;
		} else if(customLayoutColumns == 4){
			return 5;
		} else if(customLayoutColumns == 5){
			return 6;
		} else if(customLayoutColumns == 6){
			return 7;
		} else {return %orig;}
	} else {return %orig;}
}

%end
%end

%ctor{ // reloading prefs
	reloadPrefs();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, CFSTR("xyz.burritoz.thomz.folded.prefs/reload"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	%init(SBFloatyFolderView);
	%init(SBFolderTitleTextField);
	if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"13.0")){
		%init(pinchToClose13);
	} else {
		%init(pinchToClose12);
		%init(layout12);
	}
}