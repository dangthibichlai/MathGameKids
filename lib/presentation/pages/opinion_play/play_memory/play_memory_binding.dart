import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:template/presentation/pages/opinion_play/play_memory/play_memory_controller.dart';

class PlayMemoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayMemoryController>(() => PlayMemoryController(),
        fenix: true);
  }
}
