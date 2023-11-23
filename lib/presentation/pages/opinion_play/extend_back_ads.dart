import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

// ignore: avoid_classes_with_only_static_members
class ExtendBackAds {
  static AppOpenAds appOpenAdManager = AppOpenAds();
  static final KeyValidateAds keyValidateAds = GetIt.I.get<KeyValidateAds>();

  static void onBackPress(String router) {
    CommonHelper.onTapHandler(callback: () {
      if (router.isNotEmpty) {
        // toName để giữ router cũ
        Get.offNamed(router);
      }
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().closeSoundGame();
      }
      // kiểm tra quảng cáo đã đóng chưa
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().continueBackgroundSound();
      }
      // Open ads when open add and resumed app.
      // if (!sl<SharedPreferenceHelper>().getPremium) {
      //   final AppOpenAds appOpenAdManager = AppOpenAds();

      //   // Load ads.
      //   appOpenAdManager.showOpenAppAds(
      //     onSuccess: () {},
      //     onError: () {},
      //   );
      // }
    });
  }

  static Future<void> showAdsCompleteGame() async {
    if (!sl<SharedPreferenceHelper>().getPremium) {
      final AppOpenAds appOpenAdManager = await AppOpenAds();

      // Load ads.
      appOpenAdManager.showOpenAppAds(
        onSuccess: () {},
        onError: () {},
      );
    }
  }
}
// CommonHelper.showAdsWhenGoRouter(callBack: () {});