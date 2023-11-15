
import 'package:flutter/material.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/opinion_play/play_deciamal/decimal_model.dart';

import '../../../../core/helper/izi_size_util.dart';

class TextNumberDecimalWidget extends StatelessWidget {
  final DecimalModel decimalModel;
  final BuildContext context;
  final Color? textColor;

  const TextNumberDecimalWidget({
    required this.decimalModel,
    required this.context,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: IZISizeUtil.setSizeWithWidth(percent: .01),
      ),
      child: Row(
        children: [
          Text(
            decimalModel.naturalNumber.toString(),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.w900,
              color: textColor ?? ColorResources.BLUE_BLACK,
              fontFamily: 'Filson',
            ),
          ),
          Text(
            ".",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.w900,
              color: textColor ?? ColorResources.BLUE_BLACK,
              fontFamily: 'Filson',
            ),
          ),
          Text(
            decimalModel.decimalNumber.toString(),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.w900,
              color: textColor ?? ColorResources.BLUE_BLACK,
              fontFamily: 'Filson',
            ),
          ),
        ],
      ),
    );
  }
}