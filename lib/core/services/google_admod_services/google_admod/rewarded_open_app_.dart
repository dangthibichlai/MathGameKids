import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:template/core/services/google_admod_services/admod_helper.dart';

class RewardedInterstitial {
  RewardedInterstitialAd? _rewardedInterstitialAd;

  RewardedInterstitial();

  /// Loads a rewarded ad.
  void loadAd() {
    RewardedInterstitialAd.load(
      adUnitId: AdHelper.rewardOpenApp,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
              onAdShowedFullScreenContent: (ad) {},
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {},
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
                // Dispose the ad here to free resources.
                ad.dispose();
              },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) {
                // Dispose the ad here to free resources.
                ad.dispose();
              },
              // Called when a click is recorded for an ad.
              onAdClicked: (ad) {});

          log('Phone $ad loaded.');
          // Keep a reference to the ad so you can show it later.
          _rewardedInterstitialAd = ad;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          log('RewardedInterstitialAd failed to load: $error');
        },
      ),
    );
  }

  ///
  /// Show ads.
  ///
  void showAds() {
    log('Phone load');
    _rewardedInterstitialAd?.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      // Reward the user for watching an ad.
    });
  }
}
