import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';

import 'package:template/presentation/pages/opinion_play/play_true_false/play_true_false_controller.dart';

void main() {
  group('True Or False Tests', () {
    late PlayTrueFalseController controller;

    setUp(() {
      controller = PlayTrueFalseController();
      controller.onInit();
      controller.currentQuestion = "5 + 8 = ?".obs;
      controller.currentOptions = List<bool>.generate(2, (index) => true).obs;
      controller.isCorrect = false.obs;
      controller.answerColors = <int, Color>{}.obs;
      controller.count = 1.obs;
      controller.countWrong = 0.obs;
      controller.countSkip = 0.obs;
      controller.arguments = {
        'level': "Easy",
        'route': "/addition",
        'title': "Addition",
      };
      MATHLEVEL level = MATHLEVEL.EASY;
      String route = "/addition";
      String title = "Addition";
    });
    tearDown(() {
      // Clear the mocks and reset the controller
      Get.reset();
    });
    group('CheckLevel', () {
      test('shoud set value for MATHLEVEL.EASY', () {
        const MATHLEVEL level = MATHLEVEL.EASY;

        controller.checkLevel(level);

        expect(controller.textLevel, equals(RxString('easy')));
        expect(controller.rangeRandom, equals(8));
        expect(controller.levelAdd, equals(MathLevelValueMin.EASY_VALUE_ADD));
      });

      test('should set values for MATHLEVEL.MEDIUM', () {
        // Arrange
        const MATHLEVEL level = MATHLEVEL.MEDIUM;

        // Act
        controller.checkLevel(level);

        // Assert
        expect(controller.textLevel, equals(RxString('medium')));
        expect(controller.rangeRandom, equals(89));
        expect(controller.levelAdd, equals(MathLevelValueMin.MEDIUM_VALUE_ADD));
      });

      test('should set values for MATHLEVEL.HARD', () {
        // Arrange
        const MATHLEVEL level = MATHLEVEL.HARD;
        // Act
        controller.checkLevel(level);
        // Assert
        expect(controller.textLevel, equals(RxString('hard')));
        expect(controller.rangeRandom, equals(500));
        expect(controller.levelAdd, equals(MathLevelValueMin.HARD_VALUE_ADD));
      });

      test('Skip Question Test - click skip button', () {
      // Arrange
      controller.count.value = 5;

      // Act
      controller.skipQuestion();

      // Assert
      expect(controller.countSkip.value, 1);
      expect(controller.count.value, 6);
    });

    
    
    });
  });
}
