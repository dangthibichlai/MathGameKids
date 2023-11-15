import 'package:get/get.dart';

import 'spuareroot_controller.dart';

class SpuarerootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpuarerootController>(() => SpuarerootController());
    // Get.put<ChatHistoryController>(ChatHistoryController());
    // Get.put<ExploreController>(ExploreController());
    // Get.put<SettingsController>(SettingsController());
  }
}
