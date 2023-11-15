import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';
import 'package:template/config/routes/route_path/auth_routh.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/helper/common_helper.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/setting_package/setting_controller.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';
import '../../../core/base_widget/izi_image.dart';
import '../../../core/shared_pref/shared_preference_helper.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND,
      appBar: BaseAppBar(
        title: 'setting_1'.tr,
        leading: IconButton(
          onPressed: () {
            if (Get.isRegistered<SoundController>()) {
              Get.find<SoundController>().playClickCloseSound();
              // ExtendBackAds.onBackPress(MainRouters.HOME);
            }
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: const [SizedBox.shrink()],
      ),
      body: Center(
        child: SizedBox(
          height: IZISizeUtil.getMaxHeight(),
          width: IZISizeUtil.setSizeWithWidth(percent: .9),
          child: ListView(
            children: [
              Obx(
                () {
                  if (Get.find<DashBoardController>().isPremium.value) {
                    return const SizedBox();
                  }
                  return _settingContainer(
                    imagePath: ImagesPath.prediumIcon,
                    context: context,
                    title: 'setting_2'.tr,
                    onTap: () => Get.toNamed(AuthRouter.PRENIUM),
                  );
                },
              ),
              _settingContainer(
                imagePath: ImagesPath.restoreIcon,
                context: context,
                title: 'setting_3'.tr,
                onTap: controller.restorePurchase,
              ),
              _settingContainer(
                imagePath: ImagesPath.languageIcon,
                context: context,
                title: 'select_language_1'.tr,
                onTap: () {
                  CommonHelper.onTapHandler(callback: () {
                    controller.goToChangeLanguage();
                  });
                },
              ),

              _settingContainer(
                imagePath: ImagesPath.shareIcon,
                context: context,
                title: 'setting_4'.tr,
                onTap: () => controller.shareAppLink(),
              ),
              // _settingContainer(
              //   imagePath: ImagesPath.shareIcon,
              //   context: context,
              //   title: 'setting_4'.tr,
              //   onTap: () {
              //     Share.share(
              //       Platform.isAndroid
              //           ? sl<SharedPreferenceHelper>().getLinkAndroid
              //           : sl<SharedPreferenceHelper>().getLinkIos,
              //     );
              //   },
              //   // onTap: () => controller.shareAppLink(),
              // ),
              GetBuilder<SettingController>(
                id: SettingController.UPDATE_RATE_US,
                builder: (c) {
                  if (GetIt.I.get<SharedPreferenceHelper>().getIsRatedApp) {
                    return const SizedBox.shrink();
                  }
                  return _settingContainer(
                    imagePath: ImagesPath.startIcon,
                    context: context,
                    title: 'setting_5'.tr,
                    onTap: () {
                      CommonHelper.onTapHandler(callback: () {
                        controller.rateUs(context);
                      });
                    },
                    //onTap: () {
                    //   ShowDialog.showGenerateDialog(
                    //     context: context,
                    //     childWidget: RateUsDialog(
                    //       callBack: () {},
                    //     ),
                    //     isAllowCloseOutSize: false,
                    //   );
                    // },
                  );
                },
              ),
              _settingContainer(
                imagePath: ImagesPath.contactsIcon,
                context: context,
                title: 'setting_6'.tr,
                //onTap: () {
                // Share.share(
                //   Platform.isAndroid
                //       ? sl<SharedPreferenceHelper>().getLinkAndroid
                //       : sl<SharedPreferenceHelper>().getLinkIos,
                // );
                onTap: controller.launchEmail,
                // }
              ),
              Obx(
                () => _settingContainer(
                  imagePath: ImagesPath.musicIcon,
                  context: context,
                  title: 'setting_7'.tr,
                  isCheck: true,
                  statusSound: controller.isCheckMusic.value,
                  onTap: controller.onCheckMusic,
                ),
              ),
              Obx(
                () => _settingContainer(
                  imagePath: ImagesPath.soundIcon,
                  context: context,
                  title: 'setting_8'.tr,
                  isCheck: true,
                  statusSound: controller.isCheckSound.value,
                  onTap: controller.onCheckSound,
                ),
              ),
              // _settingContainer(
              //   imagePath: ImagesPath.mu,
              //   context: context,
              //   title: 'setting_8'.tr,
              //   onTap: () => controller.changeLanguage(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  Widget _settingContainer(
      {required String imagePath,
      required BuildContext context,
      required String title,
      bool? isCheck,
      bool? statusSound,
      required Function onTap}) {
    return GestureDetector(
      onTap: () => CommonHelper.onTapHandler(callback: () {
        onTap();
      }),
      child: Container(
        padding: IZISizeUtil.setEdgeInsetsOnly(
          left: IZISizeUtil.setSizeWithWidth(percent: .05),
          //right: IZISizeUtil.setSizeWithWidth(percent: .01,
          //  )
        ),
        height: IZISizeUtil.setSizeWithWidth(percent: .16),
        width: IZISizeUtil.setSizeWithWidth(percent: .9),
        margin: IZISizeUtil.setEdgeInsetsOnly(top: IZISizeUtil.SPACE_4X),
        decoration: BoxDecoration(
          color: ColorResources.BG,
          borderRadius: BorderRadius.circular(IZISizeUtil.RADIUS_2X),
          border: Border.all(
            color: const Color.fromARGB(255, 54, 90, 174).withOpacity(.5),
            width: 2,
          ),
        ),
        child: Row(children: [
          IZIImage(
            imagePath,
            width: IZISizeUtil.setSizeWithWidth(percent: .08),
            height: IZISizeUtil.setSizeWithWidth(percent: .08),
          ),
          const SizedBox(width: IZISizeUtil.SPACE_4X),
          SizedBox(
            width: IZISizeUtil.setSizeWithWidth(percent: .6),
            child: AutoSizeText(
              title,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorResources.WHITE,
                  fontFamily: 'Filson'),
              maxLines: 1,
            ),
          ),
          // const Spacer(),
          // ignore: prefer_if_elements_to_conditional_expressions
          isCheck ?? false
              ? Container(
                  width: IZISizeUtil.setSizeWithWidth(percent: .08),
                  height: IZISizeUtil.setSizeWithWidth(percent: .08),
                  margin: IZISizeUtil.setEdgeInsetsOnly(
                      left: IZISizeUtil.setSizeWithWidth(percent: .005)),
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 2, 34, 117).withOpacity(.5),
                    borderRadius: BorderRadius.circular(IZISizeUtil.RADIUS_1X),
                  ),
                  child: (statusSound ?? true)
                      ? const Icon(
                          Icons.check_outlined,
                          color: Colors.green,
                          size: 32,
                          weight: 900,
                        )
                      // ? IZIImage(ImagesPath.checkIcon)
                      : null,
                )
              : const SizedBox(),
        ]),
      ),
    );
  }
}
