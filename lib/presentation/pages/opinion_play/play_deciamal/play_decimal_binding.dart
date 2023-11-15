import 'package:get/get.dart';
import 'package:template/presentation/pages/opinion_play/play_deciamal/multi_decimal.controller.dart';
import 'package:template/presentation/pages/opinion_play/play_deciamal/play_decimal_controller.dart';


class PlayDecimalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayDecimalController>(() => PlayDecimalController());
    Get.lazyPut<MutilPlayDecimalController>(() => MutilPlayDecimalController());
  }
}
