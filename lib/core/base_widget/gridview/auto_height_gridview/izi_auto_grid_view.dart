// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/material.dart';
import 'package:template/core/base_widget/gridview/auto_height_gridview/dynamic_height_grid_view.dart';
import 'package:template/core/helper/izi_size_util.dart';

class IZIAutoGridView extends StatelessWidget {
  const IZIAutoGridView({
    Key? key,
    required this.itemCount,
    this.crossAxisCount,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.rowCrossAxisAlignment,
    this.physics,
    required this.builder,
    this.controller,
  }) : super(key: key);

  final int itemCount;
  final int? crossAxisCount;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final CrossAxisAlignment? rowCrossAxisAlignment;
  final ScrollPhysics? physics;
  final Widget Function(int index) builder;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return DynamicHeightGridView(
      itemCount: itemCount,
      crossAxisCount: crossAxisCount ?? 3,
      crossAxisSpacing: crossAxisSpacing ?? IZISizeUtil.setSize(percent: .1),
      mainAxisSpacing: mainAxisSpacing ?? IZISizeUtil.setSize(percent: .1),
      shrinkWrap: true,
      controller: controller,
      physics: physics ?? const NeverScrollableScrollPhysics(),
      rowCrossAxisAlignment: rowCrossAxisAlignment ?? CrossAxisAlignment.start,
      builder: (context, index) {
        return builder(index);
      },
    );
  }
}
