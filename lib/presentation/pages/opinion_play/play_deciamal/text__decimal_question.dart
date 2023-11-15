import 'package:flutter/material.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/opinion_play/play_deciamal/decimal_model.dart';
import 'package:template/presentation/pages/opinion_play/play_deciamal/text_decimal.dart';


import '../../../../core/helper/izi_size_util.dart';

class TextQuestionWidget extends StatelessWidget {
  final DecimalModel decimalModel1;
  final DecimalModel decimalModel2;
  final String operation;

  const TextQuestionWidget({
    required this.decimalModel1,
    required this.decimalModel2,
    required this.operation,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: EdgeInsets.only(
          right: IZISizeUtil.setSizeWithWidth(percent: .01),
          left: IZISizeUtil.setSizeWithWidth(percent: .01),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextNumberDecimalWidget(
                decimalModel: decimalModel1, context: context),
            Padding(
              padding: EdgeInsets.only(
                right: IZISizeUtil.setSizeWithWidth(percent: .01),
                left: IZISizeUtil.setSizeWithWidth(percent: .01),
              ),
              child: Text(
                operation,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w900,
                      color: ColorResources.BLUE_BLACK,
                      fontFamily: 'Filson',
                    ),
              ),
            ),
            TextNumberDecimalWidget(
                decimalModel: decimalModel2, context: context),
            SizedBox(width: IZISizeUtil.setSizeWithWidth(percent: .01)),
            Text(
              "= ?",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.w900,
                    color: ColorResources.BLUE_BLACK,
                    fontFamily: 'Filson',
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
