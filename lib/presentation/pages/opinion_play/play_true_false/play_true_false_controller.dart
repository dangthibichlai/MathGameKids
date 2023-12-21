// ignore_for_file: unrelated_type_equality_checks, parameter_assignments

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

import '../../../../core/shared_pref/constants/enum_helper.dart';

class PlayTrueFalseController extends GetxController
    // ignore: deprecated_member_use
    with
        GetSingleTickerProviderStateMixin {
  RxString currentQuestion = "5 + 8 = 15".obs;
  RxBool correctAnswer = false.obs;
  RxList<bool> currentOptions = List<bool>.generate(2, (index) => true).obs;
  RxBool isCorrect = false.obs;
  RxMap<int, Color> answerColors = <int, Color>{}.obs;
  RxInt count = 1.obs;
  RxInt countWrong = 0.obs;
  RxInt countCorrect = 0.obs;
  RxInt countSkip = 0.obs;
  Map<String, dynamic> arguments = {
    'level': "Easy",
    'route': "/play_true_false",
    'title': "True or False",
  };
  late MATHLEVEL level = MATHLEVEL.EASY;
  late String route = arguments['route'];
  late String title = arguments['title'];
  int rangeRandom = 10;
  RxString textLevel = ''.obs;
  AnimationController? controller;
  Rx<Color> color = ColorResources.WHITE.obs;
  Rx<bool> isEnable = true.obs;
  int levelAdd = 1;

  @override
  void onInit() {
    super.onInit();
    route = arguments['route'];
    title = arguments['title'];
// textLevel = RxString(level.name);
    checkLevel(level);
    generateQuestion(rangeRandom, route);
  }

  void skipQuestion() {
    countSkip.value++; // Tăng biến đếm số câu đã bỏ qua lên 1
    count++;
    if (count.value > 10) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().closeSoundGame();
      }
      count.value = 1;
      //Nếu đã trả lời đủ 10 câu hỏi, chuyển đến trang kết quả
      Get.offAndToNamed(MainRouters.RESULT, arguments: {
        'countWrong': countWrong.value,
        'countCorrect': countCorrect.value,
        'countSkip': countSkip.value,
      });
      countSkip.value = 0;
    }

    generateQuestion(rangeRandom, route);
  }

// ignore: avoid_positional_boolean_parameters
  void checkAnswer(bool answer) {
    isEnable.value = false;
    print('answer is: $answer');
    print('correctAnswer is: $correctAnswer');
    print(currentQuestion.value);

    if (answer == correctAnswer.value) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerTrueSound();
      }
      isCorrect.value = true;
      countCorrect.value++;
      color.value = ColorResources.HOME_BD_3;
    } else {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerFalseSound();
      }
      isCorrect.value = false;
      countWrong.value++;
      color.value = ColorResources.PLAYFALSE;
    }
    print('count is: $isCorrect');
    count++;
    if (count.value > 10) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().closeSoundGame();
      }
      //Nếu đã trả lời đủ 10 câu hỏi, chuyển đến trang kết quả
      Get.offAndToNamed(MainRouters.RESULT, arguments: {
        'countWrong': countWrong.value,
        'countCorrect': countCorrect.value,
        'countSkip': countSkip.value,
      });

      count = 1.obs;
    }
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward().whenComplete(
        () {
          color.value = ColorResources.WHITE;
          generateQuestion(rangeRandom, route);
          isEnable.value = true;
          isCorrect.value = false;
        },
      );

    ///// Tạo câu hỏi mới
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
        break;
    }
  }

  void generateQuestion(int level, String route) {
// random theo mức độ với phép tính cộng trừ nhân chia
    final Random random = Random();
    String routeOperation = '';
// random phép tính cộng trừ nhân chia phép tính cần kiểm tra là true hay false
    int num1 = random.nextInt(level) + levelAdd;
    int num2 = random.nextInt(level) + levelAdd;
    int result = 0;
    switch (route) {
      case MainRouters.ADDITION:
        routeOperation = '+';
        result = num1 + num2;
        break;
      case MainRouters.SUBTRACTION:
        routeOperation = '-';
        while (num1 < num2) {
          num1 = random.nextInt(level) + levelAdd;
          num2 = random.nextInt(level) + levelAdd;
        }
        result = num1 - num2;
        break;
      case MainRouters.MULTIPLICATION:
        routeOperation = '*';
        if (level == MathLevelValueMax.HARD_VALUE) {
          level = MathLevelValueMax.HARD_VALUE_MUL;
          levelAdd = MathLevelValueMin.HARD_VALUE_MUL_ADD;
        } else if (level == MathLevelValueMax.MEDIUM_VALUE) {
          level = MathLevelValueMax.MEDIUM_VALUE_MUL;
          levelAdd = MathLevelValueMin.MEDIUM_VALUE_MUL_ADD;
        }
        num1 = random.nextInt(level) + levelAdd;
        num2 = random.nextInt(level) + levelAdd;
        result = num1 * num2;
        break;
      case MainRouters.DIVISION:
        routeOperation = '/';
        while (num1 % num2 != 0 || num1 == num2) {
          num1 = random.nextInt(level) + levelAdd;
          num2 = random.nextInt(level) + levelAdd;
        }
        result = num1 ~/ num2;
        break;
    }
// tạo câu hỏi
    final bool isTrue = random.nextBool();
    print(isTrue);
    if (!isTrue) {
// Generate a wrong result by adding or subtracting a small random number
      final int wrongResult = result + random.nextInt(10) + 1;
      currentQuestion.value = '$num1 $routeOperation $num2 = $wrongResult';
      correctAnswer.value = false;
    } else {
      currentQuestion.value = '$num1 $routeOperation $num2 = $result';
      correctAnswer.value = true;
    }
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

class MathQuestion {
  String question;
  bool isTrue;

  MathQuestion({required this.question, required this.isTrue});
}
