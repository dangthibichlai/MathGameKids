import 'dart:math';

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

class PlayDecimalController extends GetxController
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

  @override
  void onInit() {
    super.onInit();

    print('TechMind run h');

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
    currentQuestion.close();
    currentOptions.close();
    isShowResult.close();
    textLevel.close();
  }

  // enable skip

  void checkAnswer(String selectedAnswer) {
    // kiểm tra đáp án  đúng hay sai sai thì hiển thị màu đỏ cho button, đúng hiện màu xanh cho button, sai làm cho đến khi chọn đúng thì mới qua câu tiếp theo
    if (selectedAnswer.compareTo(correctAnswer.toStringAsFixed(2)) == 0) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerTrueSound();
      }
      isCorrect = true;
      //final index = currentOptions.indexOf(selectedAnswer);
      answerColors[selectedAnswer] = ColorResources.GREEN;
      countCorrect++;
      count++;

      print('count is: $count');
      // ignore: unrelated_type_equality_checks
      if (count > 10) {
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
        isShowResult.value = true;
        count = 1.obs;
      }

      Future.delayed(const Duration(milliseconds: 300), () {
        // khởi tạo lại màu cho button
        answerColors.clear();
        generateQuestion(rangeRandom, route);
      });
    } else {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerFalseSound();
      }
      isCorrect = false;
      answerColors[selectedAnswer] = ColorResources.RED;
      answerColors.refresh();
      countWrong++;
      if (isSkip) {
        answerColors[correctAnswer.toStringAsFixed(2)] = Colors.green;
        count++;
        if (count > 10) {
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
          isShowResult.value = true;
          count = 1.obs;
        }

        Future.delayed(const Duration(milliseconds: 300), () {
          // khởi tạo lại màu cho button
          answerColors.clear();
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

    ///
    /// Random loại phép tính cho từng trang
    ///
    if (title.compareTo('select_four_1'.tr) == 0) {
      routeOperation = '+';
      correctAnswer = double.parse(num1) + double.parse(num2);
    } else if (title.compareTo('select_four_2'.tr) == 0) {
      routeOperation = '-';
      while (double.parse(num1) < double.parse(num2)) {
        num1 = ((random.nextDouble() * level) + levelAdd).toStringAsFixed(2);
        num2 = ((random.nextDouble() * level) + levelAdd).toStringAsFixed(2);
      }
      correctAnswer = double.parse(num1) - double.parse(num2);
    } else if (title.compareTo('select_four_5'.tr) == 0) {
      isSkip = true;
      final int randomOperation = random.nextInt(2);
      switch (randomOperation) {
        case 0:
          routeOperation = '+';
          correctAnswer = double.parse(num1) + double.parse(num2);
          break;
        case 1:
          routeOperation = '-';
          while (double.parse(num1) < double.parse(num2)) {
            num1 =
                ((random.nextDouble() * level) + levelAdd).toStringAsFixed(2);
            num2 =
                ((random.nextDouble() * level) + levelAdd).toStringAsFixed(2);
          }
          correctAnswer = double.parse(num1) - double.parse(num2);
      }
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

  void skipQuestion() {
    countSkip.value++; // Tăng biến đếm số câu đã bỏ qua lên 1
    count++;
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
