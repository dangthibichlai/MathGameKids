import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:template/core/export/core_export.dart';

class RewardAds {
  static final RewardAds _instance = RewardAds();

  static RewardAds getInstance() {
    return _instance;
  }

  RewardedAd? _rewardedAd;
  bool _isShowingAd = false;

  void showRewardAds({
    required Function(AdWithoutView adWithoutView, RewardItem reward) onSuccess,
    required Function onError,
  }) {
    //
    // Show dialog loading here.
    ShowAdsLoadingFullScreen.showAdsLoadingFullScreen();

    if (_isShowingAd) {
      log('Ads is showing');
      return;
    }
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _isShowingAd = true;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              _isShowingAd = false;
              ad.dispose();
              _rewardedAd = null;

              _showAds(
                onSuccess: (adWithoutView, reward) {
                  onSuccess(adWithoutView, reward);
                },
              );
            },
          );

          _rewardedAd = ad;

          // Close dialog.
          Get.back();

          _showAds(
            onSuccess: (adWithoutView, reward) {
              onSuccess(adWithoutView, reward);
            },
          );
        },
        onAdFailedToLoad: (err) {
          log('Failed to load a rewarded ad: ${err.message}');

          // Close dialog.
          Get.back();

          onError();
        },
      ),
    );
  }

  void _showAds(
      {Function(AdWithoutView adWithoutView, RewardItem reward)? onSuccess}) {
    _rewardedAd?.show(
      onUserEarnedReward: (adWithoutView, reward) {
        if (onSuccess != null) {
          onSuccess(adWithoutView, reward);
        }
      },
    );
  }
}
