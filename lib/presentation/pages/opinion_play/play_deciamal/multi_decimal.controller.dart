import 'dart:math';

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/services/google_admod_services/open_ads_manager/app_open_ads.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/pages/opinion_play/play_multiplayer/player_model.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

class MutilPlayDecimalController extends GetxController
    with SingleGetTickerProviderMixin {
  RxString currentQuestion = "5 + 8 = ?".obs;
  double correctAnswer = 13.0;
  RxList<String> currentOptions = List<String>.generate(4, (index) => '').obs;
  bool isCorrect = true;
  final RxMap<String, Color> answerColors = <String, Color>{}.obs;
  RxInt count = 1.obs;
  RxInt countWrong = 0.obs;
  RxInt countCorrect = 0.obs;
  RxInt countSkip = 0.obs;
  final Map<String, dynamic> arguments = Get.arguments;
  MATHLEVEL level = Get.arguments['level'];
  String route = Get.arguments['route'];
  String title = Get.arguments['title'];
  int rangeRandom = 10;
  RxString textLevel = ''.obs;
  RxBool isShowResult = false.obs;
  bool isSkip = false;
  // ignore: use_late_for_private_fields_and_variables, prefer_final_fields
  late AnimationController animationController;
  late Animation<double> animation;
  RxDouble progress = 0.0.obs;
  bool isScreenExited = false;
  String resultPlay = '';
  final sound = Get.find<SoundController>();
  Rx<PlayerModel> player1 = PlayerModel(
    id: 1,
    correctAnswer: 0,
    wrongAnswer: 0,
    isEnable: true.obs,
    answerColors: <int, Color>{}.obs,
  ).obs;
  Rx<PlayerModel> player2 = PlayerModel(
    id: 2,
    correctAnswer: 0,
    wrongAnswer: 0,
    isEnable: true.obs,
    answerColors: <int, Color>{}.obs,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    player1.value.isEnable.value = true;
    player2.value.isEnable.value = true;
    checkLevel(level);
    generateQuestion(rangeRandom, route);
    progress.value = 0;
    // ignore: prefer_final_locals
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
    if (isScreenExited) {
      animationController.stop();
    }
    animation.addListener(() {
      progress.value = animation.value;
      if (animation.isCompleted) {
        if (count.value > 10) {
          if (Get.isRegistered<SoundController>()) {
            Get.find<SoundController>().closeSoundGame();
          }
          //Nếu đã bỏ qua câu hỏi thứ 10, chuyển đến trang kết quả
          checkAware(player1.value, player2.value);
          if (Get.isRegistered<SoundController>()) {
            sound.closeSoundGame();
            sound.continueBackgroundSound();
          }
          Get.toNamed(MainRouters.RESULTDECIMAL);
          ExtendBackAds.showAdsCompleteGame();
        } else {
          generateQuestion(rangeRandom, route);
          progress.value = 0;
          animationController.reset();
          animationController.forward();
        }
      }
    });
  }

  Future<void> showADS() async {
    if (!sl<SharedPreferenceHelper>().getPremium) {
      final AppOpenAds appOpenAdManager = AppOpenAds();

      // Load ads.
      appOpenAdManager.showOpenAppAds(
        onSuccess: () {},
        onError: () {},
      );
    }
  }

  void resestProgress() {
    progress.value = 0;
    player1.value.isEnable.value = true;
    player2.value.isEnable.value = true;
    animationController.reset();
    animationController.forward();
  }

  void resetGame() {
    count.value = 0;
    countWrong.value = 0;
    countCorrect.value = 0;
    countSkip.value = 0;
    isShowResult.value = false;
    player1.value.correctAnswer = 0;
    player2.value.correctAnswer = 0;
    player1.value.wrongAnswer = 0;
    player2.value.wrongAnswer = 0;
    player1.value.isEnable.value = true;
    player2.value.isEnable.value = true;
    currentOptions.clear();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
    if (isScreenExited) {
      animationController.stop();
    }
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   textLevel.value = '';
  //   count = 0.obs;
  //   countWrong = 0.obs;
  //   countCorrect = 0.obs;
  //   countSkip = 0.obs;
  //   // ignore: invalid_use_of_protected_member
  //   //animationController.clearListeners();
  // } // được gọi

  void checkAnswerMuti(String selectedAnswer, int index, PlayerModel player) {
    if (selectedAnswer.compareTo(correctAnswer.toStringAsFixed(2)) == 0) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerTrueSound();
      }
      player1.value.isEnable.value = false;
      player2.value.isEnable.value = false;
      player.correctAnswer++;
      player.answerColors.value[index] = ColorResources.GREEN;
      // chuyển  câu hỏi
      Future.delayed(const Duration(milliseconds: 500), () {
        // clear màu
        player.answerColors.value[index] = ColorResources.BD_BT_ANSWER;
        player1.value.isEnable.value = true;
        player2.value.isEnable.value = true;

        resestProgress();
        generateQuestion(rangeRandom, route);
      });
    } else {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerFalseSound();
      }
      // ignore: unnecessary_statements
      player.wrongAnswer++;
      // enable các button
      player.isEnable.value = false;
      if (player1.value.isEnable.value == false &&
          player2.value.isEnable.value == false) {
        final int index =
            currentOptions.indexOf(correctAnswer.toStringAsFixed(2));
        player1.value.answerColors.value[index] = ColorResources.GREEN;
        player2.value.answerColors.value[index] = ColorResources.GREEN;

        Future.delayed(const Duration(milliseconds: 500), () {
          // clear màu
          player.answerColors.value[index] = ColorResources.BD_BT_ANSWER;

          player1.value.isEnable.value = true;
          player2.value.isEnable.value = true;
          player.answerColors.refresh();
          // reset màu cho tất cả các button

          animationController.reset();
          resestProgress();
          generateQuestion(rangeRandom, route);
        });
      }
    }
  }

  void checkLevel(MATHLEVEL level) {
    switch (level) {
      case MATHLEVEL.EASY:
        textLevel = RxString('easy'.tr);
        rangeRandom = MathLevelValueMax.EASY_VALUE;
        break;
      case MATHLEVEL.MEDIUM:
        textLevel = RxString('medium'.tr);
        rangeRandom = MathLevelValueMax.MEDIUM_VALUE;
        break;
      case MATHLEVEL.HARD:
        textLevel = RxString('hard'.tr);
        rangeRandom = MathLevelValueMax.HARD_VALUE;
    }
  }

  @override
  void onClose() {
    count.close();
    countWrong.close();
    countCorrect.close();
    countSkip.close();
    isShowResult.close();
    player1.close();
    player2.close();
    currentOptions.close();
    answerColors.close();
    progress.close();
    textLevel.close();
    currentQuestion.close();
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void generateQuestion(int level, String route) {
    player1.value.answerColors.value = {};
    player2.value.answerColors.value = {};
    if (count.value >= 10) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().closeSoundGame();
      }
      //onClose();
      print('dnsl: ${player1.value.isEnable.value}');
      print('oke1');
      checkAware(player1.value, player2.value);
      if (Get.isRegistered<SoundController>()) {
        sound.closeSoundGame();
        sound.continueBackgroundSound();
      }
      Get.toNamed(MainRouters.RESULTDECIMAL);
      ExtendBackAds.showAdsCompleteGame();
    }
    count.value++;
    // random theo mức độ với phép tính cộng trừ nhân chia
    final Random random = Random();
    String routeOperation = '';
    int levelAdd = 1;
    switch (level) {
      case MathLevelValueMax.EASY_VALUE:
        levelAdd = MathLevelValueMin.EASY_VALUE_ADD;
        break;
      case MathLevelValueMax.MEDIUM_VALUE:
        levelAdd = MathLevelValueMin.MEDIUM_VALUE_ADD;
        break;
      case MathLevelValueMax.HARD_VALUE:
        levelAdd = MathLevelValueMin.HARD_VALUE_ADD;
        break;
    }
    String num1 = ((random.nextDouble() * level) + levelAdd).toStringAsFixed(2);
    String num2 = ((random.nextDouble() * level) + levelAdd).toStringAsFixed(2);
    print('num1 is: $num1');
    print('num1 is: $num2');
    final int randomOperation = random.nextInt(2);
    switch (randomOperation) {
      case 0:
        routeOperation = '+';
        routeOperation = '+';
        correctAnswer = double.parse(num1) + double.parse(num2);
        break;
      case 1:
        routeOperation = '-';
        while (double.parse(num1) < double.parse(num2)) {
          num1 = ((random.nextDouble() * level) + levelAdd).toStringAsFixed(2);
          num2 = ((random.nextDouble() * level) + levelAdd).toStringAsFixed(2);
        }
        correctAnswer = double.parse(num1) - double.parse(num2);
        break;
    }
    currentQuestion.value = '$num1 $routeOperation $num2 = ?';
    currentOptions.clear();
    currentOptions.add(correctAnswer.toStringAsFixed(2));
    print('num1 is: $correctAnswer');

    while (currentOptions.length < 4) {
      final String option =
          ((random.nextDouble() * level) + levelAdd).toStringAsFixed(2);

      if (!currentOptions.contains(option)) {
        currentOptions.add(option);
        // answerColors[option] = ColorResources.GREEN;
      }
    }
    currentOptions.shuffle();
  }

  Color getLevelColor(MATHLEVEL mathLevel) {
    switch (mathLevel) {
      case MATHLEVEL.EASY:
        return Colors.green;
      case MATHLEVEL.MEDIUM:
        return Colors.orange;
      case MATHLEVEL.HARD:
        return Colors.red;
    }
  }

  // result
  void checkAware(PlayerModel play1, PlayerModel play2) {
    print('play1 is: ${play1.correctAnswer}');
    if (play1.correctAnswer > play2.correctAnswer) {
      player1.value.result = 'You Won'.tr;
      player2.value.result = 'You Lose'.tr;
    } else if (play1.correctAnswer < play2.correctAnswer) {
      player2.value.result = 'You Won'.tr;
      player1.value.result = 'You Lose'.tr;
    } else {
      player1.value.result = 'Tie'.tr;
      player2.value.result = 'Tie'.tr;
    }
  }
}
