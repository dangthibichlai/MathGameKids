import 'package:get/get.dart';
import 'package:template/presentation/pages/decimals/decimal_controller.dart';

class DecimalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DecimalController>(() => DecimalController());
    // Get.put<ChatHistoryController>(ChatHistoryController());
    // Get.put<ExploreController>(ExploreController());
    // Get.put<SettingsController>(SettingsController());
  }
}
