import 'package:get/get.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:template/config/routes/route_path/main_routh.dart';

import 'package:template/core/export/core_export.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

//import 'package:template/data/export/data_export.dart';

class PlayAlgebraController extends GetxController with WidgetsBindingObserver {
  RxString currentQuestion = "5 + X = 8".obs;
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
  int rangeRandom = 10;
  int levelAdd = 1;
  RxString textLevel = ''.obs;
  RxBool isShowResult = false.obs;
  Rx<int> positionMissing = 0.obs;
  Rx<bool> isEnable = true.obs;

  @override
  void onInit() {
    super.onInit();

    checkLevel(level);
    generateQuestion(rangeRandom, route);
  }

  @override
  void onClose() {
    count.close();
    countWrong.close();
    countCorrect.close();
    countSkip.close();
    currentQuestion.close();
    currentOptions.close();
    isShowResult.close();
    textLevel.close();
    positionMissing.close();
    super.onClose();
  }

  void checkAnswer(int selectedAnswer) {
    if (!isEnable.value) {
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

      if (count > 10) {
        if (Get.isRegistered<SoundController>()) {
          Get.find<SoundController>().closeSoundGame();
        }
        // chuyển trang và truyền biến qua trang kết quả
        Get.offAndToNamed(MainRouters.RESULT, arguments: {
          'countWrong': countWrong.value,
          'countCorrect': countCorrect.value,
          'countSkip': countSkip.value,
        });
        isShowResult.value = true;
        count = 1.obs;
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
        textLevel = RxString('easy'.tr);
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
    }
  }

  void generateQuestion(int level, String route) {
    // random theo mức độ với phép tính cộng trừ nhân chia
    final Random random = Random();
    String routeOperation = '';
    int num1 = random.nextInt(level) + levelAdd;
    int num2 = random.nextInt(level) + levelAdd;

    ///
    /// random phép toán
    ///
    if (title.compareTo('select_four_1'.tr) == 0) {
      routeOperation = '+';
      correctAnswer = num1 + num2;
    } else if (title.compareTo('select_four_2'.tr) == 0) {
      routeOperation = '-';
      while (num1 < num2) {
        num1 = random.nextInt(level) + levelAdd;
        num2 = random.nextInt(level) + levelAdd;
      }
      correctAnswer = num1 - num2;
    } else if (title.compareTo('select_four_3'.tr) == 0) {
      routeOperation = 'x';
      if (level == MathLevelValueMax.HARD_VALUE) {
        // ignore: parameter_assignments
        level = MathLevelValueMax.HARD_VALUE_MUL;
        levelAdd = MathLevelValueMin.HARD_VALUE_MUL_ADD;
      } else if (level == MathLevelValueMax.MEDIUM_VALUE) {
        // ignore: parameter_assignments
        level = MathLevelValueMax.MEDIUM_VALUE_MUL;
        levelAdd = MathLevelValueMin.MEDIUM_VALUE_MUL_ADD;
      }
      num1 = random.nextInt(level) + levelAdd;
      num2 = random.nextInt(level) + levelAdd;
      correctAnswer = num1 * num2;
    } else if (title.compareTo('select_four_4'.tr) == 0) {
      routeOperation = '/';
      while (num1 % num2 != 0 || num1 == num2) {
        num1 = random.nextInt(level) + levelAdd;
        num2 = random.nextInt(level) + levelAdd;
      }
      correctAnswer = num1 ~/ num2;
    }

    ///
    ///Vị trí x
    ///
    positionMissing.value = random.nextInt(2);
    // thay X cho vị trí bất kỳ trong  currentQuestion
    if (positionMissing.value == 0) {
      currentQuestion.value = 'X $routeOperation $num2 = $correctAnswer \nX = ';
      correctAnswer = num1;
    } else if (positionMissing.value == 1) {
      currentQuestion.value = '$num1 $routeOperation X = $correctAnswer \nX = ';
      correctAnswer = num2;
    } else {
      currentQuestion.value = '$num1 $routeOperation $num2 = X \nX = ';
    }
    currentOptions.clear();
    currentOptions.add(correctAnswer);

    while (currentOptions.length < 4) {
      int option = random.nextInt(level * 2) + levelAdd;
      if (correctAnswer.toString().length > 2) {
        option = random.nextInt(levelAdd) + correctAnswer; // giảm miền giá trị của đáp án với hard
      }
      if (!currentOptions.contains(option)) {
        currentOptions.add(option);
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
