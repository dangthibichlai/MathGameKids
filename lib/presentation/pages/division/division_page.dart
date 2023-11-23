import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/division/division_controller.dart';
import 'package:template/presentation/widgets/gri_cont_addition.dart';
import 'package:template/presentation/widgets/grid_view_component.dart';
import 'package:template/presentation/widgets/header_page.dart';

import '../../../config/routes/route_path/main_routh.dart';

class DivisionPage extends GetView<DivisionController> {
  const DivisionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.toNamed(MainRouters.HOME);
          return true;
        },
        child: Scaffold(
          backgroundColor: ColorResources.BACKGROUND,
          appBar: BaseAppBar(
            title: 'Division',
                  isPremium: true,

            leading: IconButton(
              onPressed: () {
                Get.toNamed(MainRouters.HOME);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  HeaderPage(
                    urlInmage: ImagesPath.divisionImage,
                  ),
                  GriViewComponent(
                    itemCount: Get.find<DashBoardController>().listEight.length,
                    itemBuilder: (p0, p1) => ContainerGridFunction(
                      item: Get.find<DashBoardController>().listEight[p1],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
