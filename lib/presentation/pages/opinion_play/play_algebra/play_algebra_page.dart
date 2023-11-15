import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/pages/opinion_play/play_algebra/play_algebra_controller.dart';
import 'package:template/presentation/pages/opinion_play/widget/showAnswer.dart';
import 'package:template/presentation/pages/opinion_play/widget/show_quesition_dif.dart';
import 'package:template/presentation/widgets/banner_ads.dart';

class PlayAlgebraPage extends GetView<PlayAlgebraController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Get.back();
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
              // Get.back();
              ExtendBackAds.onBackPress(controller.route);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: IZISizeUtil.setSizeWithWidth(percent: .06),
              ),
              Obx(() => ShowQuesitionDif(
                    title: controller.title,
                    level: controller.textLevel.value,
                    count: controller.count.value,
                    currentQuestion: Padding(
                      padding: IZISizeUtil.setEdgeInsetsOnly(
                          left: IZISizeUtil.SPACE_2X,
                          right: IZISizeUtil.SPACE_2X),
                      child: FittedBox(
                        child: Text(
                          controller.currentQuestion.value,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: ColorResources.BLUE_BLACK,
                                  fontFamily: 'Filson'),
                          maxLines: 2,
                        ),
                      ),
                    ),
                    colorTextLevel: controller.getLevelColor(controller.level),
                  )),
              Obx(() => ShowAnswer(
                    currentOptions: controller.currentOptions,
                    // ignore: invalid_use_of_protected_member
                    answerColors: controller.answerColors.value,
                    onTapAnswer: (index) {
                      print('index is: $index');
                      controller.checkAnswer(
                        controller.currentOptions[index],
                      );
                    },
                  )),
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
