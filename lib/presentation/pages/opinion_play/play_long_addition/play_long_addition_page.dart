import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/base_widget/izi_button.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/pages/opinion_play/play_long_addition/play_long_addition_controller.dart';
import 'package:template/presentation/pages/opinion_play/widget/show_quesition_mising.dart';
import 'package:template/presentation/widgets/banner_ads.dart';

class PlayLongAdditionPage extends GetView<PlayLongAdditionController> {
  const PlayLongAdditionPage({super.key});

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
                ShowQuesitionMissing(
                  title: controller.title,
                  level: controller.textLevel.value,
                  count: controller.count.value,
                  currentQuestion: controller.currentQuestion.value,
                  onTapSkip: controller.skipQuestion,
                  isSkip: true,
                  longAddition: true,
                  num1: controller.num1.value,
                  num2: controller.num2.value,
                  inputAnswer: controller.inputValue.value,
                  operator: controller.routeOperation,
                  colorTextLevel: controller.getLevelColor(controller.level),
                  colorAnswer: controller.colorAnswer.value,
                ),
                Expanded(
                  child: Padding(
                    padding: IZISizeUtil.setEdgeInsetsOnly(
                        left: IZISizeUtil.setSizeWithWidth(percent: .07),
                        right: IZISizeUtil.setSizeWithWidth(percent: .07)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildNumberButtonBasic("1"),
                            buildNumberButtonBasic("2"),
                            buildNumberButtonBasic("3"),
                            buildNumberButtonBasic("4"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildNumberButtonBasic("5"),
                            buildNumberButtonBasic("6"),
                            buildNumberButtonBasic("7"),
                            buildNumberButtonBasic("8"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildNumberButtonBasic("9"),
                            buildNumberButtonBasic("0"),
                            buildDeleteButtonBasic(),
                            buildResultButtonBasic("OK"), // xóa
                          ],
                        ),
                      ],
                    ),
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
      ),
    );
  }

  Widget buildNumberButtonBasic(String value) {
    return IZIButton(
      onTap: () {
        controller.handleNumberButton(value);
      },
      label: value,
      fontSizedLabel: IZISizeUtil.DISPLAY_LARGE_FONT_SIZE,
      colorBorder: ColorResources.MATHGAME_BORDER,
      fillColor: ColorResources.MATHGAME_BUTTON_BG,
      colorText: ColorResources.WHITE,
      width: IZISizeUtil.setSizeWithWidth(percent: 0.20),
      height: IZISizeUtil.setSizeWithWidth(percent: .16),
      borderRadius: IZISizeUtil.RADIUS_3X,
      // margin: IZISizeUtil.setEdgeInsetsAll(IZISizeUtil.SPACE_1X),
      //  type: IZIButtonType.OUTLINE,
      type: IZIButtonType.OUTLINE,
      withBorder: 5,
    );
  }

  Widget buildDeleteButtonBasic() {
    return IZIButton(
      onTap: () {
        controller.handleDeleteButton();
      },
      imageUrlIcon: ImagesPath.backKeyIcon,
      sizeIcon: IZISizeUtil.DISPLAY_LARGE_FONT_SIZE,
      fontWeight: FontWeight.bold,
      width: IZISizeUtil.setSizeWithWidth(percent: 0.2),
      height: IZISizeUtil.setSizeWithWidth(percent: .16),
      borderRadius: IZISizeUtil.RADIUS_3X,
      colorBorder: ColorResources.MATHGAME_BORDER,
      fillColor: ColorResources.MATHGAME_BUTTON_BG,
      // margin: IZISizeUtil.setEdgeInsetsAll(IZISizeUtil.SPACE_1X),
      type: IZIButtonType.OUTLINE,
      withBorder: 5,
    );
  }

  Widget buildResultButtonBasic(String value) {
    return IZIButton(
      onTap: () {
        // controller.calculateResult();
        // _historyController.addHistory(
        //     controller.inputText.value, controller.resultText.value);
        // controller.inputText.value = "";
        controller.handleCheckButton();
        // controller.inputValue.value = "";
      },
      label: value,
      sizeIcon: IZISizeUtil.DISPLAY_LARGE_FONT_SIZE,
      fontWeight: FontWeight.bold,
      colorText: ColorResources.WHITE,
      fillColor: ColorResources.GREEN_BG,
      colorBorder: ColorResources.GREEN_BD,
      width: IZISizeUtil.setSizeWithWidth(percent: 0.2),
      height: IZISizeUtil.setSizeWithWidth(percent: .16),
      borderRadius: IZISizeUtil.RADIUS_3X,
      // margin: IZISizeUtil.setEdgeInsetsAll(IZISizeUtil.SPACE_1X),
      type: IZIButtonType.OUTLINE,
      withBorder: 5,
    );
  }
}
