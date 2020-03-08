#include "Tweak.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

// Preferences keys
NSDictionary *preferences;
BOOL enabled;
BOOL backgroundAlphaEnabled;
double backgroundAlpha;
BOOL cornerRadiusEnabled;
double cornerRadius;
BOOL pinchToCloseEnabled;
BOOL customFrameEnabled;
BOOL customCenteredFrameEnabled;
CGFloat frameX;
CGFloat frameY;
CGFloat frameWidth;
CGFloat frameHeight;

static void reloadPrefs(){
	preferences = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"com.burritoz.thomz.folded.prefs"];
	enabled = [[preferences objectForKey:@"enabled"] boolValue];
	backgroundAlphaEnabled = [[preferences objectForKey:@"backgroundAlphaEnabled"] boolValue];
	backgroundAlpha = [[preferences objectForKey:@"backgroundAlpha"] doubleValue];
	cornerRadiusEnabled = [[preferences objectForKey:@"cornerRadiusEnabled"] boolValue];
	cornerRadius = [[preferences objectForKey:@"cornerRadius"] doubleValue];
	pinchToCloseEnabled = [[preferences objectForKey:@"pinchToCloseEnabled"] boolValue];
	customFrameEnabled = [[preferences objectForKey:@"customFrameEnabled"] boolValue];
	customCenteredFrameEnabled = [[preferences objectForKey:@"customCenteredFrameEnabled"] boolValue];
	frameX = [[preferences valueForKey:@"customFrameX"] floatValue];
	frameY = [[preferences valueForKey:@"customFrameY"] floatValue];
	frameWidth = [[preferences valueForKey:@"customFrameWidth"] floatValue];
	frameHeight = [[preferences valueForKey:@"customFrameHeight"] floatValue];
}

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

%ctor{
	reloadPrefs();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, CFSTR("com.burritoz.thomz.folded.prefs/reload"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	%init(SBFloatyFolderView);
	if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"13.0")){
		%init(pinchToClose13);
	} else {
		%init(pinchToClose12);
	}
}