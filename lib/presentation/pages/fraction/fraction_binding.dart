import 'package:get/get.dart';
import 'package:template/presentation/pages/fraction/fraction_controller.dart';

class FractionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FractionController>(() => FractionController());
    // Get.put<ChatHistoryController>(ChatHistoryController());
    // Get.put<ExploreController>(ExploreController());
    // Get.put<SettingsController>(SettingsController());
  }
}
