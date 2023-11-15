import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_button.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';

class GridViewContainer extends StatelessWidget {
  const GridViewContainer(
      {this.color = ColorResources.MATHGAME_BUTTON_BG,
      this.borderColor = ColorResources.MATHGAME_BORDER,
      this.routerPage,
      this.titleText,
      this.width,
      this.height,
      this.withBorder = 5,
      this.onTap,
      this.title,
      this.fontSizedLabel,
      this.colorText,
      this.fontWeight,
      this.maxLine,
      this.textAlign,
      this.sizeIcon,
      this.isEnabled,
      this.disabledColor,
      this.isOutline,
      this.boderRadius});
  final String? title; // urlImage : đường dẫn đến ảnh
  final Color color;
  final Color borderColor;
  final String? routerPage;
  final String? titleText;
  final double? width;
  final double? height;
  final double withBorder;
  final Function? onTap;
  final double? fontSizedLabel;
  final Color? colorText;
  final FontWeight? fontWeight;
  final int? maxLine;
  final TextAlign? textAlign;
  final double? sizeIcon;
  final bool? isEnabled;
  final Color? disabledColor;
  final bool? isOutline;
  final double? boderRadius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? IZISizeUtil.setSizeWithWidth(percent: .23),
      width: width ?? IZISizeUtil.setSizeWithWidth(percent: .8),
      child: IZIButton(
        borderRadius: boderRadius ?? IZISizeUtil.RADIUS_3X,
        isEnabled: isEnabled ?? true,
        maxLine: maxLine ?? 1,
        height: height ?? IZISizeUtil.setSizeWithWidth(percent: .23),
        colorText: colorText ?? ColorResources.WHITE,
        label: titleText ?? '',
        fontSizedLabel: fontSizedLabel,
        type: isOutline ?? true ? IZIButtonType.OUTLINE : IZIButtonType.DEFAULT,
        fontWeight: fontWeight,
        fillColor: color,
        withBorder: withBorder,
        colorBorder: borderColor,
        onTap: onTap ??
            () {
              Get.toNamed(routerPage!);
            },
        // nếu title là null thì sẽ không hiển thị title nữa
        imageUrlIcon: title,
        sizeIcon: sizeIcon,
        colorIcon: ColorResources.WHITE,
        textAlign: textAlign,
        colorBGDisabled: disabledColor,
      ),
    );
  }
}
