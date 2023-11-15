import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/format_html.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/presentation/pages/term_of_user/term_of_user_controller.dart';

class TermOfUserPage extends GetView<TermOfUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backgroundColor: ColorResources.BG_APPBAR,
        title: 'term_001'.tr,
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IZIImage(
              ImagesPath.img_bottom_pre,
              width: IZISizeUtil.getMaxWidth(),
            ),
            Padding(
              padding: IZISizeUtil.setEdgeInsetsSymmetric(
                vertical: IZISizeUtil.SPACE_2X,
                horizontal: IZISizeUtil.SPACE_HORIZONTAL_SCREEN,
              ),
              child: Obx(() {
                return Specification(specification: controller.termValue.value);
              }),
            )
          ],
        ),
      ),
    );
  }
}
