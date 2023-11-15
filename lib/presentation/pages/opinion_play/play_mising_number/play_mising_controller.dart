// ignore_for_file: parameter_assignments

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

class PlayMissingNumberController extends GetxController {
  // 1-9 : easy
  // 10-99 : medium
  // 100-999 : hard
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
  int rangeRandom = 10;
  RxString textLevel = ''.obs;
  RxInt num2 = 0.obs;
  RxInt num1 = 0.obs;
  RxInt result = 0.obs;
  RxInt position = 0.obs;
  RxInt numberOder = 0.obs;
  String routeOperation = '';
  Color colorMissing = ColorResources.MATHPRIMARY;

  @override
  void onInit() {
    super.onInit();
    // textLevel = RxString(level.name);
    checkLevel(level);

    print(level.name);
    print('route is: ${level.name}');
    generateQuestion(rangeRandom, route);
    print('num1 is: $num1');
    print('num2 is: $num2');
    print(routeOperation);
  }

  @override
  void onClose() {
    super.onClose();
    answerColors.clear();
    currentOptions.clear();
    textLevel.close();
    count.close();
    countWrong.close();
    countCorrect.close();
    countSkip.close();
    num1.close();
    num2.close();
    result.close();
    position.close();
    numberOder.close();

    //count = 1.obs;
  }

  // @override
  // void onClose() {
  //   super.dispose();
  //   answerColors.clear();
  //   currentOptions.clear();
  //   textLevel.value = '';
  //   //count = 1.obs;
  //   countWrong = 0.obs;
  //   countCorrect = 0.obs;
  //   countSkip = 0.obs;
  // }

  void skipQuestion() {
    countSkip.value++; // Tăng biến đếm số câu đã bỏ qua lên 1
    count++;
    generateQuestion(rangeRandom, route);
    if (count.value > 10) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().closeSoundGame();
      }
      // chuyển trang và truyền biến qua trang kết quả
      Get.toNamed(MainRouters.RESULT, arguments: {
        'countWrong': countWrong,
        'countCorrect': countCorrect,
        'countSkip': countSkip,
        'route': route,
      });
      count.value = 1;
    } // // Tạo câu hỏi mới} //
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
    colorMissing = Colors.transparent;

    count.value++; // Tăng biến đếm số câu đã chuyển qua lên 1
    Future.delayed(const Duration(milliseconds: 500), () {
      // khởi tạo lại màu cho button
      answerColors.clear();
      colorMissing = ColorResources.MATHPRIMARY;
      generateQuestion(rangeRandom, route);
    });
    if (count.value > 10) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().closeSoundGame();
      }
      // chuyển trang và truyền biến qua trang kết quả
      Get.toNamed(MainRouters.RESULT, arguments: {
        'countWrong': countWrong,
        'countCorrect': countCorrect,
        'countSkip': countSkip,
        'route': route,
      });
      count.value = 1;
    } //
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
    // random theo mức độ với phép tính cộng trừ nhân chia
    final Random random = Random();

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
    num1.value = random.nextInt(level) + levelAdd;
    num2.value = random.nextInt(level) + levelAdd;

    switch (route) {
      case MainRouters.ADDITION:
        routeOperation = '+';
        result.value = num1.value + num2.value;
        break;
      case MainRouters.SUBTRACTION:
        routeOperation = '-';
        while (num1.value < num2.value) {
          num1.value = random.nextInt(level) + levelAdd;
          num2.value = random.nextInt(level) + levelAdd;
        }
        result.value = num1.value - num2.value;
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
        num1.value = random.nextInt(level) + levelAdd;
        num2.value = random.nextInt(level) + levelAdd;
        result.value = num1.value * num2.value;
        break;
      case MainRouters.DIVISION:
        routeOperation = '/';
        while (num1.value % num2.value != 0 || num1 == num2) {
          num1.value = random.nextInt(level) + levelAdd;
          num2.value = random.nextInt(level) + levelAdd;
        }
        result.value = num1.value ~/ num2.value;
        print('num1 is: $num1');
        print('num2 is: $num2');
        print('result is: $result');
        break;
    }
    // random number position
    numberOder.value = random.nextInt(2);
    print('number: $numberOder');
    switch (numberOder.value) {
      case 0:
        randomPosition(num1.value);
        break;
      case 1:
        randomPosition(num2.value);
        break;
      case 2:
        randomPosition(result.value);
        break;
    }
    // tạo đáp án sai
    currentOptions.clear();
    currentOptions.add(correctAnswer);
    // tạo các đáp án sai
    while (currentOptions.length < 4) {
      final option = random.nextInt(9) + 1;
      if (!currentOptions.contains(option)) {
        currentOptions.add(option);
      }
    }
    currentOptions.shuffle();
    print(currentOptions.toJson());
  }

  void randomPosition(int number) {
    final Random random = Random();
    final int lengthNumber = number.toString().length;
    if (lengthNumber == 1) {
      position.value = 0;
      correctAnswer = number;
    } else {
      position.value = random.nextInt(lengthNumber - 1);

      correctAnswer = int.parse(number.toString()[position.value]);

      print('position is: $correctAnswer');
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
