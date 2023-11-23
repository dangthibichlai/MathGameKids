import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:template/presentation/pages/opinion_play/play_fractice/model/fraction_model.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

import '../../../../config/routes/route_path/main_routh.dart';
import '../../../../core/shared_pref/constants/enum_helper.dart';

class PlayFracticeController extends GetxController {
  RxString currentQuestion = "5 + 8 = ?".obs;
  Fraction correctAnswer = Fraction(1, 1);
  RxList<Fraction> currentOptions = List<Fraction>.generate(4, (index) => Fraction(0, 0)).obs;
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
  Rx<Fraction> operand1 = Fraction(1, 1).obs;
  Rx<Fraction> operand2 = Fraction(1, 1).obs;
  final Fraction fraction = Fraction(1, 1);
  // Fraction result = Fraction(0, 0);
  String routeOperation = '';
  int levelAdd = 1;
  @override
  void onInit() {
    super.onInit();
    // textLevel = RxString(level.name);
    checkLevel(level);
    generateQuestion(rangeRandom, route);
    print('route is: $route');
  }

  @override
  void onClose() {
    count.close();
    countWrong.close();
    countCorrect.close();
    countSkip.close();
    currentOptions.close();
    answerColors.close();
    textLevel.close();
    operand1.close();
    operand2.close();
    currentQuestion.close();
    super.onClose();
  }

  void skipQuestion() {
    countSkip.value++; // Tang bi?n d?m s? câu dã b? qua lên 1
    count++;
    if (count.value > 10) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().closeSoundGame();
      }
      //N?u dã b? qua câu h?i th? 10, chuy?n d?n trang k?t qu?
      Get.offAndToNamed(MainRouters.RESULT, arguments: {
        'countWrong': countWrong.value,
        'countCorrect': countCorrect.value,
        'countSkip': countSkip.value,
      });

      count = 1.obs;
    }
    generateQuestion(rangeRandom, route); // T?o câu h?i m?i} //
  }

  void checkAnswer(Fraction selectedAnswer, int index) {
    print('selectedAnswer is: $currentOptions[selectedAnswer]');
    print('correctAnswer is: $correctAnswer');

    // ignore: unrelated_type_equality_checks
    if (selectedAnswer == correctAnswer) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerTrueSound();
      }
      // N?u câu tr? l?i dúng
      isCorrect = true;
      answerColors[index] = Colors.green;
      countCorrect.value++;
    } else {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerFalseSound();
      }
      // N?u câu tr? l?i sai
      isCorrect = false;
      answerColors[index] = Colors.red;
      // xNH
      countWrong.value++;
      for (int i = 0; i < currentOptions.length; i++) {
        if (currentOptions[i] == correctAnswer) {
          answerColors[i] = Colors.green;
          break; // D?ng sau khi tìm th?y câu tr? l?i dúng
        }
      }
    }

    count.value++; // Tang bi?n d?m s? câu dã chuy?n qua lên 1
    Future.delayed(const Duration(milliseconds: 800), () {
      // kh?i t?o l?i màu cho button
      answerColors.clear();
      generateQuestion(rangeRandom, route);
    });
    if (count.value > 10) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().closeSoundGame();
      }
      // chuy?n trang và truy?n bi?n qua trang k?t qu?
      Get.offAndToNamed(MainRouters.RESULT, arguments: {
        'countWrong': countWrong.value,
        'countCorrect': countCorrect.value,
        'countSkip': countSkip.value,
      });

      count = 1.obs;
    } // T?o câu h?i m?i
  }

  void checkLevel(MATHLEVEL level) {
    switch (level) {
      case MATHLEVEL.EASY:
        textLevel = RxString('Easy');
        rangeRandom = 7;
        levelAdd = MathLevelValueMin.EASY_VALUE_ADD;
        break;
      case MATHLEVEL.MEDIUM:
        textLevel = RxString('Medium');
        rangeRandom = 9;
        levelAdd = MathLevelValueMin.MEDIUM_VALUE_ADD;
        break;
      case MATHLEVEL.HARD:
        textLevel = RxString('Hard');
        rangeRandom = 15;
        levelAdd = MathLevelValueMin.MEDIUM_VALUE_ADD;
    }
  }

  void generateQuestion(int level, String route) {
    operand1.value = fraction.createRandomFraction(level, levelAdd);
    operand2.value = fraction.createRandomFraction(level, levelAdd);
    print(' operand1.value is: $operand1');
    print(' operand2.value is: $operand2');
    print(Get.currentRoute);
    // switch (title) {
    //   case 'Practice Addition':
    //     routeOperation = '+';
    //     // g?i hàn tính t?ng
    //     correctAnswer = operand1.value + operand2.value;
    //     break;
    //   case 'Practice Subtraction':
    //     routeOperation = '-';
    //     // n?u phân s? th? 1 nh? hon phân s? th? 2 thì d?i v? trí 2 phân s?
    //     if ((operand1.value.numerator / operand1.value.denominator) <
    //         (operand2.value.numerator / operand2.value.denominator)) {
    //       final Fraction temp = operand1.value;
    //       operand1.value = operand2.value;
    //       operand2.value = temp;
    //     }
    //     correctAnswer = operand1.value - operand2.value;
    //     break;
    //   case 'Practice Multiplication':
    //     routeOperation = 'x';
    //     correctAnswer = operand1.value * operand2.value;
    //     break;
    //   case 'Practice Division':
    //     routeOperation = '/';
    //     correctAnswer = operand1.value / operand2.value;
    //     break;
    // }
    // print(operand1.value);
    // print(operand2.value);
    if (title.compareTo('select_four_1'.tr) == 0) {
      routeOperation = '+';
      correctAnswer = operand1.value + operand2.value;
    } else if (title.compareTo('select_four_2'.tr) == 0) {
      routeOperation = '-';
      if ((operand1.value.numerator / operand1.value.denominator) <
          (operand2.value.numerator / operand2.value.denominator)) {
        final Fraction temp = operand1.value;
        operand1.value = operand2.value;
        operand2.value = temp;
      }

      correctAnswer = operand1.value - operand2.value;
    } else if (title.compareTo('select_four_3'.tr) == 0) {
      routeOperation = 'x';
      correctAnswer = operand1.value * operand2.value;
    } else if (title.compareTo('select_four_4'.tr) == 0) {
      routeOperation = '/';
      if ((operand1.value.numerator / operand1.value.denominator) <
          (operand2.value.numerator / operand2.value.denominator)) {
        final Fraction temp = operand1.value;
        operand1.value = operand2.value;
        operand2.value = temp;
      }
      correctAnswer = operand1.value / operand2.value;
    }
    currentOptions.clear();
    correctAnswer = fraction.simplify(correctAnswer.numerator, correctAnswer.denominator);
    print(correctAnswer);
    currentOptions.add(correctAnswer);
    while (currentOptions.length < 4) {
      final Fraction fraction1 = fraction.createRandomFraction(level, levelAdd);
      if (!currentOptions.contains(fraction1)) {
        currentOptions.add(fraction1);
      }

      currentOptions.shuffle();
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
