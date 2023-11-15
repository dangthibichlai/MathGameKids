import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';

class ButtonStart extends StatelessWidget {
  final String? text;
  final Function? onPressed;
  const ButtonStart({super.key, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed!();
        // Navigator.pushNamed(context, AuthRouter.PRENIUM);
      },
      child: Container(
        alignment: Alignment.center,
        width: IZISizeUtil.setSizeWithWidth(percent: .84),
        height: IZISizeUtil.setSize(percent: .06),
        decoration: ShapeDecoration(
          color: ColorResources.START_BT,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text ?? 'text_button_prenium'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: IZISizeUtil.LABEL_SMALL_FONT_SIZE,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            letterSpacing: -0.48,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
