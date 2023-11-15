import 'package:get/get.dart';
import 'package:template/presentation/pages/setting_package/setting_controller.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(),
    );
    // DashBoardController

    Get.lazyPut<SettingController>(() => SettingController());
  }
}
