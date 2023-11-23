import 'package:get/get.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/setting_package/setting_controller.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashBoardController>(
      DashBoardController(),
    );
    Get.put<SoundController>(SoundController());
    Get.put<HomeController>(
      HomeController(),
    );
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
