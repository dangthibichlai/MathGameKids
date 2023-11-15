import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/pages/opinion_play/play_practice/play_practice_controller.dart';
import 'package:template/presentation/pages/opinion_play/widget/showAnswer.dart';
import 'package:template/presentation/pages/opinion_play/widget/show_question.dart';
import 'package:template/presentation/widgets/banner_ads.dart';

class PlayPracticePage extends GetView<PlayPracticeController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
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
              //Get.back();
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
              Obx(() => ShowQuestion(
                    title: controller.title,
                    level: controller.textLevel.value,
                    count: controller.count.value,
                    currentQuestion: controller.currentQuestion.value,
                    colorTextLevel: controller.getLevelColor(controller.level),
                  )),
              Obx(
                () => ShowAnswer(
                  currentOptions: controller.currentOptions,
                  // ignore: invalid_use_of_protected_member
                  answerColors: controller.answerColors.value,
                  onTapAnswer: (index) {
                    print('index is: $index');
                    controller.checkAnswer(
                      controller.currentOptions[index],
                    );
                  },
                ),
              ),

              // Banner.
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
