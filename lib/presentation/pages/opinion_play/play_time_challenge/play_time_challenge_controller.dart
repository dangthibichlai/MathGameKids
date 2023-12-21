// ignore_for_file: parameter_assignments

import 'package:get/get.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

class PlayTimeChallengeController extends GetxController
    // ignore: deprecated_member_use
    with
        GetSingleTickerProviderStateMixin,
        WidgetsBindingObserver {
  // ignore_for_file: unnecessary_statements, avoid_bool_literals_in_conditional_expressions

  // 1-9 : easy
  // 10-99 : medium
  // 100-999 : hard
  RxString currentQuestion = "5 + _ = 8".obs;
  int correctAnswer = 13;
  RxList<int> currentOptions = List<int>.generate(4, (index) => 0).obs;
  bool isCorrect = true;
  RxMap<int, Color> answerColors = <int, Color>{}.obs;
  RxInt count = 1.obs;
  RxInt countWrong = 0.obs;
  RxInt countCorrect = 0.obs;
  RxInt countSkip = 0.obs;
  Map<String, dynamic> arguments = {
    'level': "Easy",
    'route': "/addition",
    'title': "Addition",
  };
   MATHLEVEL level = MATHLEVEL.EASY;
  String route = "/addition";
  String title = "Addition";
  int rangeRandom = 10;
  int levelAdd = 1;
  RxString textLevel = ''.obs;
  late AnimationController _animationController;
  bool isScreenExited = false;

  @override
  void onInit() {
    // WidgetsBinding.instance.addObserver(this);
    super.onInit();
    // textLevel = RxString(level.name);
    checkLevel(level);
    print(level.name);
    print('route is: ${level.name}');
    generateQuestion(rangeRandom, route);
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 30));

    _animationController.addListener(() {
      print('It run please');
      if (isScreenExited) {
        _animationController.stop();
      }
    });

    // check logged in or not.
    // _animationController.forward().whenComplete(() async {
    //   print('It inside');

    //   if (!Get.isDialogOpen!) {
    //     print('It run please???');
    //     Get.offAndToNamed(MainRouters.RESULT, arguments: {
    //       'countWrong': countWrong.value,
    //       'countCorrect': countCorrect.value,
    //       'countSkip': countSkip.value,
    //     });
    //     isScreenExited = true;
    //   }
    // });
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.inactive) {
  //     // Ứng dụng không active, tạm dừng animation
  //     if (_animationController.isAnimating) {
  //       _animationController.stop();
  //     }
  //   } else if (state == AppLifecycleState.resumed) {
  //     // Ứng dụng được active lại, kiểm tra điều kiện và tiếp tục animation nếu cần
  //     if (!isScreenExited) {
  //       _animationController.forward();
  //     }
  //   }
  // }

  void skipQuestion() {
    countSkip.value++; // Tăng biến đếm số câu đã bỏ qua lên 1
    count++;
    if(count>10){
      count.value=1;
      countSkip.value =0;
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

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    super.dispose();
  }
}
