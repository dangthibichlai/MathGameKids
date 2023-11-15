import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/utils/color_resources.dart';

mixin BottomSheetHelper {
  static void show({required Widget widget}) {
    Get.bottomSheet(
      widget,
      isDismissible: true,
      persistent: true,
      backgroundColor: ColorResources.WHITE,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      enableDrag: true,
      isScrollControlled: true,
    );
  }
}
