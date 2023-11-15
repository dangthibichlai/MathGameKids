import 'package:get/get.dart';
import 'package:template/presentation/pages/home/home_controller.dart';
import 'package:template/presentation/pages/opinion_play/play_practice/play_practice_controller.dart';

class PlayPracticeBinding extends Bindings {
  @override
  void dependencies() {
    print('TechMind add hello PlayPracticeBinding');
    Get.lazyPut<PlayPracticeController>(() => PlayPracticeController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
