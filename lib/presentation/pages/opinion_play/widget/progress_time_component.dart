import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';

class ProgressTime extends StatelessWidget {
  const ProgressTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.BACKGROUND,
      height: IZISizeUtil.setSizeWithWidth(percent: .12),
      width: IZISizeUtil.setSizeWithWidth(percent: .76),
      // padding: IZISizeUtil.setEdgeInsetsOnly(
      //     right: IZISizeUtil.setSizeWithWidth(percent: .04)),
      child: Row(
        children: [
          Lottie.asset('assets/images/clock_time.json',
              //  controller: controller!,
              width: IZISizeUtil.setSizeWithWidth(percent: .12),
              height: IZISizeUtil.setSizeWithWidth(percent: .15)),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                // width: IZISizeUtil.setSizeWithWidth(percent: .55),
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(seconds: 30), // 30s
                  curve: Curves.easeInOut,
                  tween: Tween<double>(
                    begin: 0,
                    end: 1,
                  ),
                  builder: (context, value, _) => LinearProgressIndicator(
                    value: value,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        ColorResources.ORANGE_MG),
                    backgroundColor: ColorResources.LIGHT_GREY,
                    minHeight: 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
