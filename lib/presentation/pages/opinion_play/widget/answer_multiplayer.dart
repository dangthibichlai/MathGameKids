import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/widgets/home_component/gri_container.dart';

class ShowAnswerMultiplayerWidget extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final int? itemCount;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final double? childAspectRatio;
  final Map<int, Color>? answerColors;
  final List<dynamic>? currentOptions;
  final Function onTapAnswer;
  final bool? isEnabled;

  const ShowAnswerMultiplayerWidget({
    this.padding,
    this.itemCount,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.childAspectRatio,
    this.answerColors,
    this.currentOptions,
    required this.onTapAnswer,
    this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Expanded(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: padding ??
              IZISizeUtil.setEdgeInsetsOnly(
                left: IZISizeUtil.setSizeWithWidth(percent: .14),
                right: IZISizeUtil.setSizeWithWidth(percent: .14),
              ),
          itemCount: itemCount ?? 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: mainAxisSpacing ?? IZISizeUtil.SPACE_1X,
            crossAxisSpacing: crossAxisSpacing ?? IZISizeUtil.SPACE_3X,
            childAspectRatio: childAspectRatio ?? 1.2,
            crossAxisCount: 2, // You can adjust this count as needed
          ),
          itemBuilder: (BuildContext context, index) {
            print('abc: $isEnabled');
            // ignore: prefer_final_locals
            Map<dynamic, Color> colorButton = answerColors ?? {};
            return GridViewContainer(
              disabledColor: colorButton[index] ?? ColorResources.NUMBER_MEMORY,
              isEnabled: isEnabled ?? true,
              onTap: () {
                onTapAnswer(index);
              },
              titleText: '${currentOptions![index]}'.tr,
              isOutline: isEnabled == true,
              fontSizedLabel: IZISizeUtil.DISPLAY_LARGE_FONT_SIZE_ANSWER,
              borderColor: colorButton[index] ?? ColorResources.BD_BT_ANSWER,
              withBorder: 7,
            );
          },
        ),
      ),
    );
  }
}
