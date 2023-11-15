import 'package:flutter/material.dart';
import 'package:template/presentation/pages/opinion_play/play_mising_number/ui_models/missing_position_model.dart';

class NumberText extends StatelessWidget {
  final int position;
  final MissingPositionModel missingPosition;
  final int number;
  final Color colorMissing;

  const NumberText({
    super.key,
    required this.position,
    required this.missingPosition,
    required this.number,
    required this.colorMissing,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (position == missingPosition.numberOrder)
          Positioned(
            left: missingPosition.position * 17,
            child: Container(
              decoration: BoxDecoration(
                color: colorMissing,
                borderRadius: BorderRadius.circular(2),
              ),
              constraints: const BoxConstraints(maxHeight: 30),

              // ColorResources.MATHPRIMARY,
              width: 18,
              height: 30,
            ),
          )
      ],
    );
  }
}
