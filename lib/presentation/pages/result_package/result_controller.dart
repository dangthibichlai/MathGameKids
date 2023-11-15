import 'package:get/get.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

class ResultController extends GetxController {
  Rx<int> countWrong = 0.obs;
  Rx<int> countCorrect = 0.obs;
  Rx<int> countSkip = 0.obs;
  String router = '';

  @override
  void onInit() {
    countWrong.value = Get.arguments['countWrong'].value;
    countCorrect.value = Get.arguments['countCorrect'].value;
    countSkip.value = Get.arguments['countSkip'].value;
    router = Get.arguments['route'] as String;

    if (Get.isRegistered<SoundController>()) {
      Get.find<SoundController>().continueBackgroundSound();
    }
    ExtendBackAds.showAdsCompleteGame();
    super.onInit();
  }

  // Future<void> showADS() async {
  //   if (!sl<SharedPreferenceHelper>().getPremium) {
  //     final AppOpenAds appOpenAdManager = AppOpenAds();

  //     // Load ads.
  //     appOpenAdManager.showOpenAppAds(
  //       onSuccess: () {},
  //       onError: () {},
  //     );
  //   }
  // }

  @override
  void onClose() {
    countWrong.close();
    countCorrect.close();
    countSkip.close();
    Get.find<SoundController>().playBackgroundSound();
    super.onClose();
  }
}
