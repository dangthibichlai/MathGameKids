import 'package:get/get.dart';
import 'package:template/presentation/pages/opinion_play/play_long_addition/play_long_addition_controller.dart';

class PlayLongAdditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayLongAdditionController>(
      () => PlayLongAdditionController(),
    );
  }
}
