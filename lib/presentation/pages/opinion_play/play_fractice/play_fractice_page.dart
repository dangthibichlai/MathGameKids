import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/pages/opinion_play/play_fractice/model/fraction_model.dart';
import 'package:template/presentation/pages/opinion_play/play_fractice/play_fractice_controller.dart';
import 'package:template/presentation/pages/opinion_play/widget/show_answer_dif.dart';
import 'package:template/presentation/pages/opinion_play/widget/show_quesition_dif.dart';
import 'package:template/presentation/pages/opinion_play/widget/text_praction.dart';
import 'package:template/presentation/widgets/banner_ads.dart';

import '../../../../core/helper/izi_size_util.dart';
import '../../../../core/utils/color_resources.dart';

class PlayFracticePage extends GetView<PlayFracticeController> {
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
                  currentQuestion: TextQuesition(
                      controller.operand1.value,
                      controller.operand2.value,
                      controller.routeOperation,
                      context),
                  colorTextLevel: controller.getLevelColor(controller.level),
                  isSkip: true,
                  onTapSkip: controller.skipQuestion,
                ),
                ShowAnswerDif(
                  currentOptions: controller.currentOptions,
                  // ignore: invalid_use_of_protected_member
                  answerColors: controller.answerColors.value,
                  onTapAnswer: (index) {
                    print(controller.currentOptions[index]);
                    controller.checkAnswer(
                        controller.currentOptions[index], index);
                  },
                ),
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
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget TextQuesition(Fraction fraction1, Fraction fraction2, String operator,
    BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FittedBox(child: TextPraction(fraction: fraction1, context: context)),
      Text(
        operator,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w900,
            color: ColorResources.BLUE_BLACK,
            fontFamily: 'Filson'),
      ),
      FittedBox(child: TextPraction(fraction: fraction2, context: context)),
      Padding(
        padding: IZISizeUtil.setEdgeInsetsAll(
          IZISizeUtil.setSizeWithWidth(percent: .01),
        ),
        child: textNumber("=", context),
      ),
      Padding(
        padding: IZISizeUtil.setEdgeInsetsAll(
          IZISizeUtil.setSizeWithWidth(percent: .01),
        ),
        child: textNumber("?", context),
      ),
    ],
  );
}

Widget textNumber(String text, BuildContext context,
    {double? fontSize, FontWeight? fontWeight, Color? colorText}) {
  return Text(
    text,
    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
        fontWeight: fontWeight ?? FontWeight.w700,
        color: colorText ?? ColorResources.BLUE_BLACK,
        fontFamily: 'Filson'),
    maxLines: 1,
  );
}

Widget divider(
    {double? height, Color? color, double? thickness, Color? colorText}) {
  return Padding(
    padding: IZISizeUtil.setEdgeInsetsOnly(
      left: IZISizeUtil.setSizeWithWidth(percent: .03),
      right: IZISizeUtil.setSizeWithWidth(percent: .03),
    ),
    child: Divider(
      height: height ?? 6,
      color: colorText ?? ColorResources.BLUE_BLACK,
      thickness: thickness ?? 5,
    ),
  );
}
