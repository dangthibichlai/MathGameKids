import 'package:get/get.dart';
import 'package:template/presentation/pages/opinion_play/play_fractice/play_fractice_controller.dart';

class PlayFracticeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayFracticeController>(() => PlayFracticeController());
  }
}