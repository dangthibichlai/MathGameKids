import 'dart:io';

///-------------------- INTERSTITIAL ADS -------------------- ///
const String INTERSTITIAL_AD = 'ca-app-pub-3940256099942544/1033173712';
const String IOS_INTERSTITIAL_ADS = 'ca-app-pub-3940256099942544/4411468910';

///---------------------- NATIVE ADS ----------------------- ///
const String NATIVE_AD = 'ca-app-pub-3940256099942544/2247696110';
const String IOS_NATIVE_ID = 'ca-app-pub-3940256099942544/3986624511';

///-------------------- RESUMED ADS ------------------------ ///
const String RESUMED_AD = 'ca-app-pub-3940256099942544/5354046379';
const String IOS_RESUMED_APP = 'ca-app-pub-3940256099942544/6978759866';

///-------------------- BANNER ADS ------------------------ ///
const String ANDROID_BANNER = 'ca-app-pub-3940256099942544/6300978111';
const String IOS_BANNER = 'ca-app-pub-3940256099942544/2934735716';

///-------------------- REWARD ADS ------------------------ ///
const String ANDROID_REWARD = 'ca-app-pub-3940256099942544/5224354917';
const String IOS_REWARD = 'ca-app-pub-3940256099942544/1712485313';

///-------------------- Interstitial ADS ------------------------ ///
const String ANDROID_INTERSTITIAL = 'ca-app-pub-3940256099942544/1033173712';
const String IOS_INTERSTITIAL = 'ca-app-pub-3940256099942544/4411468910';

mixin AdHelper {
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return ANDROID_INTERSTITIAL;
    } else if (Platform.isIOS) {
      return IOS_INTERSTITIAL;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return ANDROID_BANNER;
    } else if (Platform.isIOS) {
      return IOS_BANNER;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return ANDROID_REWARD;
    } else if (Platform.isIOS) {
      return IOS_REWARD;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get openAppAdUnitId {
    if (Platform.isAndroid) {
      return INTERSTITIAL_AD;
    } else if (Platform.isIOS) {
      return IOS_INTERSTITIAL_ADS;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardOpenApp {
    if (Platform.isAndroid) {
      return RESUMED_AD;
    } else if (Platform.isIOS) {
      return IOS_RESUMED_APP;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdsId {
    if (Platform.isAndroid) {
      return NATIVE_AD;
    } else if (Platform.isIOS) {
      return IOS_NATIVE_ID;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
