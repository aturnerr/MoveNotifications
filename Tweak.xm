//@interface NCNotificationListCollectionView : UIView
//@end

#define kIdentifier @"com.aturner.movenotifications"
#define kSettingsChangedNotification (CFStringRef)@"com.aturner.movenotifications/ReloadPrefs"
#define kSettingsPath @"/var/mobile/Library/Preferences/com.aturner.movenotifications.plist"

float notifHeight;

%hook NCNotificationListCollectionView
- (void)setFrame:(CGRect)frame {
		frame = CGRectMake(frame.origin.x,frame.origin.y + notifHeight,frame.size.width,frame.size.height);
		%orig(frame);
}
%end

%hook SBDashBoardAdjunctListView
- (void)setFrame:(CGRect)frame {
		frame = CGRectMake(0,frame.origin.y + notifHeight,frame.size.width,frame.size.height);
		%orig(frame);
}
%end

// Thanks to 6ilent's PokeFullCharge! Reference for my learning on preference bundles.
// Original tweak and source code available at https://github.com/6ilent/PokeFullCharge

static void reloadPrefs() {

  CFPreferencesAppSynchronize((CFStringRef)kIdentifier);

  NSDictionary *prefs = nil;
  if ([NSHomeDirectory() isEqualToString:@"/var/mobile"]) {
    CFArrayRef keys = CFPreferencesCopyKeyList((CFStringRef)kIdentifier, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);

    if (keys != nil) {
      prefs = (NSDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keys, (CFStringRef)kIdentifier, kCFPreferencesCurrentUser, kCFPreferencesAnyHost));

      if (prefs == nil) {
        prefs = [NSDictionary dictionary];
      }
      CFRelease(keys);
    }
  } else {
    prefs = [NSDictionary dictionaryWithContentsOfFile:kSettingsPath];
  }

  notifHeight = [prefs objectForKey:@"notifHeight"] ? [[prefs objectForKey:@"notifHeight"] floatValue] : 0;
}
%ctor {
  reloadPrefs();
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, kSettingsChangedNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}
