import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/services/google_admod_services/admod_helper.dart';

class GoogleAdmodServices {
  ///
  /// Show banner google admod.
  ///
  Future<BannerAd> bannerAdmodFunc({
    AdSize? adSize,
    Function()? callBack,
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

  ///
  /// Widget show banner.
  ///
  Widget googleBannerWidget({
    required BannerAd ads,
    bool? isBorder = false,
  }) {
    final Widget _result = Container(
      alignment: Alignment.center,
      width: ads.size.width.toDouble(),
      height: ads.size.height.toDouble(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isBorder! ? IZISizeUtil.RADIUS_2X : 0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isBorder ? IZISizeUtil.RADIUS_2X : 0),
        child: AdWidget(ad: ads),
      ),
    );
    return _result;
  }

  ///
  ///  Show reward ads.
  ///
  void showRewardAds({
    required RewardedAd rewardedAd,
  }) {
    rewardedAd.show(
      onUserEarnedReward: (_, reward) {
        print('Reward ${reward.amount}');
      },
    );
  }
}
