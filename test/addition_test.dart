import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:template/presentation/pages/opinion_play/play_fractice/model/fraction_model.dart';
import 'package:template/presentation/pages/opinion_play/play_fractice/play_fractice_controller.dart';

// Mock class for your dependencies (if any)
// class MockSoundController extends Mock implements SoundController {}

void main() {
  group('PlayFracticeController Tests', () {
    late PlayFracticeController controller;
    // late MockSoundController mockSoundController;

    setUp(() {
      // Initialize the mock objects
      // mockSoundController = MockSoundController();

      // Initializcontroller with mocked dependencies
      controller = PlayFracticeController();
      // Get.put<SoundController>(mockSoundController);
      controller.onInit(); // Make sure to call onInit if your controller has an onInit method
      controller.currentQuestion = "5 + 8 = ?".obs;
      controller.correctAnswer = Fraction(1, 1);
      controller.currentOptions = List<Fraction>.generate(4, (index) => Fraction(0, 0)).obs;
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
      // controller.level = Get.arguments['level'];
      // controller.route = Get.arguments['route'];
      // controller.title = Get.arguments['title'];
      // controller.isSkip = Get.arguments['isSkip'];
      controller.rangeRandom = 10;
      controller.textLevel = ''.obs;
      controller.operand1 = Fraction(1, 1).obs;
      controller.operand2 = Fraction(1, 1).obs;
      controller.fraction = Fraction(1, 1);
      // Fraction result = Fraction(0, 0);
      controller.routeOperation = '';
      controller.levelAdd = 1;
    });

    tearDown(() {
      // Clear the mocks and reset the controller
      Get.reset();
    });

    test('Skip Question Test', () {
      // Arrange
      controller.count.value = 5; // Set count to 5 for testing the condition

      // Act
      controller.skipQuestion();

      // Assert
      expect(controller.countSkip.value, 1);
      expect(controller.count.value, 6);
      // Add more assertions based on your controller's behavior
    });

    test('Check Answer Test - Correct Answer', () {
      // Arrange
      Fraction correctAnswer = Fraction(2, 1);
      controller.correctAnswer = correctAnswer;

      // Act
      controller.checkAnswer(correctAnswer, 1);

      // Assert
      expect(controller.isCorrect, true);
      expect(controller.countCorrect.value, 1);
      // Add more assertions based on your controller's behavior
    });

    test('Check Answer Test - Incorrect Answer', () {
      // Arrange
      Fraction correctAnswer = Fraction(2, 1);
      Fraction selectedAnswer = Fraction(3, 1);

      // Act
      controller.checkAnswer(selectedAnswer, 1);

      // Assert
      expect(controller.isCorrect, false);
      expect(controller.countWrong.value, 1);
      // Add more assertions based on your controller's behavior
    });

    test('Generate Question Test', () {
      // Act
      controller.generateQuestion(10, 'some_route');

      // Assert
      expect(controller.operand1.value, isA<Fraction>());
      expect(controller.operand2.value, isA<Fraction>());
      // Add more assertions based on your controller's behavior
    });

    // Add more tests for other controller methods and behaviors
  });
}
