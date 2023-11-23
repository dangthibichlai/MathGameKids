import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/presentation/pages/addition/addition_page.dart';

class HeaderPage extends StatelessWidget {
  const HeaderPage(
      {super.key,
      this.urlInmage,
      this.top,
      this.bottom,
      this.width,
      this.height});
  final String? urlInmage;
  final double? top;
  final double? bottom;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: IZISizeUtil.setEdgeInsetsOnly(
            top: top ?? IZISizeUtil.setSizeWithWidth(percent: .09),
            bottom: bottom ?? IZISizeUtil.setSizeWithWidth(percent: .12),
          ),
          child: IZIImage(
            urlInmage ?? ImagesPath.aditionImage,
            width: width ?? IZISizeUtil.setSizeWithWidth(percent: .3),
            height: height ?? IZISizeUtil.setSizeWithWidth(percent: .3),
          ),
        ),
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(
              left: IZISizeUtil.setSizeWithWidth(percent: .009),
              bottom: IZISizeUtil.setSizeWithWidth(percent: .025)),
          child: Shimmer.fromColors(
            baseColor: ColorResources.WHITE.withOpacity(0),
            // const Color.fromRGBO(224, 224, 224, 1).withOpacity(0),
            highlightColor: ColorResources.WHITE.withOpacity(0.7),
            child: CustomPaint(
              size: const Size(98.0, 117.0),
              painter: HexagonalPainter(),
            ),
            // Container(
            //   width: IZISizeUtil.setSizeWithWidth(percent: .2),
            //   height: IZISizeUtil.setSizeWithWidth(percent: .2),
            //   color: ColorResources.BACKGROUND,
            // ),
          ),
        ),
      ],
    );
  }
}
