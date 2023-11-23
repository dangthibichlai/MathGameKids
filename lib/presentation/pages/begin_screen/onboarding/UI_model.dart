// ignore_for_file: file_names

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';

import '../../../../core/base_widget/izi_image.dart';

class PageViewModel {
  final Widget? headerImage;
  final String? title;
  final String? subtitle;
  final Widget? bodyImage;
  final String? backgroundImage;
  final Color? backgroundColor;

  PageViewModel({
    this.headerImage,
    this.title,
    this.subtitle,
    this.bodyImage,
    this.backgroundImage,
    this.backgroundColor,
  });
}

List<PageViewModel> payViews = [
  PageViewModel(
    title: 'page_view_title_001'.tr,
    subtitle: 'page_view_subtitle_001'.tr,
    bodyImage: _bodyImage(ImagesPath.img4_next1),
    backgroundColor: ColorResources.NEXT_BG,
    headerImage: _headerImagePage1(),
  ),
  PageViewModel(
    title: 'page_view_title_002'.tr,
    subtitle: 'page_view_subtitle_002'.tr,
    bodyImage: _bodyImage(ImagesPath.img1_next2,
        height: IZISizeUtil.setSize(percent: .35), top: IZISizeUtil.setSize(percent: .3)),
    backgroundImage: ImagesPath.bg_next2,
    headerImage: _headerNext2(),
  ),
];
Widget _headerNext2() {
  return Stack(
    children: [
      Positioned(
        left: IZISizeUtil.setSizeWithWidth(percent: .01),
        top: IZISizeUtil.setSize(percent: 0.08),
        child: SizedBox(
          width: 98.29,
          height: 116.35,
          child: IZIImage(
            ImagesPath.img2_next2,
            width: IZISizeUtil.setSizeWithWidth(percent: .04),
            height: IZISizeUtil.setSizeWithWidth(percent: .08),
            colorIconsSvg: ColorResources.WHITE,
          ),
        ),
      ),
    ],
  );
}

Widget _bodyImage(
  String imgPath, {
  double? height,
  double? width,
  double? top,
  double? left,
}) {
  return Positioned(
    left: left ?? IZISizeUtil.setSizeWithWidth(percent: .22),
    top: top ?? IZISizeUtil.setSizeWithWidth(percent: .5),
    child: SizedBox(
      width: width ?? IZISizeUtil.setSizeWithWidth(percent: .52),
      height: height ?? IZISizeUtil.setSize(percent: .42),
      child: IZIImage(
        imgPath,
        colorIconsSvg: ColorResources.WHITE,
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget _headerImagePage1() {
  return Column(
    children: [
      ConstrainedBox(
        // maxWidth: IZISizeUtil.getMaxWidth(),
        // height: IZISizeUtil.setSize(percent: .22),
        constraints: BoxConstraints(
          maxWidth: IZISizeUtil.getMaxWidth(),
          maxHeight: IZISizeUtil.setSize(percent: .22),
        ),
        child: Stack(
          children: [
            Positioned(
              left: IZISizeUtil.setSizeWithWidth(percent: .03),
              top: IZISizeUtil.setSize(percent: .08),
              child: SizedBox(
                width: IZISizeUtil.setSizeWithWidth(percent: .27),
                height: IZISizeUtil.setSize(percent: .14),
                child: IZIImage(
                  ImagesPath.img1_next1,
                  width: IZISizeUtil.setSizeWithWidth(percent: .04),
                  colorIconsSvg: ColorResources.WHITE,
                ),
              ),
            ),
            Positioned(
              left: IZISizeUtil.setSizeWithWidth(percent: .3),
              top: IZISizeUtil.setSize(percent: .03),
              child: SizedBox(
                width: IZISizeUtil.setSizeWithWidth(percent: .4),
                height: IZISizeUtil.setSize(percent: .18),
                child: IZIImage(
                  ImagesPath.img2_next1,
                  width: IZISizeUtil.setSizeWithWidth(percent: .04),
                  //   height: IZISizeUtil.setSize(percent: .02),
                  colorIconsSvg: ColorResources.WHITE,
                ),
              ),
            ),
            Positioned(
              // left: 291.55,
              right: 0,
              top: IZISizeUtil.setSize(percent: .06),
              child: SizedBox(
                width: IZISizeUtil.setSizeWithWidth(percent: .25),
                height: IZISizeUtil.setSize(percent: .15),
                child: IZIImage(
                  ImagesPath.img3_next1,
                  // width: IZISizeUtil.setSizeWithWidth(percent: .04),
                  colorIconsSvg: ColorResources.WHITE,
                  //  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
