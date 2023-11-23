import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/pages/opinion_play/play_mising_number/play_mising_controller.dart';
import 'package:template/presentation/pages/opinion_play/widget/showAnswer.dart';
import 'package:template/presentation/pages/opinion_play/widget/show_quesition_mising.dart';
import 'package:template/presentation/widgets/banner_ads.dart';

class PlayMissingNumberPage extends GetView<PlayMissingNumberController> {
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
                ShowQuesitionMissing(
                  title: controller.title,
                  level: controller.textLevel.value,
                  colorTextLevel: controller.getLevelColor(controller.level),
                  isSkip: true,
                  currentQuestion: 'currentQuestion',
                  onTapSkip: controller.skipQuestion,
                  countCorrect: controller.countCorrect.value,
                  countWrong: controller.countWrong.value,
                  countSkip: controller.countSkip.value,
                  count: controller.count.value,
                  router: controller.route,
                  num1: controller.num1.value,
                  num2: controller.num2.value,
                  result: controller.result.value,
                  operator: controller.routeOperation,
                  position: controller.position.value,
                  numberOder: controller.numberOder.value,
                  colorMissing: controller.colorMissing,
                ),
                ShowAnswer(
                  currentOptions: controller.currentOptions,
                  answerColors: controller.answerColors,
                  onTapAnswer: (index) {
                    print(controller.currentOptions[index]);
                    controller.checkAnswer(controller.currentOptions[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
