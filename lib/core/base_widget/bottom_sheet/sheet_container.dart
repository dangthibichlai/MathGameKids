import 'package:flutter/material.dart';

import 'package:template/core/base_widget/bottom_sheet/sheet_header.dart';

class SheetContainer extends StatelessWidget {
  final Widget child;
  final double size;

  const SheetContainer({
    Key? key,
    required this.child,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: Column(
        children: [
          const SheetHeader(title: ''),
          Expanded(child: child),
        ],
      ),
    );
  }
}
