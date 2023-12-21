// ignore_for_file: parameter_assignments

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

import '../../../../core/export/core_export.dart';

class PlayPracticeController extends GetxController
    with WidgetsBindingObserver {
  // ignore_for_file: unnecessary_statements, avoid_bool_literals_in_conditional_expressions

  // 1-9 : easy
  // 10-99 : medium
  // 100-999 : hard
  RxString currentQuestion = "5 + 8 = ?".obs;
  int correctAnswer = 13;
  RxList<int> currentOptions = List<int>.generate(4, (index) => 0).obs;
  RxMap<int, Color> answerColors = <int, Color>{}.obs;
  RxInt count = 1.obs;
  bool isCorrect = true;

  RxInt countWrong = 0.obs;
  RxInt countCorrect = 0.obs;
  RxInt countSkip = 0.obs;
  RxInt num1 = 0.obs;
  RxInt num2 = 0.obs;

  Map<String, dynamic> arguments = {
    'level': "Easy",
    'route': "/addition",
    'title': "Addition",
  };
  // MATHLEVEL level = Get.arguments['level'];
  MATHLEVEL level = MATHLEVEL.EASY;
  String route = "/addition";
  String title = "Addition";
  int rangeRandom = 10;
  RxString textLevel = ''.obs;
  RxBool isShowResult = false.obs;
  int levelAdd = 1;
  Rx<bool> isEnable = true.obs;

  @override
  void onInit() {
    // WidgetsBinding.instance.addObserver(this);
    super.onInit();

    print('TechMind run h');
    answerColors = <int, Color>{}.obs;
    isCorrect = true;

    // textLevel = RxString(level.name);
    checkLevel(level);
    print(level.name);
    print('route is: ${level.name}');
    generateQuestion(rangeRandom, route);
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
    count.close();
    countWrong.close();
    countCorrect.close();
    countSkip.close();
    isShowResult.close();
    currentOptions.close();
    answerColors.close();
    textLevel.close();
    currentQuestion.close();
  }
  // enable skip

  void checkAnswer(int selectedAnswer) {
    if (!isEnable.value) {
      print('double');
      return;
    }
    isEnable.value = false;
    if (selectedAnswer == correctAnswer) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerTrueSound();
      }
      isCorrect = true;

      answerColors[selectedAnswer] = ColorResources.GREEN;
      countCorrect++;
      count++;

      print('count is: $count');
      if (count > 10) {
        if (Get.isRegistered<SoundController>()) {
          Get.find<SoundController>().closeSoundGame();
        }
        Get.offAndToNamed(MainRouters.RESULT, arguments: {
          'countWrong': countWrong.value,
          'countCorrect': countCorrect.value,
          'countSkip': countSkip.value,
        });
      }
      Future.delayed(const Duration(milliseconds: 800), () {
        // khởi tạo lại màu cho button
        answerColors.clear();
        generateQuestion(rangeRandom, route);
        isEnable.value = true;
      });
    } else {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerFalseSound();
      }
      isCorrect = false;

      answerColors[selectedAnswer] = ColorResources.RED;
      answerColors.refresh();
      countWrong++;
      isEnable.value = true;
    }
  }

  void checkLevel(MATHLEVEL level) {
    switch (level) {
      case MATHLEVEL.EASY:
        textLevel = RxString('hard'.tr);
        rangeRandom = MathLevelValueMax.EASY_VALUE;
        levelAdd = MathLevelValueMin.EASY_VALUE_ADD;

        break;
      case MATHLEVEL.MEDIUM:
        textLevel = RxString('medium'.tr);
        rangeRandom = MathLevelValueMax.MEDIUM_VALUE;
        levelAdd = MathLevelValueMin.MEDIUM_VALUE_ADD;

        break;
      case MATHLEVEL.HARD:
        textLevel = RxString('hard'.tr);
        rangeRandom = MathLevelValueMax.HARD_VALUE;
        levelAdd = MathLevelValueMin.HARD_VALUE_ADD;
        break;
    }
  }

  void generateQuestion(int level, String route) {
    print('cau:  $count');
    // random theo mức độ với phép tính cộng trừ nhân chia
    final Random random = Random();
    String routeOperation = '';

    int num1 = random.nextInt(level) + levelAdd;
    int num2 = random.nextInt(level) + levelAdd;
    print('num1 is: $num1');
    print('num2 is: $num2');
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
    print('correct is: $correctAnswer');

    while (currentOptions.length < 4) {
      int option = random.nextInt(level * 2) + levelAdd;
      if (correctAnswer.toString().length > 2) {
        option = random.nextInt(levelAdd) +
            correctAnswer; // giảm miền giá trị của đáp án với hard
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

  
}
