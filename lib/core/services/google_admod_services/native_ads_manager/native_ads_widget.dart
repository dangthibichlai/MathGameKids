import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../export/core_export.dart';

class NativeAdsWidget extends StatefulWidget {
  const NativeAdsWidget({super.key, this.isKeepAlive = true, this.callBack});
  final bool? isKeepAlive;
  final Function? callBack;

  @override
  State<NativeAdsWidget> createState() => _NativeAdsWidgetState();
}

class _NativeAdsWidgetState extends State<NativeAdsWidget> with AutomaticKeepAliveClientMixin {
  //
  // Native ads.
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  void initState() {
    _nativeAd = NativeAd(
      adUnitId: AdHelper.nativeAdsId,
      listener: NativeAdListener(
        onAdLoaded: (ad) async {
          log('$NativeAd loaded.');
          _nativeAdIsLoaded = true;
          setState(() {});

          if (widget.callBack != null) {
            widget.callBack!();
          }
        },
        onAdFailedToLoad: (ad, error) {
          log('$NativeAd failedToLoad: $error');
          ad.dispose();
          _nativeAdIsLoaded = false;
          setState(() {});

          if (widget.callBack != null) {
            widget.callBack!();
          }
        },
        onAdClicked: (ad) {},
        onAdImpression: (ad) {},
        onAdClosed: (ad) {},
        onAdOpened: (ad) {},
        onAdWillDismissScreen: (ad) {},
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: ColorResources.PRIMARY_1.withOpacity(.1),
        cornerRadius: 10.0,
        callToActionTextStyle: NativeTemplateTextStyle(
            textColor: ColorResources.WHITE,
            backgroundColor: ColorResources.PRIMARY_1,
            style: NativeTemplateFontStyle.normal,
            size: 16.0),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black,
          backgroundColor: Colors.transparent,
          style: NativeTemplateFontStyle.bold,
          size: 18.0,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black,
          backgroundColor: Colors.transparent,
          style: NativeTemplateFontStyle.bold,
          size: 16.0,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: ColorResources.GREY,
          backgroundColor: Colors.transparent,
          style: NativeTemplateFontStyle.normal,
          size: 14.0,
        ),
      ),
    )..load();
    super.initState();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!_nativeAdIsLoaded) {
      return ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 120,
          minHeight: 120,
          maxWidth: 360,
          maxHeight: 360,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: CommonHelper.backGroundDialog,
            borderRadius: IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.RADIUS_2X),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingApp(titleLoading: 'Loading ads...'),
            ],
          ),
        ),
      );
    }

    if (_nativeAdIsLoaded && _nativeAd == null) {
      return const SizedBox.shrink();
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 120,
        minHeight: 120,
        maxWidth: 360,
        maxHeight: 360,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.RADIUS_2X),
          color: ColorResources.WHITE,
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.RADIUS_2X),
            child: AdWidget(ad: _nativeAd!),
          ),
        ),
      ),
    );
    
  }
  
  @override
  bool get wantKeepAlive => widget.isKeepAlive!;
}
