// PlaySquareRootBinding
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:template/presentation/pages/home/home_controller.dart';
import 'package:template/presentation/pages/opinion_play/play_square_root/multi_square_controller.dart';
import 'package:template/presentation/pages/opinion_play/play_square_root/play_sqare_root_controller.dart';

class PlaySquareRootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaySquareRootController>(() => PlaySquareRootController());
    Get.lazyPut<MultiSquareRootController>(() => MultiSquareRootController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
