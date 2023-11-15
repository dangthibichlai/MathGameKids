import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';

class ContainerResult extends StatelessWidget {
  const ContainerResult(
      {super.key,
      this.title,
      this.numberAnswer,
      this.icon,
      this.colorBackground = ColorResources.WHITE,
      this.colorIcon = ColorResources.WHITE,
      required this.boderColor,
      this.width,
      this.height});
  final String? title;
  final int? numberAnswer;
  final IconData? icon;
  final Color colorBackground;
  final Color colorIcon;
  final Color boderColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: IZISizeUtil.setEdgeInsetsOnly(
          top: IZISizeUtil.setSizeWithWidth(percent: .03)),
      height: height ?? IZISizeUtil.setSizeWithWidth(percent: .2),
      decoration: BoxDecoration(
        color: ColorResources.BLUE_MG,
        borderRadius: BorderRadius.circular(IZISizeUtil.RADIUS_3X),
        border: Border.all(color: ColorResources.BD_RES, width: 5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: IZISizeUtil.RADIUS_4X * 2,
            height: IZISizeUtil.RADIUS_4X * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: boderColor, // Màu viền trắng
                width: 3, // Độ dày viền
              ),
            ),
            child: CircleAvatar(
              backgroundColor: colorBackground,
              child: Icon(
                icon ?? Icons.check,
                color: colorIcon,
              ),
            ),
          ),
          SizedBox(
            width: IZISizeUtil.setSizeWithWidth(percent: .5),
            child: AutoSizeText(
              title ?? '',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorResources.WHITE,
                  fontFamily: 'Filson'),
              maxLines: 1,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: IZISizeUtil.setSizeWithWidth(percent: .1),
            height: IZISizeUtil.setSizeWithWidth(percent: .11),
            decoration: BoxDecoration(
              color: ColorResources.MATHPRIMARY2,
              borderRadius: BorderRadius.circular(IZISizeUtil.RADIUS_1X),
              // border: Border.all(
              //     color: ColorResources.MATHGAME_BORDER, width: 1),
            ),
            child: Text(
              '$numberAnswer'.tr,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: ColorResources.WHITE,
                  fontFamily: 'Filson'),
            ),
          )
        ],
      ),
    );
  }
}
