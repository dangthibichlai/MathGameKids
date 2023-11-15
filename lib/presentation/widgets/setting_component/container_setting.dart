import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';

class ContainerSetting extends StatelessWidget {
  const ContainerSetting(
      {super.key,
      this.urlInmage,
      this.title,
      this.isCheck,
      this.isSound,
      this.statusSound = true});
  final String? urlInmage;
  final String? title;
  final bool? isCheck;
  final bool? isSound;
  final bool? statusSound;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: IZISizeUtil.setEdgeInsetsOnly(
          left: IZISizeUtil.setSizeWithWidth(percent: .05),
          right: IZISizeUtil.setSizeWithWidth(percent: .01)),
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
          urlInmage ?? ImagesPath.prediumIcon,
          width: IZISizeUtil.setSizeWithWidth(percent: .08),
          height: IZISizeUtil.setSizeWithWidth(percent: .08),
        ),
        const SizedBox(width: IZISizeUtil.SPACE_4X),
        SizedBox(
          width: IZISizeUtil.setSizeWithWidth(percent: .6),
          child: AutoSizeText(
            title ?? '',
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
            ? GestureDetector(
                onTap: () {},
                child: Expanded(
                  child: Container(
                    width: IZISizeUtil.setSizeWithWidth(percent: .1),
                    height: IZISizeUtil.setSizeWithWidth(percent: .1),
                    margin: IZISizeUtil.setEdgeInsetsOnly(
                        left: IZISizeUtil.setSizeWithWidth(percent: .005)),
                    decoration: BoxDecoration(
                      color:
                          const Color.fromARGB(255, 2, 34, 117).withOpacity(.5),
                      borderRadius:
                          BorderRadius.circular(IZISizeUtil.RADIUS_1X),
                      // image: DecorationImage(
                      //   image: AssetImage(ImagesPath.checkIcon),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    child: (statusSound ?? true)
                        ? null
                        : IZIImage(ImagesPath.checkIcon),
                  ),
                ),
              )
            : const SizedBox(),
      ]),
    );
  }
}
