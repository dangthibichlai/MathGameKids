import 'package:get/get.dart';
import 'package:template/presentation/pages/subtraction/subtraction_controller.dart';

class SubtractionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SubtractionController>(SubtractionController());
  }
}
