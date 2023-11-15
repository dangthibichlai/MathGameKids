import 'package:get/get.dart';

import 'play_time_challenge_controller.dart';

class PlayTimeChallengeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayTimeChallengeController>(
      () => PlayTimeChallengeController(),
    );
  }
}
