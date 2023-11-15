import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:template/core/services/google_admod_services/admod_helper.dart';


class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  /// Load an AppOpenAd.
  void loadAd() {
    AppOpenAd.load(
      adUnitId: AdHelper.openAppAdUnitId,
      orientation: AppOpenAd.orientationPortrait,
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          log('Show done');
        },
        onAdFailedToLoad: (error) {
          log('AppOpenAd failed to load: $error');
          // Handle the error.
        },
      ),
      request: const AdRequest(),
    );
  }

  ///
  /// Show full ads screen.
  ///
  void showAdIfAvailable({Function? callBackDismiss, Function? onAdFailed}) {
    if (_appOpenAd == null) {
      log('Tried to show ad before available.');

      loadAd();
      if (onAdFailed != null) {
        onAdFailed();
      }
      return;
    }
    if (_isShowingAd) {
      log('Tried to show ad while already showing an ad.');
      if (onAdFailed != null) {
        onAdFailed();
      }
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        log('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;

        if (onAdFailed != null) {
          onAdFailed();
        }
      },
      onAdDismissedFullScreenContent: (ad) {
        log('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();

        if (callBackDismiss != null) {
          callBackDismiss();
        }
      },
    );
    _appOpenAd!.show();
  }
}
