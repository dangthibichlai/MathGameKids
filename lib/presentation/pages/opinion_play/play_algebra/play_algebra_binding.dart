import 'package:get/get.dart';
import 'package:template/presentation/pages/home/home_controller.dart';
import 'package:template/presentation/pages/opinion_play/play_algebra/play_algebra_controller.dart';

class PlayAlgebraBinding extends Bindings {
  @override
  void dependencies() {
    print('TechMind add hello PlayAlgebraController');
    Get.lazyPut<PlayAlgebraController>(() => PlayAlgebraController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
