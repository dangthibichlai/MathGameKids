import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:template/core/export/core_export.dart';

class AppOpenAds {
  ///
  /// Declare the API.
  final KeyValidateAds _keyValidateAds = GetIt.I.get<KeyValidateAds>();

  static final AppOpenAds _instance = AppOpenAds();

  static AppOpenAds getInstance() {
    return _instance;
  }

  InterstitialAd? _interstitialAd;
  bool _isShowingAd = false;

  void showOpenAppAds({
    required Function() onSuccess,
    required Function onError,
  }) {
    //
    // Show dialog loading here.
    ShowAdsLoadingFullScreen.showAdsLoadingFullScreen();

    if (_isShowingAd) {
      log('Ads is showing');
      return;
    }

    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          log('$ad loaded.');

          _isShowingAd = true;

          // Keep a reference to the ad so you can show it later.
          _interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            // Called when the ad showed the full screen content.
            onAdShowedFullScreenContent: (ad) {},
            // Called when an impression occurs on the ad.
            onAdImpression: (ad) {},
            // Called when the ad failed to show full screen content.
            onAdFailedToShowFullScreenContent: (ad, err) {
              // Dispose the ad here to free resources.
              _isShowingAd = false;

              ad.dispose();
              _interstitialAd = null;

              _keyValidateAds.setIsShowingAdsAward(value: true);

              onError();
            },
            // Called when the ad dismissed full screen content.
            onAdDismissedFullScreenContent: (ad) {
              _isShowingAd = false;

              // Dispose the ad here to free resources.
              ad.dispose();
              _interstitialAd = null;

              _keyValidateAds.setIsShowingAdsAward(value: true);

              onSuccess();
            },
            // Called when a click is recorded for an ad.
            onAdClicked: (ad) {},
          );

          // Close dialog loading ads.
          Get.back();

          _interstitialAd!.show();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          log('InterstitialAd failed to load: $error');

          // Close dialog.
          Get.back();

          onError();
        },
      ),
    );
  }
}
