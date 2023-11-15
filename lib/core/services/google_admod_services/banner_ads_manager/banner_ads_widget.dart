import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:template/core/export/core_export.dart';

class BannerAdsWidget extends StatefulWidget {
  const BannerAdsWidget({
    Key? key,
    this.isBorderRadius = false,
    this.isKeepAlive = true,
    this.adSizeWidth,
    required this.adSizeHeight,
    this.callBackLoaded,
    this.useLoadingLogo = true,
  }) : super(key: key);
  final bool? isBorderRadius;
  final double? adSizeWidth;
  final double adSizeHeight;
  final bool? isKeepAlive;
  final Function()? callBackLoaded;
  final bool? useLoadingLogo;

  @override
  State<BannerAdsWidget> createState() => _BannerAdsWidgetState();
}

class _BannerAdsWidgetState extends State<BannerAdsWidget> with AutomaticKeepAliveClientMixin<BannerAdsWidget> {
  @override
  bool get wantKeepAlive => widget.isKeepAlive!;

  late BannerAd _ads;
  bool _isDoneLoadFirstAdd = false;

  @override
  void initState() {
    BannerAds.getInstance()
        .bannerAdmodFunc(
      adSize: AdSize(
        width: widget.adSizeWidth != null ? widget.adSizeWidth!.toInt() : Get.size.width.toInt(),
        height: widget.adSizeHeight.toInt(),
      ),
      callBack: () {
        _isDoneLoadFirstAdd = true;
        setState(() {});
        if (widget.callBackLoaded != null) {
          widget.callBackLoaded!();
        }
      },
      onError: () {},
    )
        .then((value) {
      _ads = value;
      _ads.load();
    });

    super.initState();
  }

  @override
  void dispose() {
    _ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (!_isDoneLoadFirstAdd) {
      return _loadingAdsWidget(useLoadingLogo: widget.useLoadingLogo!);
    }
    return Container(
      alignment: Alignment.center,
      width: _ads.size.width.toDouble(),
      height: _ads.size.height.toDouble(),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(widget.isBorderRadius! ? IZISizeUtil.RADIUS_2X : 0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.isBorderRadius! ? IZISizeUtil.RADIUS_2X : 0),
        child: AdWidget(ad: _ads),
      ),
    );
  }

  ///
  /// Loading ads.
  ///
  Container _loadingAdsWidget({bool useLoadingLogo = true}) {
    return Container(
      alignment: Alignment.center,
      width: widget.adSizeWidth ?? Get.size.width,
      height: widget.adSizeHeight,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(widget.isBorderRadius! ? IZISizeUtil.RADIUS_2X : 0),
      ),
      child: Center(
          child: LoadingApp(
        useLoadingLogo: useLoadingLogo,
        titleLoading: 'Loading ads...',
      )),
    );
  }
}
