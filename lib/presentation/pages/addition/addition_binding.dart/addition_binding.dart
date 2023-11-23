import 'package:get/get.dart';
import 'package:template/presentation/pages/addition/addition_controller.dart';

class AdditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdditionController>(() => AdditionController());

    // Get.put<ChatHistoryController>(ChatHistoryController());
    // Get.put<ExploreController>(ExploreController());
    // Get.put<SettingsController>(SettingsController());
  }
}
