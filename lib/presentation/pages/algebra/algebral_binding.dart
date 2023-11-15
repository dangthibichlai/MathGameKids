import 'package:get/get.dart';
import 'package:template/presentation/pages/algebra/algebra_controller.dart';

class AlgebraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlgebraController>(() => AlgebraController());

    // Get.put<ChatHistoryController>(ChatHistoryController());
    // Get.put<ExploreController>(ExploreController());
    // Get.put<SettingsController>(SettingsController());
  }
}
