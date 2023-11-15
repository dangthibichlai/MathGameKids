// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';

import 'izi_image.dart';

class ReviewImagePage extends StatefulWidget {
  String? image;
  ReviewImagePage({this.image});

  @override
  PreviewImageState createState() => PreviewImageState();
}

class PreviewImageState extends State<ReviewImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.OUTER_SPACE,
      body: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: InteractiveViewer(
          maxScale: 9,
          child: IZIImage(
            widget.image.toString(),
            width: IZISizeUtil.getMaxWidth(),
            height: IZISizeUtil.getMaxHeight(),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

/// FIle.
class ReviewImageFilePage extends StatefulWidget {
  File? file;
  ReviewImageFilePage({
    Key? key,
    this.file,
  }) : super(key: key);

  @override
  State<ReviewImageFilePage> createState() => _ReviewImageFilePageState();
}

class _ReviewImageFilePageState extends State<ReviewImageFilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.OUTER_SPACE,
      body: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: InteractiveViewer(
          maxScale: 9,
          child: IZIImage.file(
            widget.file,
            width: IZISizeUtil.getMaxWidth(),
            height: IZISizeUtil.getMaxHeight(),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
