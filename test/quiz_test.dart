import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/di_container.dart' as di;
import 'package:template/core/export/core_export.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/presentation/pages/opinion_play/play_quiz/play_quiz_controller.dart';

void main() {
  late playQuizController controller;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    Get.testMode = true;

    WidgetsFlutterBinding.ensureInitialized();

    await di.init(); // dùng để khởi tạo các service, repository, controller

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));

    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1500)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..progressColor = ColorResources.WHITE
      ..backgroundColor = ColorResources.PRIMARY_1
      ..indicatorColor = ColorResources.WHITE
      ..textColor = ColorResources.WHITE
      ..maskColor = Colors.transparent
      ..userInteractions = false
      ..textStyle = const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: ColorResources.WHITE,
      )
      ..dismissOnTap = false;
  });

  setUp(() async {
    controller = playQuizController();
    controller.currentQuestion = "5 + 8 = ?".obs;
    controller.correctAnswer = 13;
    controller.currentOptions = List<int>.generate(4, (index) => 0).obs;
    controller.isCorrect = true;
    controller.answerColors = <int, Color>{}.obs;
    controller.count = 1.obs;
    controller.countWrong = 0.obs;
    controller.countCorrect = 0.obs;
    controller.countSkip = 0.obs;
    final Map<String, dynamic> arguments = {
      'level': "Easy",
      'route': "/play_quiz",
      'title': "Quiz",
    };

    controller.route = arguments['route'];
    controller.title = arguments['title'];
    controller.isSkip = true;
    controller.textLevel = ''.obs;
    controller.isShowResult = false.obs;
    controller.levelAdd = 1;
  });

  group("Skip question", () {
    test('should skip question', () {
      // Arrange
      controller.count = 1.obs;
      controller.countSkip = 0.obs;
      controller.skipQuestion();
      // Act
      // Assert
      expect(controller.countSkip.value, 1);
      expect(controller.count.value, 2);
    });

    test('skip question reset when 10', () {
      // Arrange
      controller.count = 10.obs;
      controller.countSkip = 1.obs;
      controller.skipQuestion();
      // Act
      // Assert
      expect(controller.countSkip.value, 0);
      expect(controller.count.value, 1);
    });
  });

  group("check level", () {
    test('should set values for MATHLEVEL.EASY', () {
      // Arrange

      const MATHLEVEL level = MATHLEVEL.EASY;

      // Act
      controller.checkLevel(level);

      // Assert
      expect(controller.textLevel, equals(RxString('easy')));
      expect(controller.rangeRandom, equals(MathLevelValueMax.EASY_VALUE));
      expect(controller.levelAdd, equals(MathLevelValueMin.EASY_VALUE_ADD));
    });

    test('should set values for MATHLEVEL.MEDIUM', () {
      // Arrange
      const MATHLEVEL level = MATHLEVEL.MEDIUM;

      // Act
      controller.checkLevel(level);

      // Assert
      expect(controller.textLevel, equals(RxString('medium')));
      expect(controller.rangeRandom, equals(MathLevelValueMax.MEDIUM_VALUE));
      expect(controller.levelAdd, equals(MathLevelValueMin.MEDIUM_VALUE_ADD));
    });

    test('should set values for MATHLEVEL.HARD', () {
      // Arrange
      const MATHLEVEL level = MATHLEVEL.HARD;
      // Act
      controller.checkLevel(level);
      // Assert
      expect(controller.textLevel, equals(RxString('hard')));
      expect(controller.rangeRandom, equals(MathLevelValueMax.HARD_VALUE));
      expect(controller.levelAdd, equals(MathLevelValueMin.HARD_VALUE_ADD));
    });
  });

  group("UI", () {
    test("Color level", () {
      expect(controller.getLevelColor(MATHLEVEL.EASY), Colors.green);
      expect(controller.getLevelColor(MATHLEVEL.MEDIUM), Colors.orange);
      expect(controller.getLevelColor(MATHLEVEL.HARD), Colors.red);
    });
  });

  group("check answer", () {
    test("check correct answer", () {
      // Arrange
      controller.currentOptions = List<int>.generate(4, (index) => 0).obs;
      controller.correctAnswer = 13;
      controller.currentOptions[0] = 13;
      controller.count.value = 1;
      controller.countCorrect.value = 0;

      // Act
      controller.checkAnswer(13);
      // Assert

      expect(controller.answerColors[13], Colors.green);
      expect(controller.countCorrect.value, 1);
      expect(controller.count.value, 2);
    });
    test("check wrong answer", () {
      // Arrange
      controller.currentOptions.value = [9, 3, 13, 0];
      controller.correctAnswer = 13;
      controller.currentOptions[2] = 13;
      controller.count.value = 1;
      controller.countCorrect.value = 0;

      // Act
      controller.checkAnswer(9);
      // Assert

      expect(controller.answerColors[9], Colors.red);
      expect(controller.answerColors[13], Colors.green);
      expect(controller.countCorrect.value, 0);
      expect(controller.count.value, 2);
    });
    test("check answer when 10", () {
      controller.currentOptions = List<int>.generate(4, (index) => 0).obs;
      controller.correctAnswer = 13;
      controller.currentOptions[0] = 13;
      controller.count.value = 10;
      controller.countCorrect.value = 0;

      // Act
      controller.checkAnswer(13);
      // Assert
      expect(controller.answerColors[13], Colors.green);
      expect(controller.count.value, 1);
    });
  });

  group("generate question ", () {
    test("generate question is correct easy and addition", () {
      controller.level = MATHLEVEL.EASY;
      controller.route = MainRouters.ADDITION;

      controller.generateQuestion(8, controller.route);

      var question = controller.currentQuestion.value;
      var num1 = int.parse(question.split(' ')[0]);
      var num2 = int.parse(question.split(' ')[2]);
      var operation = question.split(' ')[1];
      expect(operation, "+");
      expect(num1 + num2, controller.correctAnswer);
      expect(controller.currentOptions.length, 4);
      expect(
          controller.currentOptions.contains(controller.correctAnswer), true);
    });

    test("generate question is correct easy and addition", () {
      controller.level = MATHLEVEL.EASY;
      controller.route = MainRouters.ADDITION;

      controller.generateQuestion(8, controller.route);

      var question = controller.currentQuestion.value;
      var num1 = int.parse(question.split(' ')[0]);
      var num2 = int.parse(question.split(' ')[2]);
      var operation = question.split(' ')[1];
      expect(operation, "+");
      expect(num1 + num2, controller.correctAnswer);
      expect(controller.currentOptions.length, 4);
      expect(
          controller.currentOptions.contains(controller.correctAnswer), true);
    });

    test("generate question is correct easy and subtraction", () {
      controller.level = MATHLEVEL.EASY;
      controller.route = MainRouters.SUBTRACTION;

      controller.generateQuestion(8, controller.route);

      var question = controller.currentQuestion.value;
      var num1 = int.parse(question.split(' ')[0]);
      var num2 = int.parse(question.split(' ')[2]);
      var operation = question.split(' ')[1];
      expect(operation, "-");
      expect(num1 - num2, controller.correctAnswer);
      expect(controller.currentOptions.length, 4);
      expect(
          controller.currentOptions.contains(controller.correctAnswer), true);
    });

    test("generate question is correct easy and multiplication", () {
      controller.level = MATHLEVEL.EASY;
      controller.route = MainRouters.MULTIPLICATION;

      controller.generateQuestion(8, controller.route);

      var question = controller.currentQuestion.value;
      var num1 = int.parse(question.split(' ')[0]);
      var num2 = int.parse(question.split(' ')[2]);
      var operation = question.split(' ')[1];
      expect(operation, "x");
      expect(num1 * num2, controller.correctAnswer);
      expect(controller.currentOptions.length, 4);
      expect(
          controller.currentOptions.contains(controller.correctAnswer), true);
    });

    test("generate question is correct easy and division", () {
      controller.level = MATHLEVEL.EASY;
      controller.route = MainRouters.DIVISION;

      controller.generateQuestion(8, controller.route);

      var question = controller.currentQuestion.value;
      var num1 = int.parse(question.split(' ')[0]);
      var num2 = int.parse(question.split(' ')[2]);
      var operation = question.split(' ')[1];
      expect(operation, "/");
      expect(num1 ~/ num2, controller.correctAnswer);
      expect(controller.currentOptions.length, 4);
      expect(
          controller.currentOptions.contains(controller.correctAnswer), true);
    });

    test("generate question is correct medium and addition", () {
      controller.level = MATHLEVEL.MEDIUM;
      controller.route = MainRouters.ADDITION;

      controller.generateQuestion(8, controller.route);

      var question = controller.currentQuestion.value;
      var num1 = int.parse(question.split(' ')[0]);
      var num2 = int.parse(question.split(' ')[2]);
      var operation = question.split(' ')[1];
      expect(operation, "+");
      expect(num1 + num2, controller.correctAnswer);
      expect(controller.currentOptions.length, 4);
      expect(
          controller.currentOptions.contains(controller.correctAnswer), true);
    });

    test("generate question is correct medium and subtraction", () {
      controller.level = MATHLEVEL.MEDIUM;
      controller.route = MainRouters.SUBTRACTION;

      controller.generateQuestion(8, controller.route);

      var question = controller.currentQuestion.value;
      var num1 = int.parse(question.split(' ')[0]);
      var num2 = int.parse(question.split(' ')[2]);
      var operation = question.split(' ')[1];
      expect(operation, "-");
      expect(num1 - num2, controller.correctAnswer);
      expect(controller.currentOptions.length, 4);
      expect(
          controller.currentOptions.contains(controller.correctAnswer), true);
    });

    test("generate question is correct medium and multiplication", () {
      controller.level = MATHLEVEL.MEDIUM;
      controller.route = MainRouters.MULTIPLICATION;

      controller.generateQuestion(8, controller.route);

      var question = controller.currentQuestion.value;
      var num1 = int.parse(question.split(' ')[0]);
      var num2 = int.parse(question.split(' ')[2]);
      var operation = question.split(' ')[1];
      expect(operation, "x");
      expect(num1 * num2, controller.correctAnswer);
      expect(controller.currentOptions.length, 4);
      expect(
          controller.currentOptions.contains(controller.correctAnswer), true);
    });

    test("generate question is correct medium and division", () {
      controller.level = MATHLEVEL.MEDIUM;
      controller.route = MainRouters.DIVISION;

      controller.generateQuestion(8, controller.route);

      var question = controller.currentQuestion.value;
      var num1 = int.parse(question.split(' ')[0]);
      var num2 = int.parse(question.split(' ')[2]);
      var operation = question.split(' ')[1];

      expect(operation, "/");
      expect(num1 ~/ num2, controller.correctAnswer);
      expect(controller.currentOptions.length, 4);
      expect(
          controller.currentOptions.contains(controller.correctAnswer), true);
    });

    test("generate question is correct hard and addition", () {
      controller.level = MATHLEVEL.HARD;
      controller.route = MainRouters.ADDITION;

      controller.generateQuestion(8, controller.route);

      var question = controller.currentQuestion.value;
      var num1 = int.parse(question.split(' ')[0]);

      var num2 = int.parse(question.split(' ')[2]);
      var operation = question.split(' ')[1];
      expect(operation, "+");
      expect(num1 + num2, controller.correctAnswer);
      expect(controller.currentOptions.length, 4);
      expect(
          controller.currentOptions.contains(controller.correctAnswer), true);
    });

    test("generate question is correct hard and subtraction", () {
      controller.level = MATHLEVEL.HARD;
      controller.route = MainRouters.SUBTRACTION;

      controller.generateQuestion(8, controller.route);

      var question = controller.currentQuestion.value;
      var num1 = int.parse(question.split(' ')[0]);

      var num2 = int.parse(question.split(' ')[2]);
      var operation = question.split(' ')[1];
      expect(operation, "-");
      expect(num1 - num2, controller.correctAnswer);
      expect(controller.currentOptions.length, 4);
      expect(
          controller.currentOptions.contains(controller.correctAnswer), true);
    });
  });
  test("onClose", () {
    controller.onClose();
    expect(controller.currentOptions, [0, 0, 0, 0]);
    expect(controller.correctAnswer, 13);
    expect(controller.isCorrect, true);
    expect(controller.answerColors, <int, Color>{}.obs);
    expect(controller.count, 1.obs);
    expect(controller.countWrong, 0.obs);
    expect(controller.countCorrect, 0.obs);
    expect(controller.countSkip, 0.obs);
  });
}
