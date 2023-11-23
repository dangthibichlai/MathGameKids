//PlaySquareRootController
import 'dart:math';

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/opinion_play/play_multiplayer/player_model.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

import '../../../../core/shared_pref/constants/enum_helper.dart';

class MultiSquareRootController extends GetxController with GetSingleTickerProviderStateMixin {
  int correctAnswer = 13;
  RxList<int> currentOptions = List<int>.generate(4, (index) => 0).obs;
  bool isCorrect = true;
  final RxMap<int, Color> answerColors = <int, Color>{}.obs;
  RxInt count = 1.obs;
  RxInt countWrong = 0.obs;
  RxInt countCorrect = 0.obs;
  RxInt countSkip = 0.obs;
  final Map<String, dynamic> arguments = Get.arguments;
  MATHLEVEL level = Get.arguments['level'];
  String route = Get.arguments['route'];
  String title = Get.arguments['title'];
  int rangeRandom = 1;
  int levelAdd = 1;
  RxString textLevel = ''.obs;
  bool isSkip = false;
  RxInt currentQuestion = 0.obs;
  RxDouble progress = 0.0.obs;
  late AnimationController animationController;
  late Animation<double> animation;
  bool isScreenExited = false;
  final sound = Get.find<SoundController>();

  Rx<PlayerModel> player1 = PlayerModel(
    id: 1,
    correctAnswer: 0,
    wrongAnswer: 0,
    isEnable: false.obs,
    answerColors: <int, Color>{}.obs,
  ).obs;
  Rx<PlayerModel> player2 = PlayerModel(
    id: 2,
    correctAnswer: 0,
    wrongAnswer: 0,
    isEnable: false.obs,
    answerColors: <int, Color>{}.obs,
  ).obs;
  @override
  void onInit() {
    super.onInit();

    print('TechMind run h');

    // textLevel = RxString(level.name);
    checkLevel(level);
    print(level.name);
    print('route is: ${level.name}');
    generateQuestion(rangeRandom, route);
    progress.value = 0;
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();

    animation.addListener(() {
      if (isScreenExited) {
        animationController.stop();
      }
      progress.value = animation.value;
      if (animation.isCompleted) {
        count.value++;
        if (count.value > 10) {
          if (Get.isRegistered<SoundController>()) {
            sound.closeSoundGame();
            sound.continueBackgroundSound();
          }
          //Nếu đã bỏ qua câu hỏi thứ 10, chuyển đến trang kết quả
          checkAware(player1.value, player2.value);
          Get.offNamed(MainRouters.RESULTMULTISQUARE, arguments: {
            'player1': player1.value,
            'player2': player2.value,
            'oldArguments': arguments,
          });
          // ExtendBackAds.showAdsCompleteGame();

          count = 1.obs;
          return;
        } else {
          generateQuestion(rangeRandom, route);
          progress.value = 0;
          animationController.reset();
          animationController.forward();
        }
      }
    });
  }

  void checkLevel(MATHLEVEL level) {
    if (title.compareTo('select_game_2'.tr) == 0) {
      isSkip = true;
    }
    switch (level) {
      case MATHLEVEL.EASY:
        textLevel = RxString('easy'.tr);
        rangeRandom = MathLevelValueMax.EASY_VALUE_SQ;
        levelAdd = MathLevelValueMin.EASY_VALUE__MUL_ADD;
        break;
      case MATHLEVEL.MEDIUM:
        textLevel = RxString('medium'.tr);
        rangeRandom = MathLevelValueMax.MEDIUM_VALUE_SQ;
        levelAdd = MathLevelValueMin.MEDIUM_VALUE_MUL_ADD;

        break;
      case MATHLEVEL.HARD:
        textLevel = RxString('hard'.tr);
        rangeRandom = MathLevelValueMax.HARD_VALUE_SQ;
        levelAdd = MathLevelValueMin.HARD_VALUE_MUL_ADD;
        break;
    }
  }

  void generateQuestion(int level, String route) {
    // random theo mức độ với phép tính cộng trừ nhân chia
    final Random random = Random();

    correctAnswer = random.nextInt(level) + levelAdd;
    currentQuestion.value = pow(correctAnswer, 2).toInt();

    currentOptions.clear();
    currentOptions.add(correctAnswer);
    print('num1 is: $correctAnswer');

    while (currentOptions.length < 4) {
      final option = random.nextInt(level * 2) + 1;
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

  void resestProgress() {
    progress.value = 0;
    player1.value.isEnable.value = true;
    player2.value.isEnable.value = true;
    animationController.reset();
    animationController.forward();
    // resest màu cho tất cả các button
    player1.value.answerColors.value = {};
    player2.value.answerColors.value = {};
  }

  void checkMultiAnswer(int selectedAnswer, int index, PlayerModel player) {
    if (selectedAnswer == correctAnswer) {
      if (Get.isRegistered<SoundController>()) {
        sound.playAnswerTrueSound();
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
        if (count.value >= 10) {
          if (Get.isRegistered<SoundController>()) {
            sound.closeSoundGame();
          }
          print('oke1');
          checkAware(player1.value, player2.value);
          Get.offNamed(MainRouters.RESULTMULTISQUARE, arguments: {
            'player1': player1.value,
            'player2': player2.value,
            'oldArguments': arguments,
          });
          //   ExtendBackAds.showAdsCompleteGame();
          isScreenExited = true;
          return;
        }
        count.value++;
        generateQuestion(rangeRandom, route);
      });
    } else {
      if (Get.isRegistered<SoundController>()) {
        sound.playAnswerFalseSound();
      }
      // ignore: unnecessary_statements
      player.wrongAnswer++;
      // enable các button
      player.isEnable.value = false;
      if (player1.value.isEnable.value == false && player2.value.isEnable.value == false) {
        final int index = currentOptions.indexOf(correctAnswer);
        player1.value.answerColors.value[index] = ColorResources.GREEN;
        player2.value.answerColors.value[index] = ColorResources.GREEN;
        print('index is: $index');
        print('Player1:');
        print(player1.value.answerColors.value);
        print('Player2:');
        print(player2.value.answerColors.value);

        Future.delayed(const Duration(milliseconds: 500), () {
          // clear màu
          player.answerColors.value[index] = ColorResources.BD_BT_ANSWER;

          player1.value.isEnable.value = true;
          player2.value.isEnable.value = true;
          player.answerColors.refresh();
          // reset màu cho tất cả các button

          animationController.reset();
          resestProgress();
          if (count.value >= 10) {
            if (Get.isRegistered<SoundController>()) {
              sound.closeSoundGame();
              sound.continueBackgroundSound();
            }

            checkAware(player1.value, player2.value);
            if (Get.isRegistered<SoundController>()) {
              sound.closeSoundGame();
              sound.continueBackgroundSound();
            }
            Get.offNamed(MainRouters.RESULTMULTISQUARE, arguments: {
              'player1': player1.value,
              'player2': player2.value,
              'oldArguments': arguments,
            });
            //   ExtendBackAds.showAdsCompleteGame();
            isScreenExited = true;
            return;
          }
          count.value++;
          generateQuestion(rangeRandom, route);
        });
      }
    }
  }

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

  void resetGame() {
    count.value = 1;
    countWrong.value = 0;
    countCorrect.value = 0;
    countSkip.value = 0;
    player1.value.correctAnswer = 0;
    player2.value.correctAnswer = 0;
    player1.value.wrongAnswer = 0;
    player2.value.wrongAnswer = 0;
    player1.value.isEnable.value = true;
    player2.value.isEnable.value = true;
    currentOptions.clear();
    isScreenExited = false;
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
    if (isScreenExited) {
      animationController.stop();
    }
    generateQuestion(rangeRandom, route);
  }
}
