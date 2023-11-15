import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:template/presentation/pages/opinion_play/play_exponents/multiplay_exponets_controller.dart';
import 'package:template/presentation/pages/opinion_play/play_exponents/play_exponents_controller.dart';


class PlayExponentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayExponentsController>(
      () => PlayExponentsController(),
    );
    Get.lazyPut<MultiExponentsController>(
      () => MultiExponentsController(),
    );
  }
}
