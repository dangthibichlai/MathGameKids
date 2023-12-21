import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/opinion_play/play_true_false/play_true_false_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:template/core/di_container.dart' as di;

void main() {
  late PlayTrueFalseController controller;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    Get.testMode = true;

    WidgetsFlutterBinding.ensureInitialized();

    await di.init(); // dùng để khởi tạo các service, repository, controller

    // Initialize mobile ads.
    // MobileAds.instance.initialize();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));

    // time_ago.setLocaleMessages('vi', time_ago.ViMessages());

    // IZITimeZone().initializeTimeZones();

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
    controller = PlayTrueFalseController();

    controller.onInit();
    controller.currentQuestion = "5 + 8 = ?".obs;
    controller.correctAnswer = false.obs;
    controller.currentOptions = List<bool>.generate(2, (index) => true).obs;
    controller.isCorrect = false.obs;
    controller.answerColors = <int, Color>{}.obs;
    controller.count = 1.obs;
    controller.countWrong = 0.obs;
    controller.countCorrect = 0.obs;
    controller.countSkip = 0.obs;
    controller.arguments = {
      'level': "Easy",
      'route': "/play_true_false",
      'title': "True or False",
    };
    controller.rangeRandom = 10;
    controller.textLevel = ''.obs;
    controller.levelAdd = 1;
    controller.color = ColorResources.WHITE.obs;
    controller.isEnable = true.obs;
    Get.testMode = true;
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

  group("check answer", () {
    test('Check Answer Test - Correct Answer', () {
      controller.countCorrect = 0.obs;
      controller.countWrong = 0.obs;
      // Arrange
      controller.currentQuestion = "5 + 5 = 10".obs;
      controller.correctAnswer.value = true;

      // Act
      controller.checkLevel(controller.level);
      controller.checkAnswer(true);

      // Assert
      expect(controller.countCorrect.value, 1);
      expect(controller.countWrong.value, 0);
      expect(controller.color.value, ColorResources.HOME_BD_3);
    });

    test('Check Answer Test - Wrong Answer', () {
      controller.countCorrect = 0.obs;
      controller.countWrong = 0.obs;
      // Arrange
      controller.currentQuestion = "5 + 5 = 10".obs;
      controller.correctAnswer.value = true;

      // Act
      controller.checkLevel(controller.level);
      controller.checkAnswer(false);

      // Assert
      expect(controller.countCorrect.value, 0);
      expect(controller.countWrong.value, 1);
      expect(controller.color.value, ColorResources.PLAYFALSE);
    });
  });

  group("UI test", () {
    test("Color level", () {
      expect(controller.getLevelColor(MATHLEVEL.EASY), Colors.green);
      expect(controller.getLevelColor(MATHLEVEL.MEDIUM), Colors.orange);
      expect(controller.getLevelColor(MATHLEVEL.HARD), Colors.red);
    });

    test("Skip question", () {
      controller.countSkip.value = 0;
      controller.skipQuestion();
      expect(controller.countSkip.value, 1);
    });

    test("Skip question when 10", () {
      controller.count.value = 10;
      controller.countSkip.value = 9;

      // Act
      controller.skipQuestion();

      // Assert
      expect(controller.countSkip.value, 0);
      expect(controller.count.value, 1);
    });
  });

  tearDownAll(() => {
        // Clear the mocks and reset the controller
        Get.reset()
      });
}
