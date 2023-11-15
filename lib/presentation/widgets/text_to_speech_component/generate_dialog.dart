import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/widgets/lottie_widget/lottie_widget.dart';

class GenerateDialog extends StatelessWidget {
  const GenerateDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: IZISizeUtil.setEdgeInsetsSymmetric(
        horizontal: IZISizeUtil.setSizeWithWidth(percent: .1),
      ),
      width: IZISizeUtil.getMaxWidth(),
      child: Column(
        children: [
          LottieWidget(
            jsonPath: ImagesPath.textToSpeechJsonUFO,
            width: IZISizeUtil.setSize(percent: .4),
          ),
          Text(
            'text_speech_06'.tr,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
