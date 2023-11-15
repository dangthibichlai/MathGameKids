import 'package:get/get.dart';
import 'package:template/presentation/pages/home/home_controller.dart';
import 'package:template/presentation/pages/opinion_play/play_quiz/play_quiz_controller.dart';

class PlayQiuzBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<playQuizController>(() => playQuizController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
