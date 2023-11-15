import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/helper/izi_validate.dart';
import 'package:template/core/utils/color_resources.dart';

enum IZIButtonType {
  DEFAULT,
  OUTLINE,
}

class IZIButton extends StatelessWidget {
  const IZIButton({
    Key? key,
    required this.onTap,
    this.label,
    this.height,
    this.maxLine,
    this.type = IZIButtonType.DEFAULT,
    this.isEnabled = true,
    this.padding,
    this.margin,
    this.borderRadius,
    this.fontFamily = 'Filson',
    this.icon,
    this.iconRight,
    this.imageUrlIconRight,
    this.color = ColorResources.WHITE,
    this.colorBGDisabled = ColorResources.GREY,
    this.colorDisible = ColorResources.OUTER_SPACE,
    this.colorBG = ColorResources.PRIMARY_1,
    this.colorIcon,
    this.colorText,
    this.imageUrlIcon,
    this.withBorder,
    this.width,
    this.fontSizedLabel,
    this.space,
    this.fontWeight,
    this.colorBorder,
    this.fillColor,
    this.sizeIcon,
    this.isGradient = false,
    this.gradientColorList,
    this.textAlign,
  }) : super(key: key);

  // OnTap
  // Decoration defaul nền xanh
  // Title defaul căn giữ , maxLine defaul 1 dòng , có thể truyền thêm số dòng, nếu quá dòng là overflow
  // clickble (có thể có or không defaul true) Nếu true click vào thì mới thực hiện onTap esle thì không
  final String? label;
  final Color? color;
  final Color? colorDisible;
  final Color? colorBGDisabled;
  final Color? colorBG;
  final Function onTap;
  final double? height;
  final int? maxLine;
  final IZIButtonType? type;
  final Color? colorIcon;
  final Color? colorText;
  final Color? colorBorder;
  final Color? fillColor;
  final String? fontFamily;

  final bool? isEnabled;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? borderRadius;
  final IconData? icon, iconRight;
  final String? imageUrlIcon, imageUrlIconRight;
  final double? withBorder;
  final double? width;
  final double? fontSizedLabel;
  final double? space;
  final double? sizeIcon;
  final FontWeight? fontWeight;
  final bool? isGradient;
  final List<Color>? gradientColorList;
  final TextAlign? textAlign;

  Color getColorBG(IZIButtonType type) {
    if (type == IZIButtonType.DEFAULT) {
      if (isEnabled!) {
        return colorBG!;
      }
      return colorBGDisabled!;
    } else if (type == IZIButtonType.OUTLINE) {
      if (isEnabled!) {
        return fillColor ?? ColorResources.BACK_GROUND;
      }
      return colorBGDisabled ?? ColorResources.WHITE;
    }
    return colorBG!;
  }

  Color getColor(IZIButtonType type) {
    if (type == IZIButtonType.DEFAULT) {
      if (isEnabled!) {
        return color!;
      }
      return colorDisible!;
    } else if (type == IZIButtonType.OUTLINE) {
      if (isEnabled!) {
        return colorBG!;
      }
      return ColorResources.GREY;
    }
    return color!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled!
          ? () {
              onTap();
            }
          : null,
      child: Container(
        width: width ?? IZISizeUtil.getMaxWidth(),
        height: height ?? IZISizeUtil.SPACE_2X,
        padding: padding ??
            IZISizeUtil.setEdgeInsetsSymmetric(
                vertical: IZISizeUtil.SPACE_2X,
                horizontal: IZISizeUtil.SPACE_2X),
        margin: margin ?? IZISizeUtil.setEdgeInsetsSymmetric(vertical: 5),
        decoration: BoxDecoration(
          gradient: !isGradient!
              ? null
              : LinearGradient(
                  colors: gradientColorList ??
                      const [
                        ColorResources.PRIMARY_1,
                        ColorResources.PRIMARY_2,
                      ],
                ),
          color: getColorBG(type!),
          border: type == IZIButtonType.DEFAULT
              ? null
              : Border.all(
                  color: colorBorder ?? ColorResources.PRIMARY_1,
                  width: withBorder ?? 1,
                ),
          borderRadius:
              IZISizeUtil.setBorderRadiusAll(radius: borderRadius ?? 100),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!IZIValidate.nullOrEmpty(imageUrlIcon))
              SizedBox(
                height: sizeIcon ?? IZISizeUtil.setSize(percent: .07),
                width: sizeIcon ?? IZISizeUtil.setSize(percent: .07),
                child: IZIImage(
                  imageUrlIcon.toString(),
                  colorIconsSvg: colorIcon ?? ColorResources.WHITE,
                ),
              ),
            if (icon != null)
              Icon(
                icon,
                color: colorIcon ?? ColorResources.WHITE,
                size: sizeIcon ?? IZISizeUtil.setSize(percent: .1),
              )
            else
              const SizedBox(),
            SizedBox(
              width:
                  space == null ? 0 : IZISizeUtil.setSize(percent: .1) * space!,
            ),
            if (label != null)
              Flexible(
                child: AutoSizeText(
                  "$label",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: fontSizedLabel ??
                            IZISizeUtil.LABEL_MEDIUM_FONT_SIZE,
                        color: colorText ?? getColor(type!),
                        fontWeight: fontWeight ?? FontWeight.w700,
                        fontFamily: fontFamily ?? 'Filson',
                      ),
                  maxLines: maxLine ?? 1,
                  textAlign: textAlign ?? TextAlign.center,
                  // hiện hết text dùng thuộc tính
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (!IZIValidate.nullOrEmpty(imageUrlIconRight))
              SizedBox(
                height: IZISizeUtil.setSize(percent: .2),
                width: IZISizeUtil.setSize(percent: .2),
                child: IZIImage(
                  imageUrlIconRight.toString(),
                ),
              ),
            if (iconRight != null)
              Icon(
                iconRight,
                color: colorIcon ?? getColor(type!),
                size: IZISizeUtil.setSize(percent: .125),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }
}
