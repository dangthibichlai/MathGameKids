// ignore_for_file: parameter_assignments

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/opinion_play/play_multiplayer/player_model.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

class MultiPlayerController extends GetxController with GetSingleTickerProviderStateMixin {
  RxString currentQuestion = "5 + 8 = ?".obs;
  int correctAnswer = 13;
  RxList<int> currentOptions = List<int>.generate(4, (index) => 0).obs;
  Rx<bool> isCorrect = true.obs;
  // RxMap<int, Color> answerColors = <int, Color>{}.obs;
  RxInt count = 0.obs;
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
    print(title);
    print('level is: $level');
    print('route is: $route');
    player1.value.isEnable.value = true;
    player2.value.isEnable.value = true;
    checkLevel(level);
    generateQuestion(rangeRandom, route);
    progress.value = 0;
    // ignore: prefer_final_locals
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();

    animation.addListener(() {
      if (isScreenExited) {
        animationController.stop();
      }
      progress.value = animation.value;
      if (animation.isCompleted) {
        if (count.value > 10) {
          //Nếu đã bỏ qua câu hỏi thứ 10, chuyển đến trang kết quả
          checkAware(player1.value, player2.value);
          if (Get.isRegistered<SoundController>()) {
            sound.closeSoundGame();
            sound.continueBackgroundSound();
          }
          player1.value.isEnable.value = true;
          player2.value.isEnable.value = true;
          Get.offNamed(MainRouters.MULTIPLAYER_RESULT, arguments: {
            'player1': player1.value,
            'player2': player2.value,
            'oldArguments': arguments,
          });
          return;
          //ExtendBackAds.showAdsCompleteGame();
        } else {
          player1.value.isEnable.value = true;
          player2.value.isEnable.value = true;
          generateQuestion(rangeRandom, route);
          progress.value = 0;
          animationController.reset();
          animationController.forward();
        }
      }
    });
  }

  @override
  void onClose() {
    // close các controller
    count.close();
    countWrong.close();
    countCorrect.close();
    countSkip.close();
    currentOptions.close();
    progress.close();
    player1.close();
    player2.close();
    textLevel.close();
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void resestProgress() {
    progress.value = 0;
    player1.value.isEnable.value = true;
    player2.value.isEnable.value = true;
    animationController.reset();
    animationController.forward();
    isCorrect.value = true;
  }

  void checkAnswer(int selectedAnswer, int index, PlayerModel player) {
    if (selectedAnswer == correctAnswer) {
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
      isCorrect.value == false;
      player.wrongAnswer++;
      print('isCorrect is: ${isCorrect.value}');
      // enable các button
      player.isEnable.value = false;
      if (player1.value.isEnable.value == false && player2.value.isEnable.value == false) {
        final int index = currentOptions.indexOf(correctAnswer);
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

  void generateQuestion(int level, String route) {
    player1.value.answerColors.value = {};
    player2.value.answerColors.value = {};
    if (count.value >= 10) {
      //onClose();
      print('dnsl: ${player1.value.isEnable.value}');
      print('oke1');
      checkAware(player1.value, player2.value);
      if (Get.isRegistered<SoundController>()) {
        sound.closeSoundGame();
        sound.continueBackgroundSound();
      }
      //  ExtendBackAds.showAdsCompleteGame();

      Get.offNamed(MainRouters.MULTIPLAYER_RESULT, arguments: {
        'player1': player1.value,
        'player2': player2.value,
        'oldArguments': arguments,
      });
      isScreenExited = true;
      return;
    }
    count.value++;
    print(count);
    // resetProgress();
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
    int num1 = random.nextInt(level) + levelAdd;
    int num2 = random.nextInt(level) + levelAdd;
    print('num1 is: $num1');
    print('num1 is: $num2');
    print('route is: $route');
    switch (route) {
      case MainRouters.ADDITION:
        routeOperation = '+';
        correctAnswer = num1 + num2;
        break;
      case MainRouters.SUBTRACTION:
        routeOperation = '-';
        while (num1 < num2) {
          num1 = random.nextInt(level) + levelAdd;
          num2 = random.nextInt(level) + levelAdd;
        }
        correctAnswer = num1 - num2;
        break;
      case MainRouters.MULTIPLICATION:
        routeOperation = 'x';
        if (level == MathLevelValueMax.HARD_VALUE) {
          level = MathLevelValueMax.HARD_VALUE_MUL;
          levelAdd = MathLevelValueMin.HARD_VALUE_MUL_ADD;
        } else if (level == MathLevelValueMax.MEDIUM_VALUE) {
          level = MathLevelValueMax.MEDIUM_VALUE_MUL;
          levelAdd = MathLevelValueMin.MEDIUM_VALUE_MUL_ADD;
        }
        num1 = random.nextInt(level) + levelAdd;
        num2 = random.nextInt(level) + levelAdd;
        correctAnswer = num1 * num2;
        break;
      case MainRouters.DIVISION:
        routeOperation = '/';
        while (num1 % num2 != 0 || num1 == num2) {
          num1 = random.nextInt(level) + levelAdd;
          num2 = random.nextInt(level) + levelAdd;
        }
        correctAnswer = num1 ~/ num2;
        break;
    }
    currentQuestion.value = '$num1 $routeOperation $num2 = ?';
    currentOptions.clear();
    currentOptions.add(correctAnswer);
    print('num1 is: $correctAnswer');

    while (currentOptions.length < 4) {
      int option = random.nextInt(level * 2) + levelAdd;
      if (correctAnswer.toString().length > 2) {
        option = random.nextInt(levelAdd) + correctAnswer; // giảm miền giá trị của đáp án với hard
      }
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
