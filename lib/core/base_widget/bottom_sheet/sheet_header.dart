import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/utils/color_resources.dart';

class SheetHeader extends StatelessWidget {
  final String title;

  const SheetHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 35.h,
          alignment: Alignment.center,
          child: Text(
            title,
          ),
        ),
        const Divider(
          height: 0,
          color: ColorResources.NEUTRALS_6,
        ),
      ],
    );
  }
}
