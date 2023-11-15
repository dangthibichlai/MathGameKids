import 'package:get/get.dart';
import 'package:template/presentation/pages/begin_screen/splash/splash_controller.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
    Get.put<SoundController>(SoundController());
    Get.put<DashBoardController>(
      DashBoardController(),
    );
  }
}
