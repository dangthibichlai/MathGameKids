import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/opinion_play/play_time_challenge/play_time_challenge_controller.dart';
import 'package:template/core/di_container.dart' as di;

void main() {
  late PlayTimeChallengeController controller;

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
    controller = PlayTimeChallengeController();
    controller.currentQuestion = "5 + _ = 8".obs;
    controller.correctAnswer = 13;
    controller.currentOptions = List<int>.generate(4, (index) => 0).obs;
    controller.isCorrect = true;
    // controller.answerColors = <int, Color>{}.obs;
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
    // controller.isSkip = true;
    controller.textLevel = ''.obs;
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
      expect(
          controller.levelAdd, equals(MathLevelValueMin.EASY_VALUE_ADD));
    });

    test('should set values for MATHLEVEL.MEDIUM', () {
      // Arrange
      const MATHLEVEL level = MATHLEVEL.MEDIUM;

      // Act
      controller.checkLevel(level);

      // Assert
      expect(controller.textLevel, equals(RxString('medium')));
      expect(controller.rangeRandom, equals(MathLevelValueMax.MEDIUM_VALUE));
      expect(
          controller.levelAdd, equals(MathLevelValueMin.MEDIUM_VALUE_ADD));
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
}
