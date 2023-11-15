import 'package:flutter/material.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/presentation/pages/opinion_play/play_fractice/model/fraction_model.dart';
import 'package:template/presentation/pages/opinion_play/play_fractice/play_fractice_page.dart';

class TextPraction extends StatelessWidget {
  const TextPraction(
      {super.key,
      required this.fraction,
      required this.context,
      this.fontSize,
      this.fontWeight,
      this.height,
      this.colorText,
      this.thickness,
      this.colorFraction});
  final Fraction fraction;
  final BuildContext context;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final Color? colorText;
  final double? thickness;
  final Color? colorFraction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: IZISizeUtil.setSizeWithWidth(percent: .24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textNumber(fraction.numerator.toString(), context,
              fontSize: fontSize, fontWeight: fontWeight, colorText: colorText),
          divider(
              height: height,
              thickness: thickness,
              color: colorFraction,
              colorText:
                  colorFraction), // coi lại biến truyền là truyền color hay colorText
          textNumber(fraction.denominator.toString(), context,
              fontSize: fontSize, fontWeight: fontWeight, colorText: colorText),
        ],
      ),
    );
  }
}
