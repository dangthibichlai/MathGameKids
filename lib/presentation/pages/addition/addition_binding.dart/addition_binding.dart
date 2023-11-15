import 'package:get/get.dart';
import 'package:template/presentation/pages/addition/addition_controller.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';

class AdditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdditionController>(() => AdditionController());
    Get.lazyPut<DashBoardController>(
      () => DashBoardController(),
    );
    // Get.put<ChatHistoryController>(ChatHistoryController());
    // Get.put<ExploreController>(ExploreController());
    // Get.put<SettingsController>(SettingsController());
  }
}
