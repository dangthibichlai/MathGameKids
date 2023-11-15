import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/izi_size_util.dart';
import '../../utils/color_resources.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        height: IZISizeUtil.setSize(percent: 0.05),
        width: IZISizeUtil.setSize(percent: 0.05),
        margin: const EdgeInsets.only(
          top: IZISizeUtil.SPACE_1X,
        ),
        decoration: const BoxDecoration(
          color: ColorResources.BACK_GROUND,
          shape: BoxShape.circle,
        ),
        child: const Padding(
          padding: EdgeInsets.only(
            left: 10,
          ),
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorResources.NEUTRALS_5,
          ),
        ),
      ),
    );
  }
}
