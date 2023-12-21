import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/pages/opinion_play/play_memory/play_memory_controller.dart';
import 'package:template/presentation/widgets/banner_ads.dart';
import 'package:template/presentation/widgets/grid_view_component.dart';
import 'package:template/presentation/widgets/home_component/gri_container.dart';

import '../../../widgets/button_animated.dart';

class PlayMemoryPage extends GetView<PlayMemoryController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        // controller.reset();
        // controller.onInit();
        ExtendBackAds.onBackPress(controller.route);
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorResources.BACKGROUND,
        appBar: BaseAppBar(
          title: controller.title,
          leading: IconButton(
            onPressed: () {
              Get.back();
              ExtendBackAds.onBackPress(controller.route);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Obx(
          () => Column(
            children: [
              // hiện text trong 10s rồi ẩn đi
              SizedBox(
                height: IZISizeUtil.setSize(percent: .07),
                width: IZISizeUtil.getMaxWidth(),
                child: Padding(
                  padding: IZISizeUtil.setEdgeInsetsOnly(
                    left: IZISizeUtil.setSizeWithWidth(percent: .02),
                    right: IZISizeUtil.setSizeWithWidth(percent: .02),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: IZISizeUtil.setSize(percent: .02),
                        left: IZISizeUtil.setSizeWithWidth(percent: .1),
                        child: controller.isDone.value
                            ? Row(
                                children: [
                                  IZIImage(
                                    ImagesPath.star_memory,
                                    width: 50,
                                    height: 50,
                                  ),
                                  Text(
                                    "GOOD JOB!".tr,
                                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                        fontWeight: FontWeight.w900, color: ColorResources.WHITE, fontFamily: 'Filson'),
                                  ),
                                  IZIImage(
                                    ImagesPath.star_memory,
                                    width: 50,
                                    height: 50,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ),
                      Padding(
                        padding: IZISizeUtil.setEdgeInsetsOnly(
                          top: IZISizeUtil.setSize(percent: .04),
                          left: IZISizeUtil.setSizeWithWidth(percent: .17),
                        ),
                        child: AnimatedOpacity(
                          opacity: controller.isVisible.value ? 1.0 : 0.0,
                          duration: const Duration(seconds: 1),
                          child: Text(
                            "Remember numbers!".tr,
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.w900, color: ColorResources.WHITE, fontFamily: 'Filson'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // SizedBox(
              //   height: IZISizeUtil.setSizeWithWidth(percent: .02),
              // ),
              Expanded(
                child: Obx(
                  () => Column(
                    children: [
                      GriViewComponent(
                          padding: IZISizeUtil.setEdgeInsetsAll(IZISizeUtil.setSizeWithWidth(percent: .03)),
                          childAspectRatio: .92,
                          crossAxisCount: 3,
                          // childAspectRatio : 1.9,
                          crossAxisSpacing: IZISizeUtil.SPACE_2X,
                          mainAxisSpacing: IZISizeUtil.SPACE_1X,
                          itemCount: controller.listGrid.length,
                          itemBuilder: (context, index) {
                            final item = controller.listGrid[index];
                            return GridViewContainer(
                              maxLine: 2,
                              withBorder: 7,
                              fontWeight: FontWeight.w900,

                              fontSizedLabel: IZISizeUtil.DISPLAY_LARGE_FONT_SIZE,
                              // height: IZISizeUtil.setSizeWithWidth(percent: .4),
                              onTap: () => controller.flipTile(index),
                              titleText: item.expression,

                              colorText: (item.isFlipped ?? true) || (item.isMatched ?? false)
                                  ? ColorResources.NUMBER_MEMORY
                                  : ColorResources.MATHGAME_BUTTON_BG,
                              color: (item.isFlipped ?? true) || (item.isMatched ?? false)
                                  //  ? item.color ?? ColorResources.WHITE
                                  ? item.isMatched ?? false
                                      ? ColorResources.TRUE_MEMORY
                                      : ColorResources.WHITE
                                  : ColorResources.MATHGAME_BUTTON_BG,
                            );
                          }),
                      if (controller.isDone.value)
                        ButtonAnimated(
                          text: 'Play Again'.tr,
                          onTap: () {
                            // Chuyển tới trang hiện tại
                            //  controller.reset();
                            controller.reset();
                            controller.onInit();
                            if (controller.isRegistered) {
                              // controller.sound.playClickGameSound();
                            }
                          },
                        ),
                      SizedBox(
                        height: IZISizeUtil.setSize(percent: .014),
                      ),
                      Expanded(
                        child: Obx(() {
                          if (Get.find<DashBoardController>().isPremium.value) {
                            return const SizedBox();
                          }
                          return const BannerAdsFram();
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
