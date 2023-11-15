// ChooseLanguageBinding
import 'package:get/get.dart';
import 'package:template/presentation/pages/begin_screen/choose_language/choose_language_controller.dart';

class ChooseLanguageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseLanguageController>(() => ChooseLanguageController());
  }
}