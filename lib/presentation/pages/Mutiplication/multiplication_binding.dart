import 'package:get/get.dart';
import 'package:template/presentation/pages/Mutiplication/multiplication_controller.dart';

class MutiplicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MutiplicationController>(() => MutiplicationController());
  }
}
