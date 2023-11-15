import 'package:get/get.dart';
import 'package:template/presentation/pages/division/division_controller.dart';

class DivisionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DivisionController>(() => DivisionController());

    // Get.put<ChatHistoryController>(ChatHistoryController());
    // Get.put<ExploreController>(ExploreController());
    // Get.put<SettingsController>(SettingsController());
  }
}
