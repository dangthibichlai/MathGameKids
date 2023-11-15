import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/widgets/home_component/gri_container.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

class DialogSelectDificult extends StatelessWidget {
  const DialogSelectDificult(
      {super.key,
      required this.textStudy,
      required this.isSkip,
      required this.routeNext,
      this.routeName});
  final String textStudy;
  final bool isSkip;
  final String routeNext;
  final String? routeName;

  @override
  Widget build(BuildContext context) {
    void _onTap(MATHLEVEL level) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playClickLevelSound();
      }
      Get.back();
      Get.toNamed(routeNext, arguments: {
        'level': level,
        'route': Get.currentRoute,
        'title': textStudy,
        'isSkip': isSkip,

        // lấy ra tên của route hiện tại
      });
      if (Get.isRegistered<SoundController>()) {
        print('stop bg sound at choose level');
        Get.find<SoundController>().pauseBackgroundSound();
        Get.find<SoundController>().playPlaySound();
      }
    }

    return Dialog(
      insetPadding: EdgeInsets.zero,
      // Thiết lập màu nền trong suốt
      backgroundColor: ColorResources.BACKGROUND.withOpacity(0.5),
      child: GestureDetector(
        onTap: () {
          //Get.toNamed(routeNext);
          Get.back();
        },
        child: Container(
          padding: IZISizeUtil.setEdgeInsetsOnly(
            top: IZISizeUtil.setSizeWithWidth(percent: .45),
          ),
          width: IZISizeUtil.getMaxWidth(),
          height: IZISizeUtil.getMaxHeight(),
          //   -  IZISizeUtil.setSizeWithWidth(percent: .9),
          decoration: BoxDecoration(
            color: ColorResources.BG_DIFICULT
                .withOpacity(.09), // Màu nền của nội dung dialog
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: IZISizeUtil.setEdgeInsetsOnly(
                  bottom: IZISizeUtil.setSizeWithWidth(percent: .15),
                ),
                child: Text(
                  'select_difficult'.tr,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorResources.WHITE,
                      fontFamily: 'Filson'),
                ),
              ),
              GridViewContainer(
                onTap: () {
                  print(Get.currentRoute);
                  _onTap(MATHLEVEL.EASY);
                },
                //routerPage: MainRouters.PLAYPAGE,
                titleText: 'easy'.tr.toUpperCase(),
                color: ColorResources.HOME_BG_3,
                borderColor: ColorResources.HOME_BD_3,
                fontSizedLabel: IZISizeUtil.DISPLAY_MEDIUM_FONT_SIZE,
                fontWeight: FontWeight.w600,
                //height: IZISizeUtil.setSizeWithWidth(percent: .9),
              ),
              const SizedBox(height: IZISizeUtil.SPACE_6X),
              GridViewContainer(
                onTap: () {
                  _onTap(MATHLEVEL.MEDIUM);
                },
                fontSizedLabel: IZISizeUtil.DISPLAY_MEDIUM_FONT_SIZE,
                fontWeight: FontWeight.w600,
                titleText: 'medium'.tr.toUpperCase(),
                borderColor: ColorResources.HOME_BD_7,
                // routerPage: MainRouters.ADDITION,
              ),
              const SizedBox(height: IZISizeUtil.SPACE_6X),
              GridViewContainer(
                onTap: () {
                  _onTap(MATHLEVEL.HARD);
                },
                titleText: 'hard'.tr.toUpperCase(),
                fontSizedLabel: IZISizeUtil.DISPLAY_MEDIUM_FONT_SIZE,
                fontWeight: FontWeight.w600,
                color: ColorResources.HOME_BG_4,
                borderColor: ColorResources.HOME_BD_4,
                // routerPage: MainRouters.DIVISION,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
