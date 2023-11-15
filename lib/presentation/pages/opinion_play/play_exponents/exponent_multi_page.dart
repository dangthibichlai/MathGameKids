import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/pages/opinion_play/play_exponents/multiplay_exponets_controller.dart';
import 'package:template/presentation/pages/opinion_play/play_exponents/text_exponet.dart';
import 'package:template/presentation/pages/opinion_play/play_multiplayer/player_model.dart';
import 'package:template/presentation/pages/opinion_play/widget/answer_multiplayer.dart';
import 'package:template/presentation/pages/opinion_play/widget/show_quesition_dif.dart';

import '../../../../core/helper/izi_size_util.dart';

class ExponentMultiPage extends GetView<MultiExponentsController> {
  const ExponentMultiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ExtendBackAds.onBackPress(controller.route);
        ExtendBackAds.onBackPress(controller.route);
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorResources.BG,
        body: SizedBox(
          height: IZISizeUtil.getMaxHeight(),
          child: Stack(
            children: [
              Obx(
                () => Column(
                  children: [
                    Expanded(
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: _screenplay(
                            color: ColorResources.BACKGROUND,
                            screen: controller.player1.value),
                      ),
                    ),
                    Expanded(
                      child: _screenplay(screen: controller.player2.value),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Positioned(
                  top: IZISizeUtil.getMaxHeight() / 2 - 20,
                  child: _progressMultiplayer(
                      // onTap: () => Get.toNamed(controller.route),
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _screenplay({Color? color, required PlayerModel screen}) {
    return Container(
      height: IZISizeUtil.getMaxHeight() / 2,
      color: color,
      child: Column(
        children: [
          ///
          ///Question
          ///
          ShowQuesitionDif(
            isMulti: true,
            padding: IZISizeUtil.setEdgeInsetsOnly(
                top: IZISizeUtil.setSizeWithWidth(percent: .02),
                //bottom: IZISizeUtil.setSizeWithWidth(percent: .02),
                left: IZISizeUtil.setSizeWithWidth(percent: .07),
                right: IZISizeUtil.setSizeWithWidth(percent: .07)),
            height: IZISizeUtil.setSizeWithWidth(percent: 0.45),
            heightQuestion: IZISizeUtil.setSizeWithWidth(percent: 0.36),
            title: controller.title,
            level: controller.textLevel.value,
            count: controller.count.value,
            countCorrect: screen.correctAnswer,
            currentQuestion: TextExponet(
              exponent: controller.exponentsModel.value.exponent,
              base: controller.exponentsModel.value.base,
            ),
            isSkip: controller.isSkip,
            onTapSkip: controller.skipQuestion,
            colorTextLevel: controller.getLevelColor(controller.level),
          ),

          ///
          /// Answer
          ///
          ShowAnswerMultiplayerWidget(
            isEnabled: screen.isEnable.value,
            padding: EdgeInsets.only(
              // bottom: IZISizeUtil.setSizeWithWidth(percent: .1),
              left: IZISizeUtil.setSizeWithWidth(percent: .12),
              right: IZISizeUtil.setSizeWithWidth(percent: .12),
            ),
            childAspectRatio: 1.7,
            currentOptions: controller.currentOptions,
            answerColors: screen.answerColors.value,
            onTapAnswer: (index) {
              controller.checkMultiAnswer(
                  controller.currentOptions[index], index, screen);
            },
          ),
          // Obx(() {
          //   if (Get.find<HomeController>().isPremium.value) {
          //     return const SizedBox();
          //   }
          //   return const BannerAdsFram();
          // }),
        ],
      ),
    );
  }

  Widget _progressMultiplayer() {
    return Container(
      height: 40,
      width: IZISizeUtil.getMaxWidth(),
      padding: IZISizeUtil.setEdgeInsetsOnly(
          right: IZISizeUtil.setSizeWithWidth(percent: .08),
          left: IZISizeUtil.setSizeWithWidth(percent: .08)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              ExtendBackAds.onBackPress(controller.route);
              controller.animationController.dispose();
            },
            child: const CircleAvatar(
              radius: 15,
              child: Icon(
                Icons.close_sharp,
                weight: 900, // là
                color: ColorResources.WHITE,
              ),
            ),
          ),
          SizedBox(
            width: IZISizeUtil.setSizeWithWidth(percent: .02),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: LinearProgressIndicator(
                value: controller.progress.value,
                valueColor: const AlwaysStoppedAnimation<Color>(
                    ColorResources.ORANGE_MG),
                backgroundColor: ColorResources.LIGHT_GREY,
                minHeight: 12,
              ),
            ),
          ),
          Lottie.asset('assets/images/clock_time.json',
              //  controller: controller!,
              width: IZISizeUtil.setSizeWithWidth(percent: .12),
              height: IZISizeUtil.setSizeWithWidth(percent: .2)),
        ],
      ),
    );
  }
}
