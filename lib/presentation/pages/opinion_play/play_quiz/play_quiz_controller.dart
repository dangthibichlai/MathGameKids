// ignore_for_file: parameter_assignments

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

// ignore: camel_case_types
class playQuizController extends GetxController {
  RxString currentQuestion = "5 + 8 = ?".obs;
  int correctAnswer = 13;
  RxList<int> currentOptions = List<int>.generate(4, (index) => 0).obs;
  bool isCorrect = true;
  RxMap<int, Color> answerColors = <int, Color>{}.obs;
  RxInt count = 1.obs;
  RxInt countWrong = 0.obs;
  RxInt countCorrect = 0.obs;
  RxInt countSkip = 0.obs;
  final Map<String, dynamic> arguments = Get.arguments;
  MATHLEVEL level = Get.arguments['level'];
  String route = Get.arguments['route'];
  String title = Get.arguments['title'];
  bool isSkip = Get.arguments['isSkip'];
  int rangeRandom = 10;
  RxString textLevel = ''.obs;
  RxBool isShowResult = false.obs;
  int levelAdd = 1;

  @override
  void onInit() {
    super.onInit();
    // textLevel = RxString(level.name);
    checkLevel(level);
    print(level.name);
    print('route is: ${level.name}');
    generateQuestion(rangeRandom, route);
  }

  @override
  void onClose() {
    super.onClose();
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

  void skipQuestion() {
    countSkip.value++; // Tăng biến đếm số câu đã bỏ qua lên 1
    count++;
    if (count.value > 10) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().closeSoundGame();
      }
      //Nếu đã bỏ qua câu hỏi thứ 10, chuyển đến trang kết quả
      Get.offAndToNamed(MainRouters.RESULT, arguments: {
        'countWrong': countWrong.value,
        'countCorrect': countCorrect.value,
        'countSkip': countSkip.value,
      });

      isShowResult.value = true;
      count = 1.obs;
    }
    generateQuestion(rangeRandom, route); // Tạo câu hỏi mới} //
  }

  void checkAnswer(int selectedAnswer) {
    if (selectedAnswer == correctAnswer) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerTrueSound();
      }
      // Nếu câu trả lời đúng
      isCorrect = true;
      answerColors[selectedAnswer] = Colors.green;
      countCorrect.value++;
    } else {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerFalseSound();
      }
      // Nếu câu trả lời sai
      isCorrect = false;
      answerColors[selectedAnswer] = Colors.red;
      answerColors[correctAnswer] = Colors.green;
      countWrong.value++;
    }

    count.value++; // Tăng biến đếm số câu đã chuyển qua lên 1
    Future.delayed(const Duration(milliseconds: 800), () {
      // khởi tạo lại màu cho button
      answerColors.clear();
      generateQuestion(rangeRandom, route);
    });
    if (count.value > 10) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().closeSoundGame();
      }
      // chuyển trang và truyền biến qua trang kết quả
      Get.offAndToNamed(MainRouters.RESULT, arguments: {
        'countWrong': countWrong.value,
        'countCorrect': countCorrect.value,
        'countSkip': countSkip.value,
      });

      count = 1.obs;
    } // Tạo câu hỏi mới
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

    int num1 = random.nextInt(level) + levelAdd;
    int num2 = random.nextInt(level) + levelAdd;
    print('num1 is: $num1');
    print('num1 is: $num2');
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
}
