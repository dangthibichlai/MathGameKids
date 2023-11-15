// ChooseLanguageController
// ignore_for_file: use_setters_to_change_properties

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:template/config/routes/route_path/auth_routh.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/services/multi_language_service/localization_service.dart';
import 'package:template/core/utils/id_get_builder.dart';
import 'package:template/core/utils/images_path.dart';

import '../../../../core/services/google_admod_services/google_admod_services.dart';
import '../../../../core/shared_pref/shared_preference_helper.dart';

class ChooseLanguageController extends GetxController {
  List<Map<String, dynamic>> multipleLanguages = [
    {
      'value': 'vi',
      'name': 'Tiếng Việt'.tr,
      'image': ImagesPath.vnFlag,
      'valueNumber': 7,
    },
    {
      'value': 'en',
      'name': 'English'.tr,
      'image': ImagesPath.enFlag,
      'valueNumber': 1,
    },
    {
      'value': 'es',
      'name': 'Espanol'.tr,
      'image': ImagesPath.esFlag,
      'valueNumber': 2,
    },
    {
      'value': 'pt',
      'name': 'Portuguese'.tr,
      'image': ImagesPath.porFlag,
      'valueNumber': 3,
    },
    {
      'value': 'hi',
      'name': 'Hindi'.tr,
      'image': ImagesPath.hinFlag,
      'valueNumber': 4,
    },
    {
      'value': 'fr',
      'name': 'Francais'.tr,
      'image': ImagesPath.frFlag,
      'valueNumber': 5,
    },
    {
      'value': 'ru',
      'name': 'Russian'.tr,
      'image': ImagesPath.ruFlag,
      'valueNumber': 6,
    },
  ];

  RxInt languageGroupValue = 0.obs;

  // Ads.
  BannerAd? bannerAds;
  GoogleAdmodServices googleAdmodServices = GoogleAdmodServices();
  RxBool isAllowSkip = false.obs;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    //
    //  Init ads.
    _initAds();

    //  Get language default.
    _getLanguageDefault();
    currentIndex.value = languageGroupValue.value;
  }

  @override
  void onClose() {
    isAllowSkip.close();
    super.onClose();
  }

  ///
  /// Init ads.
  ///
  Future<void> _initAds() async {
    googleAdmodServices
        .bannerAdmodFunc(
            adSize: AdSize(width: Get.size.width.toInt(), height: 300),
            callBack: () {
              isAllowSkip.value = true;
            })
        .then((value) async {
      await value.load();
      bannerAds = value;

      update([IdGetBuilder.adsBannerSelectLanguage]);
    });
  }

  ///
  /// Get language default.
  ///
  void _getLanguageDefault() {
    languageGroupValue.value = multipleLanguages[multipleLanguages.indexWhere(
        (element) =>
            element['value'].toString() ==
            sl<SharedPreferenceHelper>().getLocale)]['valueNumber'] as int;
    languageGroupValue.refresh();
  }

  ///
  /// On change Language.
  ///
  void onLanguageChange(int val) {
    languageGroupValue.value = val;
    currentIndex.value = val;
    print('val: $val');
  }

  ///
  /// On select language.
  ///
  void onSelectLanguageChange() {
    final _valueLanguage = multipleLanguages[multipleLanguages.indexWhere(
            (element) =>
                (element['valueNumber'] as int) ==
                languageGroupValue.value)]['value']
        .toString();

    // Change language.
    LocalizationService.changeLocale(_valueLanguage);

    Get.offAllNamed(AuthRouter.NEXTPAGE1);
  }

  void showSkipLanguage() {
    isAllowSkip.value = true;
  }
}
