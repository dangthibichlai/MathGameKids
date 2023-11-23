import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/pages/opinion_play/play_quiz/play_quiz_controller.dart';
import 'package:template/presentation/pages/opinion_play/widget/showAnswer.dart';
import 'package:template/presentation/pages/opinion_play/widget/show_question.dart';
import 'package:template/presentation/widgets/banner_ads.dart';

class PlayQuiz extends GetView<playQuizController> {
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
                ShowQuestion(
                  title: controller.title,
                  level: controller.textLevel.value,
                  count: controller.count.value,
                  currentQuestion: controller.currentQuestion.value,
                  colorTextLevel: controller.getLevelColor(controller.level),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
