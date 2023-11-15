import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/pages/change_language/change_language_controller.dart';

class ChangeLanguagePage extends GetView<ChangeLanguageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND,
      appBar: BaseAppBar(
        title: 'select_language_1'.tr,
        actions: const [],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: CommonHelper.backGroundScaffold,
        ),
        width: IZISizeUtil.getMaxWidth(),
        height: IZISizeUtil.getMaxHeight(),
        child: GetBuilder(
          init: ChangeLanguageController(),
          builder: (ChangeLanguageController controller) {
            if (controller.isLoading) {
              return const Center(child: LoadingApp());
            }
            return GridView.builder(
              padding: IZISizeUtil.setEdgeInsetsSymmetric(
                  horizontal: IZISizeUtil.SPACE_2X,
                  vertical: IZISizeUtil.SPACE_3X),
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.multipleLanguages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: IZISizeUtil.SPACE_1X,
                crossAxisSpacing: IZISizeUtil.SPACE_1X,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    CommonHelper.onTapHandler(callback: () {
                      controller.onSelectLanguage(index);
                    });
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        left: IZISizeUtil.SPACE_1X,
                        top: IZISizeUtil.SPACE_1X,
                        right: IZISizeUtil.SPACE_1X,
                        bottom: 0,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: (controller.multipleLanguages[index]
                                    ['isSelected'] as bool)
                                ? ColorResources.BACK_GROUND
                                : ColorResources.GREY.withOpacity(.05),
                            borderRadius:
                                BorderRadius.circular(IZISizeUtil.RADIUS_3X),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipOval(
                                child: IZIImage(
                                  controller.multipleLanguages[index]['image']
                                      .toString(),
                                  width: IZISizeUtil.setSize(percent: .08),
                                  height: IZISizeUtil.setSize(percent: .08),
                                ),
                              ),
                              if (!(controller.multipleLanguages[index]
                                  ['isSelected'] as bool))
                                Text(
                                  controller.multipleLanguages[index]['name']
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: ColorResources.WHITE
                                            .withOpacity(.5),
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                      ),
                      if (controller.multipleLanguages[index]['isSelected']
                          as bool)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: IZISizeUtil.setEdgeInsetsAll(
                                IZISizeUtil.SPACE_1X),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorResources.PRIMARY_1,
                                  ColorResources.PRIMARY_4,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: IZIImage(
                              ImagesPath.iapIcDoneIcon,
                              width: IZISizeUtil.setSize(percent: .015),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
