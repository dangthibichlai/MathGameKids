import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/pages/opinion_play/play_true_false/play_true_false_controller.dart';
import 'package:template/presentation/pages/opinion_play/widget/show_question.dart';
import 'package:template/presentation/widgets/banner_ads.dart';
import 'package:template/presentation/widgets/home_component/gri_container.dart';

class PlayTrueFalsePage extends GetView<PlayTrueFalseController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ExtendBackAds.onBackPress(controller.route);
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorResources.BACKGROUND,
        appBar: BaseAppBar(
          title: controller.title,
          isPremium: false,
          leading: IconButton(
            onPressed: () {
              ExtendBackAds.onBackPress(controller.route);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SafeArea(
          child: Obx(
            () => Column(
              children: [
                SizedBox(
                  height: IZISizeUtil.setSizeWithWidth(percent: .06),
                ),
                Stack(
                  children: [
                    ShowQuestion(
                      title: controller.title,
                      level: controller.textLevel.value,
                      count: controller.count.value,
                      currentQuestion: controller.currentQuestion.value,
                      colorTextLevel:
                          controller.getLevelColor(controller.level),
                      isSkip: true,
                      onTapSkip: controller.skipQuestion,
                      color: controller.color.value,
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      GridViewContainer(
                        boderRadius: IZISizeUtil.RADIUS_4X,
                        isEnabled: controller.isEnable.value,
                        height: IZISizeUtil.setSizeWithWidth(percent: .29),
                        color: ColorResources.GREEN_BG,
                        borderColor: ColorResources.GREEN_BD,
                        disabledColor: ColorResources.GREEN_BG,
                        titleText: 'true'.tr,
                        onTap: () {
                          controller.isCorrect.value = false;
                          controller.checkAnswer(true);
                        },
                        fontSizedLabel:
                            IZISizeUtil.setSizeWithWidth(percent: .09),
                      ),
                      SizedBox(
                        height: IZISizeUtil.setSizeWithWidth(percent: .05),
                      ),
                      GridViewContainer(
                        boderRadius: IZISizeUtil.RADIUS_4X,
                        isEnabled: controller.isEnable.value,
                        disabledColor: ColorResources.ORANGE_BG,
                        height: IZISizeUtil.setSizeWithWidth(percent: .29),
                        color: ColorResources.ORANGE_BG,
                        titleText: 'false'.tr,
                        borderColor: ColorResources.ORANGE_BD,
                        onTap: () {
                          controller.isCorrect.value = false;
                          controller.checkAnswer(false);
                        },
                        fontSizedLabel:
                            IZISizeUtil.setSizeWithWidth(percent: .09),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
