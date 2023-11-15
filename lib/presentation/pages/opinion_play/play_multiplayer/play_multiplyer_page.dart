import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/pages/opinion_play/play_multiplayer/play_multiplayer_controller.dart';
import 'package:template/presentation/pages/opinion_play/play_multiplayer/player_model.dart';
import 'package:template/presentation/pages/opinion_play/widget/answer_multiplayer.dart';
import 'package:template/presentation/pages/opinion_play/widget/show_question.dart';

import '../../../../core/utils/color_resources.dart';

class MultiplayerPage extends GetView<MultiPlayerController> {
  @override
  Widget build(BuildContext context) {
   
    return WillPopScope(
      onWillPop: () async {
        ExtendBackAds.onBackPress(controller.route);
        controller.isScreenExited = true;
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
                    )),
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
                    onTap: () => ExtendBackAds.onBackPress(controller.route),
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
          ShowQuestion(
            isMultiplayer: true,
            width: IZISizeUtil.getMaxWidth(),
            padding: EdgeInsets.only(
              //  top: IZISizeUtil.setSizeWithWidth(percent: .03),
              bottom: IZISizeUtil.setSizeWithWidth(percent: .05),
              left: IZISizeUtil.setSizeWithWidth(percent: .03),
              right: IZISizeUtil.setSizeWithWidth(percent: .03),
            ),
            height: IZISizeUtil.setSizeWithWidth(percent: .36),
            heightQuestion: IZISizeUtil.setSizeWithWidth(percent: .2),
            title: controller.title,
            level: controller.textLevel.value,
            count: controller.count.value,
            currentQuestion: controller.currentQuestion.value,
            countCorrect: screen.correctAnswer,
            colorTextLevel: controller.getLevelColor(controller.level),
          ),
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
              controller.checkAnswer(
                  controller.currentOptions[index], index, screen);
            },
          ),
        ],
      ),
    );
  }

  Widget _progressMultiplayer({required Function onTap}) {
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
              controller.isScreenExited = true;
              controller.animationController.dispose();
              //Get.offAllNamed(controller.route);
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

// ignore: non_constant_identifier_names


// ignore: non_constant_identifier_names

