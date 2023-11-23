import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/result_package/result_controller.dart';
import 'package:template/presentation/widgets/banner_ads.dart';
import 'package:template/presentation/widgets/button_animated.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';
import 'package:template/presentation/widgets/result_components/container_result.dart';

class ResultPage extends GetView<ResultController> {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND,
      body: WillPopScope(
        onWillPop: () async {
          // Chặn trượt back tại trang này
          return false;
        },
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: IZISizeUtil.setEdgeInsetsOnly(
                  left: IZISizeUtil.setSizeWithWidth(percent: .1),
                  right: IZISizeUtil.setSizeWithWidth(percent: .1),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: IZISizeUtil.setEdgeInsetsOnly(
                          top: IZISizeUtil.setSizeWithWidth(percent: .01)),
                      alignment: Alignment.center,
                      child: IZIImage(
                        ImagesPath.resultIcon,
                        height: IZISizeUtil.setSizeWithWidth(percent: .3),
                      ),
                    ),
                    AutoSizeText(
                      'result_Page_1'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontWeight: FontWeight.w900,
                              color: ColorResources.WHITE,
                              fontFamily: 'Filson'),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: IZISizeUtil.setSizeWithWidth(percent: .07),
                    ),
                    ContainerResult(
                      title: 'result_Page_2'.tr,
                      numberAnswer: controller.countCorrect,
                      icon: Icons.check,
                      colorBackground: ColorResources.GREEN_BG,
                      boderColor: ColorResources.GREEN_BD,
                    ),
                    ContainerResult(
                      title: 'result_Page_3'.tr,
                      numberAnswer: controller.countWrong,
                      icon: Icons.close,
                      colorBackground: ColorResources.ORANGE_BG,
                      boderColor: ColorResources.ORANGE_BD,
                    ),
                    ContainerResult(
                      title: 'result_Page_4'.tr,
                      numberAnswer: controller.countSkip,
                      icon: Icons.double_arrow,
                      colorBackground: ColorResources.HOME_BG_1,
                      boderColor: ColorResources.HOME_BD_1,
                    ),
                    SizedBox(
                      height: IZISizeUtil.setSize(percent: .1),
                    ),
                    // const Spacer(),
                    ButtonAnimated(
                        text: 'result_Page_5'.tr,
                        onTap: () {
                          if (Get.isRegistered<SoundController>()) {
                            Get.find<SoundController>().playClickDoneSound();
                          }
                          Get.back();
                          // Get.offNamedUntil(controller.router,
                          //     (route) => Get.currentRoute == controller.router);
                          //  ExtendBackAds.showAdsBackMulti();
                          if (Get.isRegistered<SoundController>()) {
                            Get.find<SoundController>()
                                .continueBackgroundSound();
                          }
                        }),
                    //  const Spacer(),
                  ],
                ),
              ),
              const Spacer(),
              Obx(() {
                if (Get.find<DashBoardController>().isPremium.value) {
                  return const SizedBox();
                }
                return const BannerAdsFram();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
