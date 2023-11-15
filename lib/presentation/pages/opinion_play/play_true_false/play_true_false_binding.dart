// PlayTrueFalseBinding
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:template/presentation/pages/opinion_play/play_true_false/play_true_false_controller.dart';

class PlayTrueFalseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayTrueFalseController>(() => PlayTrueFalseController());
  }
}
