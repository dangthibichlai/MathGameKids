import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/presentation/pages/premium_package/ui_premium_model.dart';

class BottomPremiumPage extends StatelessWidget {
  final PremiumModel? premiumModel;
  const BottomPremiumPage({super.key, this.premiumModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(premiumModel?.title ?? ''),
            centerTitle: true,
            backgroundColor: ColorResources.CHECK,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: IZISizeUtil.setEdgeInsetsAll(IZISizeUtil.SPACE_2X),
                child: CircleAvatar(
                  backgroundColor: ColorResources.WHITE,
                  child: Padding(
                    padding: IZISizeUtil.setEdgeInsetsOnly(left: 8),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: ColorResources.CHECK,
                    ),
                  ),
                ),
              ),
            )

            //leading: Icon ,
            ),
        body: Column(
          children: [
            IZIImage(
              ImagesPath.img_bottom_pre,
              width: IZISizeUtil.getMaxWidth(),
              height: IZISizeUtil.setSize(percent: .2),
            ),
            Expanded(
              child: Container(
                color: ColorResources.WHITE,
                width: IZISizeUtil.getMaxWidth(),
                padding: IZISizeUtil.setEdgeInsetsAll(IZISizeUtil.SPACE_2X),
                child: Text(
                  premiumModel?.description ?? '',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Color(0xFF535354),
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
