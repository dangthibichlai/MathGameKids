import 'package:get/get.dart';
import 'package:template/presentation/pages/play_package/play_controller.dart';

class PlayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayController>(() => PlayController());
  }
}
