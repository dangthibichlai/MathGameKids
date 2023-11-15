// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_button.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';

class BaseDialog {
  static Future<void> showBaseDialog({
    required BuildContext context,
    required Function callbackAgree, required Null Function() callBackWatchAds, required Null Function() callBackGetPro, required Null Function() callBackOffDialog,
  }) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        final curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: Dialog.fullscreen(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: IZISizeUtil.setEdgeInsetsSymmetric(
                      horizontal: IZISizeUtil.setSizeWithWidth(percent: .1),
                    ),
                    padding: IZISizeUtil.setEdgeInsetsAll(IZISizeUtil.SPACE_3X),
                    width: IZISizeUtil.getMaxWidth(),
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.RADIUS_2X),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: IZISizeUtil.setEdgeInsetsAll(IZISizeUtil.SPACE_2X),
                          decoration: BoxDecoration(
                            color: ColorResources.RED.withOpacity(.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: IZIImage(
                              ImagesPath.deleteIcon,
                              colorIconsSvg: ColorResources.RED,
                              width: IZISizeUtil.setSize(percent: .03),
                            ),
                          ),
                        ),
                        Padding(
                          padding: IZISizeUtil.setEdgeInsetsSymmetric(vertical: IZISizeUtil.SPACE_3X),
                          child: Text(
                            'Are you sure to delete this saved chat?',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IZIButton(
                              width: IZISizeUtil.setSizeWithWidth(percent: .3),
                              margin: EdgeInsets.zero,
                              label: 'No',
                              fontSizedLabel: 13.sp,
                              type: IZIButtonType.OUTLINE,
                              onTap: () {
                                Get.back();
                              },
                            ),
                            IZIButton(
                              width: IZISizeUtil.setSizeWithWidth(percent: .3),
                              margin: EdgeInsets.zero,
                              isGradient: true,
                              label: 'Yes',
                              fontSizedLabel: 13.sp,
                              onTap: () {
                                callbackAgree();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
