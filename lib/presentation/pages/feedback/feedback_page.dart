import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/widgets/lottie_widget/lottie_widget.dart';

import 'feedback_controller.dart';

class FeedbackPage extends GetView<FeedbackController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: Gradients.feedbackScafold,
        ),
        height: IZISizeUtil.getMaxHeight(),
        width: IZISizeUtil.getMaxWidth(),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              _backGround(context),

              // Bottom.
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      padding: IZISizeUtil.setEdgeInsetsOnly(
                        top: IZISizeUtil.SPACE_5X,
                      ),
                      decoration: BoxDecoration(
                          gradient: Gradients.feedbackBottom,
                          borderRadius: BorderRadius.only(
                            topLeft: IZISizeUtil.setRadiusCircular(
                                radius: IZISizeUtil.RADIUS_3X),
                            topRight: IZISizeUtil.setRadiusCircular(
                                radius: IZISizeUtil.RADIUS_3X),
                          )),
                      width: IZISizeUtil.getMaxWidth(),
                      child: Column(
                        children: [
                          _category(),
                          Padding(
                            padding: IZISizeUtil.setEdgeInsetsSymmetric(
                              vertical: IZISizeUtil.SPACE_2X,
                              horizontal: IZISizeUtil.SPACE_3X,
                            ),
                            child: IZIInput(
                              controller: controller.feedbackController,
                              placeHolder: 'feedback_003'.tr,
                              type: IZIInputType.TEXT,
                              style: TextStyle(
                                  color: ColorResources.WHITE,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                              maxLine: 7,
                              fillColor: Colors.transparent,
                            ),
                          ),
                          Container(
                            padding: IZISizeUtil.setEdgeInsetsSymmetric(
                                horizontal: IZISizeUtil.SPACE_3X),
                            width: IZISizeUtil.getMaxWidth(),
                            height: IZISizeUtil.setSize(percent: .12),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              child: Obx(
                                () {
                                  return Row(
                                    children: [
                                      ...List.generate(
                                          controller.fileFeedBack.length,
                                          (index) {
                                        return SizedBox(
                                          width:
                                              IZISizeUtil.setSize(percent: .12),
                                          height:
                                              IZISizeUtil.setSize(percent: .12),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: ClipRRect(
                                                  borderRadius: IZISizeUtil
                                                      .setBorderRadiusAll(
                                                          radius: IZISizeUtil
                                                              .RADIUS_1X),
                                                  child: IZIImage.file(
                                                    controller
                                                        .fileFeedBack[index],
                                                    height: IZISizeUtil.setSize(
                                                        percent: .11),
                                                    width: IZISizeUtil.setSize(
                                                        percent: .11),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 3,
                                                child: InkWell(
                                                  onTap: () {
                                                    controller.deleteImage(
                                                        index: index);
                                                  },
                                                  child: IZIImage(
                                                    ImagesPath.feedbackIcDelete,
                                                    width: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                      if (controller.fileFeedBack.length < 3)
                                        _pickImageFeedBackButton(context)
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          IZIButton(
                            type: IZIButtonType.OUTLINE,
                            height: IZISizeUtil.setSize(percent: .06),
                            isGradient: true,
                            gradientColorList: const [
                              ColorResources.BACKGROUND,
                              ColorResources.BACKGROUND_2
                            ],
                            borderRadius: IZISizeUtil.RADIUS_3X,
                            colorText: ColorResources.WHITE,
                            margin: IZISizeUtil.setEdgeInsetsSymmetric(
                              horizontal: IZISizeUtil.SPACE_3X,
                              vertical: IZISizeUtil.SPACE_4X,
                            ),
                            label: 'feedback_005'.tr,
                            onTap: () {
                              controller.sendFeedback();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: IZISizeUtil.setEdgeInsetsSymmetric(
          horizontal: IZISizeUtil.SPACE_1X,
          vertical: IZISizeUtil.SPACE_4X,
        ),
        child: InkWell(
          onTap: () {
            CommonHelper.onTapHandler(callback: () {
              Get.back();
            });
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
            size: 20,
          ),
        ),
      ),
    );
  }

  Column _pickImageFeedBackButton(BuildContext context) {
    return Column(
      mainAxisAlignment: controller.fileFeedBack.isEmpty
          ? MainAxisAlignment.end
          : MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            controller.pickImage();
          },
          child: Padding(
            padding: IZISizeUtil.setEdgeInsetsOnly(
                left:
                    controller.fileFeedBack.isEmpty ? 0 : IZISizeUtil.SPACE_2X),
            child: Row(
              children: [
                Container(
                  width: IZISizeUtil.setSize(percent: .04),
                  height: IZISizeUtil.setSize(percent: .04),
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE.withOpacity(.3),
                    borderRadius: IZISizeUtil.setBorderRadiusAll(
                        radius: IZISizeUtil.RADIUS_2X),
                  ),
                  child: Icon(
                    Icons.add,
                    color: ColorResources.WHITE.withOpacity(.6),
                  ),
                ),
                if (controller.fileFeedBack.isEmpty)
                  Padding(
                    padding: IZISizeUtil.setEdgeInsetsOnly(
                        left: IZISizeUtil.SPACE_2X),
                    child: Text(
                      'feedback_004'.tr,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: ColorResources.WHITE,
                          ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  SizedBox _category() {
    return SizedBox(
      height: IZISizeUtil.setSize(percent: .05),
      width: IZISizeUtil.getMaxWidth(),
      child: ListView.separated(
        physics: const ClampingScrollPhysics(),
        padding: IZISizeUtil.setEdgeInsetsSymmetric(
            horizontal: IZISizeUtil.SPACE_3X),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.feedBackData.length,
        itemBuilder: (context, index) {
          return Obx(() {
            return GestureDetector(
              onTap: () {
                controller.onChangeCurrentIndex(index: index);
              },
              child: Container(
                padding: IZISizeUtil.setEdgeInsetsSymmetric(
                    horizontal: IZISizeUtil.SPACE_3X),
                decoration: BoxDecoration(
                  color: controller.currentIndex.value == index
                      ? ColorResources.BT_TRO2
                      : ColorResources.WHITE.withOpacity(.2),
                  borderRadius: IZISizeUtil.setBorderRadiusAll(
                      radius: IZISizeUtil.RADIUS_2X),
                ),
                child: Center(
                  child: Text(
                    controller.feedBackData[index].toString(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ColorResources.WHITE,
                        ),
                  ),
                ),
              ),
            );
          });
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: IZISizeUtil.SPACE_3X);
        },
      ),
    );
  }

  Column _backGround(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieWidget(
              jsonPath: ImagesPath.settingJsonFeedback,
              width: IZISizeUtil.setSizeWithWidth(percent: .6),
            ),
          ],
        ),
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_2X),
          child: Text(
            'feedback_001'.tr,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorResources.WHITE,
                ),
          ),
        ),
        Padding(
          padding: IZISizeUtil.setEdgeInsetsSymmetric(
            horizontal: IZISizeUtil.SPACE_HORIZONTAL_SCREEN,
          ),
          child: Text(
            'feedback_002'.tr,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: ColorResources.WHITE,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
