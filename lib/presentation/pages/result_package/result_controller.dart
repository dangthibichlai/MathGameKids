import 'package:get/get.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

class ResultController extends GetxController {
  int countWrong = 0;
  int countCorrect = 0;
  int countSkip = 0;

  @override
  void onInit() {
    countWrong = Get.arguments['countWrong'];
    countCorrect = Get.arguments['countCorrect'];
    countSkip = Get.arguments['countSkip'];

    if (Get.isRegistered<SoundController>()) {
      Get.find<SoundController>().continueBackgroundSound();
    }
    // delay 2s to show ads.
    Future.delayed(const Duration(microseconds: 2000), () {
      ExtendBackAds.showAdsCompleteGame();
    });
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
    Get.find<SoundController>().playBackgroundSound();
    super.onClose();
  }
}
