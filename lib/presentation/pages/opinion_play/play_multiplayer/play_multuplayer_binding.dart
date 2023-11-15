// MultiplayerBingding
import 'package:get/get.dart';
import 'package:template/presentation/pages/opinion_play/play_multiplayer/play_multiplayer_controller.dart';

class MultiplayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultiPlayerController>(() => MultiPlayerController());
  }
}