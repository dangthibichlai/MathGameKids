import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/pages/opinion_play/play_time_challenge/play_time_challenge_controller.dart';
import 'package:template/presentation/pages/opinion_play/widget/showAnswer.dart';
import 'package:template/presentation/pages/opinion_play/widget/show_question.dart';

class PlayTimeChallengePage extends GetView<PlayTimeChallengeController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ExtendBackAds.onBackPress(controller.route);
        controller.isScreenExited = true;
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorResources.BACKGROUND,
        appBar: BaseAppBar(
          title: controller.title,
          leading: IconButton(
            onPressed: () {
              controller.isScreenExited = true;
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
                  height: IZISizeUtil.setSize(percent: .03),
                ),
                ShowQuestion(
                  title: controller.title,
                  level: controller.textLevel.value,
                  count: controller.count.value,
                  currentQuestion: controller.currentQuestion.value,
                  colorTextLevel: controller.getLevelColor(controller.level),
                  time: true,
                  isSkip: true,
                  onTapSkip: controller.skipQuestion,
                ),
                ShowAnswer(
                  currentOptions: controller.currentOptions,
                  answerColors: controller.answerColors,
                  onTapAnswer: (index) {
                    print('index is: $index');
                    controller.checkAnswer(controller.currentOptions[index]);
                  },
                ),
                // Obx(() {
                //   // if (Get.find<DashBoardController>().isPremium.value) {
                //   //   return const SizedBox();
                //   // }
                //   return const BannerAdsFram();
                // }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
