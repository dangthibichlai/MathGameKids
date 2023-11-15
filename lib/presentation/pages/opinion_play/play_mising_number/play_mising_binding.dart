import 'package:get/get.dart';
import 'package:template/presentation/pages/opinion_play/play_mising_number/play_mising_controller.dart';

class PlayMissingNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayMissingNumberController>(
      () => PlayMissingNumberController(),
    );
  }
}
