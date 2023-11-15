import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/presentation/pages/begin_screen/splash/splash_controller.dart';
import '../../../../core/utils/color_resources.dart';
import '../../../../core/utils/images_path.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: IZISizeUtil.getMaxWidth(),
        height: IZISizeUtil.getMaxHeight(),
        child: Stack(
          children: [
            Positioned.fill(
              child: IZIImage(
                ImagesPath.bg_splashImage,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              left: IZISizeUtil.setSizeWithWidth(percent: .02),
              right: IZISizeUtil.setSizeWithWidth(percent: .02),
              top: IZISizeUtil.setSize(percent: .16),
              child: IZIImage(
                ImagesPath.img_splashImage1,
              ),
            ),
            Positioned(
              bottom: IZISizeUtil.setSize(percent: .27),
              left: IZISizeUtil.setSizeWithWidth(percent: .17),
              child: IZIImage(
                ImagesPath.img_splashImage2,
                width: IZISizeUtil.setSizeWithWidth(percent: .28),
              ),
            ),
            Positioned(
              bottom: IZISizeUtil.setSize(percent: .22),
              left: IZISizeUtil.setSizeWithWidth(percent: .25),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Math'.tr,
                      style: GoogleFonts.nunitoSans(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: ColorResources.MATHPRIMARY),
                    ),
                    const WidgetSpan(
                      child: SizedBox(width: 5), // Khoảng cách 5 đơn vị
                    ),
                    TextSpan(
                      text: 'Games'.tr,
                      style: GoogleFonts.nunitoSans(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: ColorResources.BLACK),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: IZISizeUtil.setSize(percent: .22),
              left: IZISizeUtil.setSizeWithWidth(percent: .25),
              //   right: IZISizeUtil.setSizeWithWidth(percent: .1),
              // thanh progress
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(
                      width: IZISizeUtil.setSizeWithWidth(percent: .54),
                      child: TweenAnimationBuilder<double>(
                        duration: const Duration(seconds: 3),
                        curve: Curves.easeInOut,
                        tween: Tween<double>(
                          begin: 0,
                          end: 1,
                        ),
                        builder: (context, value, _) => LinearProgressIndicator(
                          value: value,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              ColorResources.PR_SPLASH),
                          backgroundColor: ColorResources.WHITE,
                          minHeight: 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
