// ignore_for_file: avoid_field_initializers_in_const_classes

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/auth_routh.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar(
      {required this.title,
      this.onBack,
      this.actions,
      this.backgroundColor = Colors.transparent,
      this.titleStyle,
      this.leading,
      this.bottom,
      this.height = kToolbarHeight,
      this.elevation = 0,
      this.isFlexibleSpace = true,
      this.widgetText,
      this.urlImage,
      this.subTitle,
      this.isPremium = false,
      this.onTapRight,
      this.colorTitle});

  final String title;
  final String? subTitle;
  final Widget? leading;
  final Function? onBack;
  final Function? onTapRight;
  final List<Widget>? actions;
  final Color backgroundColor;
  final TextStyle? titleStyle;
  final PreferredSizeWidget? bottom;
  final double height;
  final double elevation;
  final bool? isFlexibleSpace;
  final Widget? widgetText;
  final String? urlImage;
  final bool isPremium;
  final Color? colorTitle;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: bottom,
      elevation: elevation,
      backgroundColor: backgroundColor,
      actions: actions ??
          [
            Obx(() {
              if (Get.find<DashBoardController>().isPremium.value) {
                return const SizedBox();
              }

              return Padding(
                padding:
                    IZISizeUtil.setEdgeInsetsOnly(right: IZISizeUtil.SPACE_3X),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Get.toNamed(MainRouters.PRENIUM);

                        onTapRight == null
                            ?
                            // ignore: unnecessary_statements
                            {
                                if (Get.isRegistered<SoundController>())
                                  {
                                    Get.find<SoundController>()
                                        .playClickPremiumSound(),
                                    Get.toNamed(AuthRouter.PRENIUM)
                                  }
                              }
                            : Get.back();
                      },
                      child:
                          (!Get.find<DashBoardController>().isPremium.value) &&
                                  isPremium
                              ? IZIImage(
                                  ImagesPath.prediumIcon,
                                  width: IZISizeUtil.setSize(percent: .04),
                                )
                              : const SizedBox(),
                    ),
                  ],
                ),
              );
            }),
            //  },
            // )
          ],
      foregroundColor: ColorResources.WHITE,
      surfaceTintColor: Colors.transparent,
      leading: leading ??
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  onBack ?? Get.back();
                  // : Get.toNamed(MainRouters.SETTING);
                },
                child: Container(
                  margin:
                      IZISizeUtil.setEdgeInsetsOnly(left: IZISizeUtil.SPACE_3X),
                  padding: IZISizeUtil.setEdgeInsetsOnly(
                    left: IZISizeUtil.SPACE_2X,
                    right: 3,
                    top: IZISizeUtil.SPACE_1X * 1.7,
                    bottom: IZISizeUtil.SPACE_1X * 1.7,
                  ),
                  decoration: const BoxDecoration(
                    // color: ColorResources.WHITE,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: ColorResources.WHITE,
                      size: IZISizeUtil.setSize(percent: 0.03),
                    ),
                  ),
                ),
              ),
            ],
          ),
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: subTitle ?? '',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: ColorResources.MATHPRIMARY,
                  ),
            ),
            TextSpan(
              text: title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorTitle ?? ColorResources.WHITE,
                  fontFamily: 'Filson'),
            ),
          ],
        ),
      ),
      flexibleSpace: isFlexibleSpace!
          ? Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    // ColorResources.APP_BAR_BG_1,
                    // ColorResources.APP_BAR_BG_2
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            )
          : null,
      centerTitle: true,
    );
  }
}
