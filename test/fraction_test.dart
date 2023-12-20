import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/presentation/pages/opinion_play/play_fractice/model/fraction_model.dart';
import 'package:template/presentation/pages/opinion_play/play_fractice/play_fractice_controller.dart';
import 'dart:math';

void main() {
  // group('PlayFracticeController Tests', () {
    late PlayFracticeController controller;

    setUp(() {
      controller = PlayFracticeController();
      controller.onInit();
      controller.currentQuestion = "5 + 8 = ?".obs;
      controller.correctAnswer = Fraction(1, 1);
      controller.currentOptions =
          List<Fraction>.generate(4, (index) => Fraction(0, 0)).obs;
      controller.isCorrect = true;
      controller.answerColors = <int, Color>{}.obs;
      controller.count = 1.obs;
      controller.countWrong = 0.obs;
      controller.countCorrect = 0.obs;
      controller.countSkip = 0.obs;
      controller.arguments = {
        'level': "Easy",
        'route': "/addition",
        'title': "Addition",
      };
      controller.rangeRandom = 10;
      controller.textLevel = ''.obs;
      controller.operand1 = Fraction(1, 1).obs;
      controller.operand2 = Fraction(1, 1).obs;
      controller.fraction = Fraction(1, 1);
      // Fraction result = Fraction(0, 0);
      controller.routeOperation = '';
      controller.levelAdd = 1;
      Get.testMode = true;
    });

    tearDown(() {
      // Clear the mocks and reset the controller
      Get.reset();
    });
    group('checkLevel', () {
      test('should set values for MATHLEVEL.EASY', () {
        // Arrange
        const MATHLEVEL level = MATHLEVEL.EASY;

        // Act
        controller.checkLevel(level);

        // Assert
        expect(controller.textLevel, equals(RxString('Easy')));
        expect(controller.rangeRandom, equals(7));
        expect(controller.levelAdd, equals(MathLevelValueMin.EASY_VALUE_ADD));
      });

      test('should set values for MATHLEVEL.MEDIUM', () {
        // Arrange
        const MATHLEVEL level = MATHLEVEL.MEDIUM;

        // Act
        controller.checkLevel(level);

        // Assert
        expect(controller.textLevel, equals(RxString('Medium')));
        expect(controller.rangeRandom, equals(9));
        expect(controller.levelAdd, equals(MathLevelValueMin.MEDIUM_VALUE_ADD));
      });

      test('should set values for MATHLEVEL.HARD', () {
        // Arrange
        const MATHLEVEL level = MATHLEVEL.HARD;
        // Act
        controller.checkLevel(level);
        // Assert
        expect(controller.textLevel, equals(RxString('Hard')));
      expect(controller.rangeRandom, equals(15));
        expect(controller.levelAdd, equals(MathLevelValueMin.MEDIUM_VALUE_ADD));
      });
    });

    // Hàm SkipQuestion
    test('Skip Question Test - click skip button', () {
      // Arrange
      controller.count.value = 5;

      // Act
      controller.skipQuestion();

      // Assert
      expect(controller.countSkip.value, 1);
      expect(controller.count.value, 6);
    });

    test('Skip Question Test - click skip when end of question', () {
      // Arrange
      controller.count.value = 10;

      // Act
      controller.skipQuestion();

      // Assert
      expect(controller.count.value, 1);
      expect(Get.previousRoute, "");
    });

    // Hàm checkAnswer
    test('Check Answer Test - Correct Answer', () {
      controller.countCorrect = 0.obs;
      controller.countWrong = 0.obs;
      // Arrange
      controller.operand1.value = Fraction(1, 1);
      controller.operand2.value = Fraction(2, 1);
      controller.correctAnswer = Fraction(3, 1);

      // Act
      controller.checkLevel(controller.level);
      controller.generateQuestion(controller.rangeRandom, controller.route);
      final position =
          controller.currentOptions.indexOf(controller.correctAnswer);
      controller.checkAnswer(controller.correctAnswer, position);

      // Assert
      expect(controller.countCorrect.value, 1);
      expect(controller.countWrong.value, 0);
      expect(controller.answerColors[position], Colors.green);
    });

    test('Check Answer Test - Incorrect Answer', () {
      controller.countCorrect = 0.obs;
      controller.countWrong = 0.obs;
      // Arrange
      controller.operand1.value = Fraction(1, 1);
      controller.operand2.value = Fraction(2, 1);
      controller.correctAnswer = Fraction(3, 1);

      // Act
      controller.checkLevel(controller.level);
      controller.generateQuestion(controller.rangeRandom, controller.route);
      final wrongPosition = controller.currentOptions
          .indexWhere((element) => element != controller.correctAnswer);
      controller.checkAnswer(
          controller.currentOptions[wrongPosition], wrongPosition);

      // Assert
      expect(controller.countCorrect.value, 0);
      expect(controller.countWrong.value, 1);
      expect(controller.answerColors[wrongPosition], Colors.red);
    });

    test('Generate Question Test', () {
      // Act
      controller.checkLevel(controller.level);
      controller.generateQuestion(controller.rangeRandom, controller.route);

      // Assert
      expect(controller.operand1.value, isA<Fraction>());
      expect(controller.operand2.value, isA<Fraction>());
      expect(controller.currentOptions.length, 4);
      expect(
          controller.currentOptions.contains(controller.correctAnswer), true);
    });
    test('Check in ResultPage', () {
      // Act
      controller.countWrong = 0.obs;
      controller.countCorrect = 0.obs;
      controller.countSkip = 0.obs;
      int correctCount = 0;
      int wrongCount = 0;
      final Random random = Random();

      for (int j = 0; j < 10; j++) {
        controller.checkLevel(controller.level);
        controller.generateQuestion(controller.rangeRandom, controller.route);
        final int position =
            controller.currentOptions.indexOf(controller.correctAnswer);
        final int randomNumber = random.nextInt(4);
        controller.checkAnswer(controller.currentOptions[randomNumber], j);
        if (randomNumber == position) {
          correctCount++;
        } else {
          wrongCount++;
        }
      }
      expect(controller.countCorrect.value, correctCount);
      expect(controller.countWrong.value, wrongCount);
    });
    test("Check generate value for level MEDIUM", () {
      // Arrange
      controller.level = MATHLEVEL.MEDIUM;

      //Act
      controller.checkLevel(controller.level);

      //Assertoke

      expect(controller.textLevel, RxString('Medium'));
      expect(controller.rangeRandom, 9);
      expect(controller.levelAdd, 11);
    });

    test("Is generate question  following by checkLevel Medium", () {
      // Arrange
      controller.level = MATHLEVEL.MEDIUM;

      //tức dòng nàu
      controller.checkLevel(controller.level);
      controller.generateQuestion(controller.rangeRandom, controller.route);
      // Lấy giá trị của operand1 và operand2
      final Fraction operand1Value = controller.operand1.value;
      final Fraction operand2Value = controller.operand2.value;

      // Kiểm tra xem giá trị có nằm trong khoảng mong đợi không
      final bool checkOperand1 =
          operand1Value.numerator >= controller.levelAdd &&
              operand1Value.numerator <=
                  (controller.levelAdd + controller.rangeRandom);
      final bool checkOperand2 =
          operand2Value.numerator >= controller.levelAdd &&
              operand2Value.numerator <=
                  (controller.levelAdd + controller.rangeRandom);
      final bool isZero1 = operand1Value.denominator == 0;
      final bool isZero2 = operand1Value.denominator == 0;

      expect(checkOperand1, isTrue);
      expect(checkOperand2, isTrue);
      expect(isZero1, isFalse);
      expect(isZero2, isFalse);
    });
  // });
}
