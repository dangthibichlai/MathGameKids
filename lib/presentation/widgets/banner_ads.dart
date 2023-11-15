import 'package:flutter/widgets.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/services/google_admod_services/banner_ads_manager/banner_ads_widget.dart';
import 'package:template/core/utils/color_resources.dart';

class BannerAdsFram extends StatelessWidget {
  const BannerAdsFram({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.BLACK,
      // margin: IZISizeUtil.setEdgeInsetsOnly(
      //     bottom: IZISizeUtil.SPACE_1X),
      child: BannerAdsWidget(
        adSizeHeight: IZISizeUtil.setSize(percent: .05),
        adSizeWidth: IZISizeUtil.getMaxWidth(),
        useLoadingLogo: false,
      ),
    );
  }
}
