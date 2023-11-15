import 'package:flutter/material.dart';

import '../../../../core/helper/izi_size_util.dart';
import '../../../../core/utils/color_resources.dart';

class TextExponet extends StatelessWidget {
  const TextExponet({super.key, required this.exponent, required this.base});
  final int exponent;
  final int base;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        '$base',
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w900,
            color: ColorResources.BLUE_BLACK,
            fontFamily: 'Filson'),
      ),
      Stack(
        children: [
          Container(
            height: IZISizeUtil.setSize(percent: .08),
            decoration: const BoxDecoration(),
          ),
          Text(
            '$exponent',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w900,
                color: ColorResources.BLUE_BLACK,
                fontFamily: 'Filson'),
          ),
        ],
      )
    ]);
  }
}
