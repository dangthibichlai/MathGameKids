// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/opinion_play/play_fractice/model/fraction_model.dart';
import 'package:template/presentation/pages/opinion_play/widget/text_praction.dart';
import 'package:template/presentation/widgets/grid_view_component.dart';

class ShowAnswerDif extends StatelessWidget {
  const ShowAnswerDif({
    super.key,
    this.currentOptions,
    required this.onTapAnswer,
    this.isTrueFalse,
    this.answerColors,
    //  required this.textAnswer
  });
  // final Widget textAnswer;
  final List<Fraction>? currentOptions;
  final Function onTapAnswer;
  final bool? isTrueFalse;
  final Map<int, Color>? answerColors;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Expanded(
          child: Padding(
        padding: IZISizeUtil.setEdgeInsetsOnly(
          left: IZISizeUtil.setSizeWithWidth(percent: .13),
          right: IZISizeUtil.setSizeWithWidth(percent: .13),
        ),
        child: GriViewComponent(
            padding: EdgeInsets.zero,
            mainAxisSpacing: IZISizeUtil.SPACE_2X,
            crossAxisSpacing: IZISizeUtil.SPACE_2X,
            childAspectRatio: 1.4,
            itemCount: currentOptions!.length,
            itemBuilder: (context, index) {
              // ignore: prefer_final_locals
              //Map<int, Color> colorButton = answerColors ?? {};
              return Obx(
                () => GestureDetector(
                  onTap: () => onTapAnswer(index),
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: IZISizeUtil.setSizeWithWidth(percent: .1),
                    ),
                    padding: IZISizeUtil.setEdgeInsetsOnly(
                      left: IZISizeUtil.setSizeWithWidth(percent: .05),
                      right: IZISizeUtil.setSizeWithWidth(percent: .05),
                    ),
                    // height: IZISizeUtil.setSizeWithWidth(percent: .12),
                    // width: IZISizeUtil.setSizeWithWidth(percent: .1),
                    decoration: BoxDecoration(
                      color: answerColors![index] ??
                          ColorResources.MATHGAME_BUTTON_BG,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: answerColors![index] ??
                              ColorResources.BD_BT_ANSWER,
                          width: 7),
                    ),
                    child: FittedBox(
                      // text không bị tràn ra ngoài và không bị ẩn đi
                      fit: BoxFit.scaleDown,

                      //alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: IZISizeUtil.setEdgeInsetsOnly(
                          left: IZISizeUtil.setSizeWithWidth(percent: .01),
                          right: IZISizeUtil.setSizeWithWidth(percent: .01),
                        ),
                        child: TextPraction(
                            fontWeight: FontWeight.w600,
                            fraction: currentOptions![index],
                            context: context,
                            // height: 10,
                            thickness: 6,
                            colorText: ColorResources.WHITE,
                            colorFraction: ColorResources.WHITE),
                      ),
                    ),
                  ),
                ),
              );
            }),
      )),
    );
  }
}
