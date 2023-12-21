import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/presentation/pages/home/home_page.dart';
import 'package:template/presentation/pages/opinion_play/play_practice/play_practice_controller.dart';

void main() {
  group('PlayParacticeController Test', () {
    late PlayPracticeController controller;

    setUp(() {
      controller = PlayPracticeController();
      controller.onInit();
      controller.currentQuestion = "5 + 8 = ?".obs;
      controller.currentOptions = List<int>.generate(4, (index) => 0).obs;
      controller.count = 1.obs;
      controller.isCorrect = true;

      controller.countWrong = 0.obs;
      controller.countCorrect = 0.obs;
      controller.countSkip = 0.obs;
      controller.rangeRandom = 10;
      controller.textLevel = ''.obs;
      controller.arguments = {
        'level': "Easy",
        'route': "/addition",
        'title': "Addition",
      };
      MATHLEVEL level = MATHLEVEL.EASY;
      String route = "/addition";
      String title = "Addition";
      controller.levelAdd = 1;
      Get.testMode = true;
    });

    tearDown(() {
      // Clear the mocks and reset the controller
      Get.reset();
    });

    group('checkLevel', () {
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

      test('Check Answer Test - Correct Answer', () {
        controller.countCorrect = 0.obs;
        controller.countWrong = 0.obs;
        // Arrange
        controller.num1.value = 1;
        controller.num2.value = 2;
        controller.correctAnswer = 3;

        // Act
        controller.checkLevel(controller.level);
        controller.generateQuestion(controller.rangeRandom, controller.route);
        controller.checkAnswer(controller.correctAnswer);
        final correctPosition = controller.currentOptions
            .indexWhere((element) => element == controller.correctAnswer);
        // Assert
        expect(controller.countCorrect.value, 1);
        expect(controller.countWrong.value, 0);
        // expect(controller.answerColors[correctPosition], Colors.green);
      });

      test('Check Answer Test - Incorrect Answer', () {
        controller.countCorrect = 0.obs;
        controller.countWrong = 0.obs;
        // Arrange
        controller.num1.value = 1;
        controller.num2.value = 2;
        controller.correctAnswer = 3;

        // Act
        controller.checkLevel(controller.level);
        controller.generateQuestion(controller.rangeRandom, controller.route);
        final wrongPosition = controller.currentOptions
            .indexWhere((element) => element != controller.correctAnswer);
        controller.checkAnswer(
            controller.currentOptions[wrongPosition]);

        // Assert
        expect(controller.countCorrect.value, 0);
        expect(controller.countWrong.value, 1);
        expect(controller.answerColors[wrongPosition], Colors.red);
      });

      testWidgets('Check if current screen is HomePage', (WidgetTester tester) async{
        await tester.pumpWidget(MaterialApp(home: HomePage(),));
        final listOperationFinder = find.byKey(const Key('_listOperation'));
        expect(listOperationFinder, findsOneWidget);
      });
      
      testWidgets('Test Home Screen and Math Operations Screen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(GetMaterialApp(
      home: HomePage(),
    ));

    // Verify that Home screen is showing up.
    expect(find.text('Home'), findsOneWidget);

    // Tap on the 'Go to Math Operations' button.
    await tester.tap(find.byKey(Key('go_to_math_operations')));
    await tester.pumpAndSettle();

    // Verify that Math Operations screen is showing up.
    expect(find.text('Math Operations'), findsOneWidget);
  });
    });
    
  });
}
