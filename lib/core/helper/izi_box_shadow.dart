import 'package:flutter/material.dart';
import 'package:template/core/utils/color_resources.dart';

mixin IZIBoxShadow {
  static List<BoxShadow> notificationShadow = [
    BoxShadow(
      offset: const Offset(4, 4),
      blurRadius: 20,
      color: ColorResources.BLACK.withOpacity(0.1),
    )
  ];
}
