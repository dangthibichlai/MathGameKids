import 'package:get/get.dart';
import 'package:template/presentation/pages/term_of_user/term_of_user_controller.dart';

class TermOfUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermOfUserController>(() => TermOfUserController());
  }
}
