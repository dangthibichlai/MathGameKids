import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/services/google_admod_services/native_ads_manager/native_ads_widget.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/begin_screen/choose_language/choose_language_controller.dart';

class ChooseLanguagePage extends GetView<ChooseLanguageController> {
  const ChooseLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        appBar: BaseAppBar(
          isFlexibleSpace: false,
          backgroundColor: ColorResources.BACK_GROUND,
          title: 'select_language_1'.tr,
          // title: 'select_language_1'.tr,
          leading: const SizedBox(),
          colorTitle: ColorResources.CHECK,
          titleStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w700,
                color: ColorResources.CHECK,
              ),
          actions: [
            Obx(
              () {
                if (!controller.isAllowSkip.value) {
                  return const SizedBox();
                }
                return Container(
                  margin: IZISizeUtil.setEdgeInsetsOnly(
                      right: IZISizeUtil.SPACE_1X),
                  color: ColorResources.BACK_GROUND,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.onSelectLanguageChange();
                        },
                        icon: const Icon(
                          Icons.done,
                          color: ColorResources.CHECK,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: IZISizeUtil.SPACE_3X),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: controller.multipleLanguages.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => GestureDetector(
                      onTap: () => controller.onLanguageChange(controller
                          .multipleLanguages[index]['valueNumber'] as int),
                      child: Container(
                        padding:
                            IZISizeUtil.setEdgeInsetsAll(IZISizeUtil.SPACE_2X),
                        width: IZISizeUtil.getMaxWidth(),
                        margin: IZISizeUtil.setEdgeInsetsOnly(
                          left: IZISizeUtil.SPACE_4X,
                          right: IZISizeUtil.SPACE_4X,
                          bottom: IZISizeUtil.SPACE_2X,
                        ),
                        decoration: BoxDecoration(
                          color: ColorResources.WHITE,
                          borderRadius: IZISizeUtil.setBorderRadiusAll(
                              radius: IZISizeUtil.RADIUS_SMALL),
                          // them vien khi chon ngon ngu

                          // ignore: unrelated_type_equality_checks
                          border: controller.currentIndex ==
                                  controller.multipleLanguages[index]
                                      ['valueNumber']
                              ? Border.all(
                                  color: ColorResources.CHECK,
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: IZISizeUtil.setEdgeInsetsOnly(
                                  right: IZISizeUtil.SPACE_2X),
                              width: IZISizeUtil.setSize(percent: .04),
                              height: IZISizeUtil.setSize(percent: .04),
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: IZIImage(
                                controller.multipleLanguages[index]['image']
                                    .toString(),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                controller.multipleLanguages[index]['name']
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Obx(
                              () {
                                return CircleAvatar(
                                  radius: 15,
                                  backgroundColor: ColorResources.WHITE,
                                  child: controller.multipleLanguages[index]
                                              ['valueNumber'] as int ==
                                          controller.languageGroupValue.value
                                      ? _radioCheck()
                                      : _radio(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Show banner ads.
            NativeAdsWidget(
              callBack: () {
                controller.showSkipLanguage();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _radio() {
    return Container(
      width: 21,
      height: 21,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: OvalBorder(
          side: BorderSide(color: Color(0xFF18C0FF)),
        ),
      ),
    );
  }

  Widget _radioCheck() {
    return SizedBox(
      width: 21,
      height: 21,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 21,
              height: 21,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: OvalBorder(
                  side: BorderSide(color: ColorResources.CHECK),
                ),
              ),
            ),
          ),
          Positioned(
            left: 3,
            top: 3,
            child: Container(
              width: 15,
              height: 15,
              decoration: const ShapeDecoration(
                color: ColorResources.CHECK,
                shape: OvalBorder(
                  side: BorderSide(color: ColorResources.CHECK),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
