import 'package:get/get.dart';
import 'package:template/presentation/pages/opinion_play/play_algebra/play_algebra_controller.dart';

class PlayAlgebraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayAlgebraController>(() => PlayAlgebraController());
  }
}
