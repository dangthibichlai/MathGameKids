import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/pages/opinion_play/play_square_root/play_sqare_root_controller.dart';
import 'package:template/presentation/pages/opinion_play/widget/showAnswer.dart';
import 'package:template/presentation/widgets/banner_ads.dart';

import '../widget/show_quesition_dif.dart';

class PlaySquareRoot extends GetView<PlaySquareRootController> {
  const PlaySquareRoot({super.key});

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
              Obx(
                () => ShowQuesitionDif(
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
              ),
              Obx(
                () => ShowAnswer(
                  currentOptions: controller.currentOptions,
                  // ignore: invalid_use_of_protected_member
                  answerColors: controller.answerColors.value,
                  onTapAnswer: (index) {
                    print('index is: $index');
                    controller.checkAnswer(controller.currentOptions[index]);
                  },
                ),
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
    );
  }

  Widget _textQuestion(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: IZISizeUtil.setSizeWithWidth(percent: .35),
        height: IZISizeUtil.setSize(percent: .1),
        child: Stack(
          children: [
            Positioned.fill(
                child: IZIImage(
              ImagesPath.squareRoot,
              // width: IZISizeUtil.setSizeWithWidth(percent: .1),
              // height: IZISizeUtil.setSize(percent: .15),
              fit: BoxFit.fill,
            )),
            Positioned(
              bottom: 0,
              left: 60,
              child: SizedBox(
                width: IZISizeUtil.setSizeWithWidth(percent: .2),
                height: IZISizeUtil.setSize(percent: .06),
                child: FittedBox(
                  child: Text(
                    controller.currentQuestion.value.toString(),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w900,
                        color: ColorResources.BLUE_BLACK,
                        fontFamily: 'Filson'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
