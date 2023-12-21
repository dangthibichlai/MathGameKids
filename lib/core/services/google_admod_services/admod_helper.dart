// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:io';

/// BANNER ADS.
// const String ANDROID_BANNER = 'ca-app-pub-7801106730942036/1816401785';
// const String IOS_BANNER = 'ca-app-pub-7801106730942036/3068654148';

/// REWARD ADS.
// const String ANDROID_REWARD = 'ca-app-pub-7801106730942036/2554768382';
// const String IOS_REWARD = 'ca-app-pub-7801106730942036/5417855009';

// OPEN APP.
// const String ANDROID_OPEN_APP = 'ca-app-pub-7801106730942036/5609426692';
// const String IOS_OPEN_APP = 'ca-app-pub-7801106730942036/8852583421';

/// Test ads.
const String ANDROID_BANNER = 'ca-app-pub-3940256099942544/6300978111';
const String IOS_BANNER = 'ca-app-pub-3940256099942544/2934735716';
const String ANDROID_REWARD = 'ca-app-pub-3940256099942544/5224354917';
const String IOS_REWARD = 'ca-app-pub-3940256099942544/1712485313';
const String ANDROID_OPEN_APP = 'ca-app-pub-3940256099942544/1033173712';
const String IOS_OPEN_APP = 'ca-app-pub-3940256099942544/4411468910';

const String IOS_REWARD_OPEN_APP = 'ca-app-pub-3940256099942544/6978759866';
const String ANDROID_REWARD_OPEN_APP = 'ca-app-pub-3940256099942544/5354046379';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return ANDROID_BANNER;
    } else if (Platform.isIOS) {
      return IOS_BANNER;
    } else {
      return "";
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return ANDROID_REWARD;
    } else if (Platform.isIOS) {
      return IOS_REWARD;
    } else {
      return "";
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get openAppAdUnitId {
    if (Platform.isAndroid) {
      return ANDROID_OPEN_APP;
    } else if (Platform.isIOS) {
      return IOS_OPEN_APP;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardOpenApp {
    if (Platform.isAndroid) {
      return ANDROID_REWARD_OPEN_APP;
    } else if (Platform.isIOS) {
      return IOS_REWARD_OPEN_APP;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
