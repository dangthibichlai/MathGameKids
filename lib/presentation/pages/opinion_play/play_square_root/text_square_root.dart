import 'package:flutter/material.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';

import '../../../../core/base_widget/izi_image.dart';
import '../../../../core/helper/izi_size_util.dart';

class TextSquare extends StatelessWidget {
  const TextSquare({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: IZISizeUtil.setSizeWithWidth(percent: .4),
      height: IZISizeUtil.setSize(percent: .08),
      child: Stack(
        children: [
          Positioned.fill(
              child: IZIImage(
            ImagesPath.squareRoot,
            width: IZISizeUtil.setSizeWithWidth(percent: .1),
            height: IZISizeUtil.setSize(percent: .15),
            fit: BoxFit.fill,
          )),
          Positioned(
            bottom: 0,
            left: IZISizeUtil.setSizeWithWidth(percent: .2),
            child: SizedBox(
              width: IZISizeUtil.setSizeWithWidth(percent: .2),
              height: IZISizeUtil.setSize(percent: .06),
              child: FittedBox(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w900,
                      color: ColorResources.BLUE_BLACK,
                      fontFamily: 'Filson'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
