import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:template/presentation/pages/opinion_play/play_deciamal/result_decimal_controller.dart';

class ResultDecimalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultDecimalController>(
      () => ResultDecimalController(),
    );
  }
}
