#include "Tweak.h"

%group SBFloatyFolderView
%hook SBFloatyFolderView

-(void)setBackgroundAlpha:(double)arg1 {

	if(enabled && backgroundAlphaEnabled){
		return %orig(backgroundAlpha);
	}
}

-(void)setCornerRadius:(double)arg1 {
	
	if(enabled && cornerRadiusEnabled){
		return %orig(cornerRadius);
	}
}

-(CGRect)_frameForScalingView {

	if(enabled && customFrameEnabled){
		if(customCenteredFrameEnabled){
			return CGRectMake((self.bounds.size.width - frameWidth)/2, (self.bounds.size.height - frameHeight)/2,frameWidth,frameHeight);
		} else if(!customCenteredFrameEnabled){
			return CGRectMake(frameX,frameY,frameWidth,frameHeight);
		} else {return %orig;}
	} else {return %orig;}
}

%end
%end

%group pinchToClose12
%hook SBFolderSettings

-(BOOL)pinchToClose {

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

-(BOOL)pinchToClose {

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

	if(enabled && customLayoutEnabled && !customBiggerLayoutEnabled){
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
	} else if(enabled && customLayoutEnabled && customLayoutEnabled){
		return customBiggerLayoutRows;
	} else {return %orig;}
}

+ (unsigned long long)iconColumnsForInterfaceOrientation:(long long)arg1 {

	if(enabled && customLayoutEnabled && !customBiggerLayoutEnabled){
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
	} else if(enabled && customLayoutEnabled && customBiggerLayoutEnabled){
		return customBiggerLayoutColumns;
	} else {return %orig;}
}

%end
%end

%ctor{
	reloadPrefs();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, CFSTR("com.burritoz.thomz.folded.prefs/reload"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	%init(SBFloatyFolderView);
	if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"13.0")){
		%init(pinchToClose13);
	} else {
		%init(pinchToClose12);
		%init(layout12);
	}
}