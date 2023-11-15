import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:template/core/base_widget/bottom_sheet/sheet_container.dart';
import 'package:template/core/helper/bottomsheet_helper.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';

mixin ImageHelper {
  static Future<File?> pickImage(
    ImageSource source, {
    int? imageQuality,
  }) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: imageQuality,
    );

    return pickedFile == null ? null : File(pickedFile.path);
  }

  static Future<void> _pickImage(
      ImageSource source, void Function(File) callback) async {
    Get.back();

    final File? file = await pickImage(
      source,
      imageQuality: 40,
    );

    if (file != null) {
      callback(file);
    }
  }

  static Future<void> showSheet(void Function(File) callback) async {
    BottomSheetHelper.show(
      widget: SheetContainer(
        size: IZISizeUtil.setSize(percent: 0.25),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.camera_alt,
                color: ColorResources.PRIMARY_1,
              ),
              title: Text(
                'Camera',
                style: TextStyle(
                  fontSize: IZISizeUtil.BODY_LARGE_FONT_SIZE,
                  color: ColorResources.TEXT_BOLD,
                ),
              ),
              onTap: () => _pickImage(ImageSource.camera, callback),
            ),
            ListTile(
              leading: const Icon(
                Icons.image,
                color: ColorResources.PRIMARY_1,
              ),
              title: Text(
                'Thư viện',
                style: TextStyle(
                  fontSize: IZISizeUtil.BODY_LARGE_FONT_SIZE,
                  color: ColorResources.TEXT_BOLD,
                ),
              ),
              onTap: () => _pickImage(ImageSource.gallery, callback),
            ),
          ],
        ),
      ),
    );
  }
}
