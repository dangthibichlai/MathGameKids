import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/pages/opinion_play/play_exponents/play_exponents_controller.dart';
import 'package:template/presentation/pages/opinion_play/widget/showAnswer.dart';
import 'package:template/presentation/pages/opinion_play/widget/show_quesition_dif.dart';

import '../../../../core/base_widget/izi_app_bar.dart';
import '../../../../core/utils/color_resources.dart';

class PlayExponentsPage extends GetWidget<PlayExponentsController> {
  const PlayExponentsPage({super.key});

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
              Get.back();
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
                ShowQuesitionDif(
                  title: controller.title,
                  level: controller.textLevel.value,
                  count: controller.count.value,
                  currentQuestion: _textQuestion(context),
                  colorTextLevel: controller.getLevelColor(controller.level),
                  isSkip: controller.isSkip,
                  onTapSkip: () {
                    controller.skipQuestion();
                  },
                ),
                ShowAnswer(
                  currentOptions: controller.currentOptions,
                  // ignore: invalid_use_of_protected_member
                  answerColors: controller.answerColors.value,
                  onTapAnswer: (index) {
                    controller.checkAnswer(controller.currentOptions[index]);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textQuestion(BuildContext context) {
    
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        controller.exponentsModel.value.base.toString(),
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w900,
            color: ColorResources.BLUE_BLACK,
            fontFamily: 'Filson'),
      ),
      Stack(
        children: [
          Container(
            height: IZISizeUtil.setSize(percent: .08),
            decoration: const BoxDecoration(),
          ),
          Text(
            controller.exponentsModel.value.exponent.toString(),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w900,
                color: ColorResources.BLUE_BLACK,
                fontFamily: 'Filson'),
          ),
        ],
      )
    ]);
  }
}
