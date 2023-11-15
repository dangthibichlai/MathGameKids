import 'package:get/get.dart';
import 'package:template/presentation/pages/premium_package/prenium_controller.dart';

class PreniumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreniumController>(() => PreniumController());
  }
}
