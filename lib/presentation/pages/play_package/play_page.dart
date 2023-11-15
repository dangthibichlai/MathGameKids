import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/play_package/play_controller.dart';
import 'package:template/presentation/widgets/home_component/gri_container.dart';

class PlayPage extends GetView<PlayController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND,
      appBar: BaseAppBar(title: controller.title, isPremium: false),
      body: Obx(
        () => SafeArea(
          child: Column(
            children: [
              Padding(
                padding: IZISizeUtil.setEdgeInsetsOnly(
                    top: IZISizeUtil.setSizeWithWidth(percent: .26),
                    bottom: IZISizeUtil.setSizeWithWidth(percent: .08),
                    left: IZISizeUtil.setSizeWithWidth(percent: .1),
                    right: IZISizeUtil.setSizeWithWidth(percent: .1)),
                child: Stack(
                  children: [
                    SizedBox(
                      width: IZISizeUtil.setSizeWithWidth(percent: .9),
                      height: IZISizeUtil.setSizeWithWidth(percent: .8),
                    ),
                    Container(
                      margin: IZISizeUtil.setEdgeInsetsOnly(
                        top: IZISizeUtil.setSizeWithWidth(percent: .02),
                      ),
                      alignment: Alignment.center,
                      width: IZISizeUtil.setSizeWithWidth(percent: .85),
                      height: IZISizeUtil.setSizeWithWidth(percent: .73),
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        borderRadius:
                            BorderRadius.circular(IZISizeUtil.RADIUS_3X),
                        border: Border.all(
                            color: ColorResources.LIGHT_BLUE, width: 5),
                      ),
                      child: Text(
                        controller.currentQuestion.value.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                fontWeight: FontWeight.w900,
                                color: ColorResources.BLUE_BLACK,
                                fontFamily: 'Filson'),
                      ),
                    ),
                    Positioned(
                      top: IZISizeUtil.SPACE_3X,
                      left: IZISizeUtil.SPACE_2X,
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: controller.getLevelColor(controller.level),
                            size: IZISizeUtil.setSize(percent: .015),
                          ),
                          const SizedBox(
                            width: IZISizeUtil.SPACE_1X,
                          ),
                          Obx(
                            () => Text(
                              controller.textLevel.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: controller
                                          .getLevelColor(controller.level),
                                      fontFamily: 'Filson'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: IZISizeUtil.setSizeWithWidth(percent: .27),
                      child: Container(
                        alignment: Alignment.center,
                        width: IZISizeUtil.setSize(percent: .13),
                        height: IZISizeUtil.setSize(percent: .03),
                        decoration: BoxDecoration(
                          color: ColorResources.BACKGROUND,
                          borderRadius:
                              BorderRadius.circular(IZISizeUtil.RADIUS_2X),
                        ),
                        child: Text(
                          // làm sao để Let's không  bị lỗi
                          '${controller.count.value}/10',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: ColorResources.WHITE,
                                  fontFamily: 'Filson'),
                        ),
                      ),
                    ),
                    if (controller.isSkip)
                      Positioned(
                        bottom: IZISizeUtil.setSizeWithWidth(percent: .09),
                        right: IZISizeUtil.setSizeWithWidth(percent: .04),
                        child: GestureDetector(
                          onTap: () {
                            controller.getCountSkip();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: IZISizeUtil.setSize(percent: .045),
                            height: IZISizeUtil.setSize(percent: .045),
                            decoration: BoxDecoration(
                              color: ColorResources.WHITE,
                              borderRadius:
                                  BorderRadius.circular(IZISizeUtil.RADIUS_2X),
                              border:
                                  Border.all(color: ColorResources.LIGHT_BLUE),
                            ),
                            child: const Icon(
                              Icons.double_arrow_rounded,
                              size: 30,
                              color: ColorResources.BACKGROUND,
                              weight: 800,
                            ),
                          ),
                        ),
                      )
                    else
                      const SizedBox(),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                    padding: IZISizeUtil.setEdgeInsetsOnly(
                        left: IZISizeUtil.setSizeWithWidth(percent: .13),
                        right: IZISizeUtil.setSizeWithWidth(percent: .13)),
                    itemCount: controller.currentOptions.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: IZISizeUtil.SPACE_3X,
                      crossAxisSpacing: IZISizeUtil.SPACE_4X,
                      childAspectRatio: 1.28, //
                    ),
                    itemBuilder: (context, index) => Obx(() {
                          // ignore: prefer_final_locals
                          Map<int, Color> answerColors =
                              controller.answerColors;
                          // final buttonColor = controller.answerColors[
                          //         controller.currentOptions[index]] ??
                          //     ColorResources.MATHGAME_BUTTON_BG;
                          return GridViewContainer(
                            onTap: () {
                              controller.checkAnswer(
                                  controller.currentOptions[index]);
                              print(controller.answerColors[
                                  controller.currentOptions[index]]);
                            },
                            // ignore: invalid_use_of_protected_member
                            titleText: '${controller.currentOptions[index]}'.tr,

                            color: answerColors[
                                    controller.currentOptions[index]] ??
                                ColorResources.MATHGAME_BUTTON_BG,
                            borderColor: answerColors[
                                    controller.currentOptions[index]] ??
                                ColorResources.MATHGAME_BUTTON_BG,
                            // routerPage: MainRouters.EXPONENTS,
                            withBorder: 7,
                          );
                        })),
              )
            ],
          ),
        ),
      ),
    );
  }
}
