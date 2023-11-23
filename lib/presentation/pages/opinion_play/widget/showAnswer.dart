// ignore_for_file: file_names

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/widgets/banner_ads.dart';
import 'package:template/presentation/widgets/grid_view_component.dart';
import 'package:template/presentation/widgets/home_component/gri_container.dart';

import '../../../../core/helper/izi_size_util.dart';

class ShowAnswer extends StatelessWidget {
  const ShowAnswer(
      {super.key,
      required this.currentOptions,
      required this.onTapAnswer,
      this.isTrueFalse,
      this.answerColors,
      this.mainAxisSpacing,
      this.crossAxisSpacing,
      this.childAspectRatio,
      this.itemCount,
      this.padding,
      this.isEnabled});
  final List<dynamic> currentOptions;
  final Function onTapAnswer;
  final bool? isTrueFalse;
  final Map<dynamic, Color>? answerColors;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final double? childAspectRatio;
  final int? itemCount;
  final EdgeInsetsGeometry? padding;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Expanded(
        child: Column(
          children: [
            GriViewComponent(
              padding: padding ??
                  IZISizeUtil.setEdgeInsetsOnly(
                    left: IZISizeUtil.setSizeWithWidth(percent: .14),
                    right: IZISizeUtil.setSizeWithWidth(percent: .14),
                  ),
              itemCount: itemCount ?? 4,

              mainAxisSpacing: mainAxisSpacing ?? IZISizeUtil.SPACE_1X,
              crossAxisSpacing: crossAxisSpacing ?? IZISizeUtil.SPACE_3X,
              childAspectRatio: childAspectRatio ?? 1.2, //

              itemBuilder: (BuildContext context, index) {
                final Map<dynamic, Color> colorButton = answerColors ?? {};
                return GridViewContainer(
                  onTap: () {
                    onTapAnswer(index);
                  },
                  disabledColor: colorButton[currentOptions[index]] ?? ColorResources.MATHGAME_BUTTON_BG,
                  titleText: '${currentOptions[index]}'.tr,
                  fontSizedLabel: IZISizeUtil.DISPLAY_LARGE_FONT_SIZE_ANSWER,
                  color: colorButton[currentOptions[index]] ?? ColorResources.MATHGAME_BUTTON_BG,
                  borderColor: colorButton[currentOptions[index]] ?? ColorResources.BD_BT_ANSWER,
                  // routerPage: MainRouters.EXPONENTS,
                  withBorder: 7,
                );
              },
            ),
            const Spacer(),
            Expanded(child: Get.find<DashBoardController>().isPremium.value ? const SizedBox() : const BannerAdsFram())
            // Get.find<DashBoardController>().isPremium.value
            //   return const SizedBox();
            // }
            // const BannerAdsFram()),
          ],
        ),
      ),
    );
  }
}
