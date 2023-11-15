import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/model/list_game_model.dart';
import 'package:template/presentation/pages/addition/addition_controller.dart';
import 'package:template/presentation/widgets/gri_cont_addition.dart';
import 'package:template/presentation/widgets/grid_view_component.dart';
import 'package:template/presentation/widgets/header_page.dart';

class AdditonPage extends GetView<AdditionController> {
  const AdditonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(MainRouters.HOME);
        return true;
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Scaffold(
              backgroundColor: ColorResources.BACKGROUND,
              appBar: BaseAppBar(
                title: 'addition_Page_1'.tr,
                leading: IconButton(
                  onPressed: () {
                    Get.toNamed(MainRouters.HOME);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),

                //leading: Icon ,
              ),
              body: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      HeaderPage(urlInmage: ImagesPath.aditionImage),
                      GriViewComponent(
                          itemCount: listEight.length,
                          itemBuilder: (p0, p1) => ContainerGridFunction(
                                item: listEight[p1],
                              )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HexagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorResources.BACKGROUND
      ..style = PaintingStyle.fill;

    final path = Path();
    final double width = size.width;
    final double height = size.height;

    path.moveTo(width * 0.5, 0.0); // đỉnh
    path.lineTo(width, height * 0.25); // cạnh
    path.lineTo(width, height * 0.75); // cạnh 2
    path.lineTo(width * 0.5, height); // đỉnh 2
    path.lineTo(0.0, height * 0.75); // cạnh 3
    path.lineTo(0.0, height * 0.25); // cạnh 4
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
