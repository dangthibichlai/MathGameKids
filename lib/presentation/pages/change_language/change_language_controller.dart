import 'package:get/get.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';

class ChangeLanguageController extends GetxController {
  ///
  /// Declare data.
  List<Map<String, dynamic>> multipleLanguages = [
    {
      'value': 'en',
      'name': 'English'.tr,
      'image': ImagesPath.enFlag,
      'isSelected': false,
    },
    {
      'value': 'es',
      'name': 'Espanol'.tr,
      'image': ImagesPath.esFlag,
      'isSelected': false,
    },
    {
      'value': 'pt',
      'name': 'Portuguese'.tr,
      'image': ImagesPath.porFlag,
      'isSelected': false,
    },
    {
      'value': 'hi',
      'name': 'Hindi'.tr,
      'image': ImagesPath.hinFlag,
      'isSelected': false,
    },
    {
      'value': 'fr',
      'name': 'Francais'.tr,
      'image': ImagesPath.frFlag,
      'isSelected': false,
    },
    {
      'value': 'ru',
      'name': 'Russian'.tr,
      'image': ImagesPath.ruFlag,
      'isSelected': false,
    },
    {
      'value': 'vi',
      'name': 'Vietnamese'.tr,
      'image': ImagesPath.vnFlag,
      'isSelected': false,
    },
  ];

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    // Check is selected language.
    _checkIsSelectedLanguage();
  }

  ///
  /// Check is selected language.
  ///
  void _checkIsSelectedLanguage() {
    for (final e in multipleLanguages) {
      if (e['value'] == sl<SharedPreferenceHelper>().getLocale) {
        e['isSelected'] = true;
      }
    }
    if (isLoading) {
      isLoading = false;
      update();
    }
  }

  ///
  /// On select language.
  ///
  void onSelectLanguage(int index) {
    for (int i = 0; i < multipleLanguages.length; i++) {
      if (i == index) {
        multipleLanguages[i]['isSelected'] = true;
      } else {
        multipleLanguages[i]['isSelected'] = false;
      }
    }

    update();

    // Change language.
    LocalizationService.changeLocale(
        multipleLanguages[index]['value'].toString());
    Get.find<DashBoardController>().init();
    // gọi hàm init ở DashBoardController
  }
}
