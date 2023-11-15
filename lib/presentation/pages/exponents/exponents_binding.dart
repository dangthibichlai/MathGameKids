import 'package:get/get.dart';

import 'exponents_controller.dart';

class ExponentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExponentsController>(() => ExponentsController());
    // Get.put<ChatHistoryController>(ChatHistoryController());
    // Get.put<ExploreController>(ExploreController());
    // Get.put<SettingsController>(SettingsController());
  }
}
