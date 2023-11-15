import 'dart:developer';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:template/core/export/core_export.dart';

class RewardedInterstitial {
  static final RewardedInterstitial _instance = RewardedInterstitial();

  static RewardedInterstitial getInstance() {
    return _instance;
  }

  RewardedInterstitialAd? _rewardedInterstitialAd;
  bool _isShowingAd = false;

  /// Loads a rewarded ad.
  void loadAd({Function? callBackSuccess, Function? onError}) {
    RewardedInterstitialAd.load(
      adUnitId: AdHelper.rewardOpenApp,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            //
            // Called when the ad showed the full screen content.
            onAdShowedFullScreenContent: (ad) {
              log('Show success full screen');

              _isShowingAd = true;

              if (callBackSuccess != null) {
                callBackSuccess();
              }
            },
            // Called when an impression occurs on the ad.
            onAdImpression: (ad) {
              log('Called when an impression occurs on the ad.');
            },
            onAdFailedToShowFullScreenContent: (ad, err) {
              //
              // Dispose the ad here to free resources.
              _isShowingAd = false;
              ad.dispose();
              _rewardedInterstitialAd = null;

              if (onError != null) {
                onError();
              }
            },

            onAdDismissedFullScreenContent: (ad) {
              //
              // Dispose the ad here to free resources.
              _isShowingAd = false;
              ad.dispose();
              _rewardedInterstitialAd = null;
              loadAd();

              log('Dismiss ads.');
            },

            onAdClicked: (ad) {
              log('On ad clicked.');
            },
          );

          // Keep a reference to the ad so you can show it later.
          _rewardedInterstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('RewardedInterstitialAd failed to load: $error');

          _isShowingAd = true;

          if (onError != null) {
            onError();
          }
        },
      ),
    );
  }

  ///
  /// Show ads.
  ///
  void showAds() {
    if (!_isShowingAd) {
      _rewardedInterstitialAd?.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
          // Reward the user for watching an ad.
        },
      );
    }
  }
}
