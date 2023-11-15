// ignore_for_file: parameter_assignments

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

class PlayLongAdditionController extends GetxController {
  RxString currentQuestion = "5 + 8 = ?".obs;
  int correctAnswer = 13;
  RxList<int> currentOptions = List<int>.generate(4, (index) => 0).obs;
  bool isCorrect = true;
  Rx<Color?> colorAnswer = ColorResources.MATHGAME_BORDER.obs;
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
  RxInt num2 = 0.obs;
  RxInt num1 = 0.obs;
  RxInt result = 0.obs;
  RxInt position = 0.obs;
  RxInt numberOder = 0.obs;
  String routeOperation = '';

  RxString inputValue = ''.obs;

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
    num1.close();
    num2.close();
    result.close();
    inputValue.close();
    currentQuestion.close();
    currentOptions.close();
    colorAnswer.close();
    isShowResult.close();
    textLevel.close();
    numberOder.close();
    position.close();
    super.onClose();
  }

  void skipQuestion() {
    colorAnswer = ColorResources.MATHGAME_BORDER.obs;
    inputValue.value = '';
    countSkip.value++; // Tăng biến đếm số câu đã bỏ qua lên 1
    count.value++;
    if (count.value > 10) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().closeSoundGame();
      }
      //Nếu đã bỏ qua câu hỏi thứ 10, chuyển đến trang kết quả
      Get.toNamed(MainRouters.RESULT, arguments: {
        'countWrong': countWrong,
        'countCorrect': countCorrect,
        'countSkip': countSkip,
        'route': route,
      });
      isShowResult.value = true;
      count = 1.obs;
    }
    generateQuestion(rangeRandom, route); // Tạo câu hỏi mới} //
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
        routeOperation = '*';
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
    numberOder.value = random.nextInt(2);
    print('number: $numberOder');

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

  void handleNumberButton(String value) {
    colorAnswer.value = ColorResources.MATHGAME_BORDER;
    if (inputValue.value.length >= 6) {
      inputValue.value = inputValue.value;
    } else {
      inputValue.value += value;
    }
  }

  // xóa ký tự cuối cùng
  void handleDeleteButton() {
    colorAnswer.value = ColorResources.MATHGAME_BORDER;
    if (inputValue.value.isNotEmpty) {
      inputValue.value =
          inputValue.value.substring(0, inputValue.value.length - 1);
    }
  }

  // check kết quả
  Future<void> handleCheckButton() async {
    print(inputValue.value);
    if (inputValue.value.isNotEmpty) {
      final int inputResult = int.parse(inputValue.value);
      if (inputResult == result.value) {
        if (Get.isRegistered<SoundController>()) {
          Get.find<SoundController>().playAnswerTrueSound();
        }
        countCorrect.value++;
        isCorrect = true;

        colorAnswer.value = Colors.green.withOpacity(0.5);
        await Future.delayed(const Duration(milliseconds: 500), () {
          // khởi tạo lại màu cho button
          print('regenerate question and reset color');
          count.value++;
          generateQuestion(rangeRandom, route);
          inputValue.value = '';
          colorAnswer.value = ColorResources.MATHGAME_BORDER;
        });
        if (count.value > 10) {
          if (Get.isRegistered<SoundController>()) {
            Get.find<SoundController>().closeSoundGame();
          }
          Get.toNamed(MainRouters.RESULT, arguments: {
            'countWrong': countWrong,
            'countCorrect': countCorrect,
            'countSkip': countSkip,
            'route': route,
          });
          isShowResult.value = true;
          count = 1.obs;
        }
      } else {
        if (Get.isRegistered<SoundController>()) {
          Get.find<SoundController>().playAnswerFalseSound();
        }
        print('wrong title, changer color to red');
        countWrong.value++;
        isCorrect = false;
        colorAnswer.value = ColorResources.RED;
      }
    }
  }

  //  void calculateResult() {
  //   // lấy giá trị của biểu thức người dùng nhập vào
  //   final int inputResult = int.parse(inputValue.value);

  // }
}
