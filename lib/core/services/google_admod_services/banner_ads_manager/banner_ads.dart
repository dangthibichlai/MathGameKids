import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:template/core/export/core_export.dart';

class BannerAds {
  static final BannerAds _instance = BannerAds();

  static BannerAds getInstance() {
    return _instance;
  }

  ///
  /// Show banner google admod.
  ///
  Future<BannerAd> bannerAdmodFunc({
    AdSize? adSize,
    Function()? callBack,
    Function()? onError,
  }) async {
    //
    // Create banner add to return.
    BannerAd? _ads;

    // Create banner ads listener.
    final BannerAdListener _bannerAdListener = BannerAdListener(
      onAdLoaded: (ads) {
        //
        // Add banner ads when loaded.
        _ads = ads as BannerAd;
        if (callBack != null) {
          callBack();
        }
      },
      onAdFailedToLoad: (ads, err) {
        print('Failed to load a banner ad: ${err.message} ${err.code}');

        // Dispose ads if failed to load.
        ads.dispose();

        if (onError != null) {
          onError();
        }
      },
    );

    // Create banner ads and load.
    _ads = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: adSize ?? AdSize.banner,
      request: const AdRequest(),
      listener: _bannerAdListener,
    );

    return _ads!;
  }
}
