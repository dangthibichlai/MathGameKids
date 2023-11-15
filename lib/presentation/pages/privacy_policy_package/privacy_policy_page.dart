import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/pages/privacy_policy_package/privacy_policy_controller.dart';

class PrivacyPolicyPage extends GetView<PrivacyPolicyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backgroundColor: ColorResources.BG_APPBAR,
        title: 'pri_001'.tr,
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IZIImage(
              ImagesPath.img_bottom_pre2,
              width: IZISizeUtil.getMaxWidth(),
            ),
            Padding(
              padding: IZISizeUtil.setEdgeInsetsSymmetric(
                vertical: IZISizeUtil.SPACE_2X,
                horizontal: IZISizeUtil.SPACE_HORIZONTAL_SCREEN,
              ),
              child: Obx(() {
                return Specification(
                    specification: controller.policyData.value);
              }),
            )
          ],
        ),
      ),
    );
  }
}
