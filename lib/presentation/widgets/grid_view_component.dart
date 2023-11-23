import 'package:flutter/material.dart';
import 'package:template/core/helper/izi_size_util.dart';

class GriViewComponent extends StatelessWidget {
  const GriViewComponent({
    this.crossAxisCount = 2,
    this.crossAxisSpacing = IZISizeUtil.SPACE_5X,
    this.mainAxisSpacing = IZISizeUtil.SPACE_5X,
    this.childAspectRatio = 1.85,
    required this.itemCount,
    required this.itemBuilder,
    this.padding,
  });

  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: padding ?? IZISizeUtil.setEdgeInsetsAll(IZISizeUtil.setSizeWithWidth(percent: .05)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
