import 'package:get/get.dart';
import 'dart:math';

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

import '../../../../core/utils/color_resources.dart';
import 'exponents_model.dart';

class PlayExponentsController extends GetxController with GetSingleTickerProviderStateMixin {
  int correctAnswer = 13;
  RxList<int> currentOptions = List<int>.generate(4, (index) => 0).obs;
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
  int rangeRandom = 10;
  int levelAdd = 1;
  int exponentRandom = 1;

  RxString textLevel = ''.obs;
  Rx<ExponentsModel> exponentsModel = ExponentsModel(base: 0, exponent: 0).obs;
  bool isSkip = false;
  bool isScreenExited = false;
  Rx<bool> isEnable = true.obs;

// multi

  @override
  void onInit() {
    super.onInit();
    // textLevel = RxString(level.name);
    checkLevel(level);
    print(level.name);
    print('route is: ${level.name}');
    generateQuestion(rangeRandom, route);
  }

  @override
  void onClose() {
    count.close();
    countWrong.close();
    countCorrect.close();
    countSkip.close();
    exponentsModel.close();
    currentOptions.close();
    answerColors.close();
    super.onClose();
  }

  void skipQuestion() {
    countSkip.value++; // Tăng biến đếm số câu đã bỏ qua lên 1
    count++;
    if (count.value > 10) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().closeSoundGame();
      }
      //Nếu đã bỏ qua câu hỏi thứ 10, chuyển đến trang kết quả
      Get.offAndToNamed(MainRouters.RESULT, arguments: {
        'countWrong': countWrong.value,
        'countCorrect': countCorrect.value,
        'countSkip': countSkip.value,
      });

      count = 1.obs;
    }
    generateQuestion(rangeRandom, route); // Tạo câu hỏi mới} //
  }

  void checkAnswer(int selectedAnswer) {
    if (!isEnable.value) {
      print('double');
      return;
    }
    isEnable.value = false;
    // kiểm tra đáp án  đúng hay sai sai thì hiển thị màu đỏ cho button, đúng hiện màu xanh cho button, sai làm cho đến khi chọn đúng thì mới qua câu tiếp theo
    if (selectedAnswer == correctAnswer) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerTrueSound();
      }
      isCorrect = true;
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
        Get.offAndToNamed(MainRouters.RESULT, arguments: {
          'countWrong': countWrong.value,
          'countCorrect': countCorrect.value,
          'countSkip': countSkip.value,
        });
        count = 1.obs;
      }

      Future.delayed(const Duration(milliseconds: 800), () {
        // khởi tạo lại màu cho button
        answerColors.clear();
        generateQuestion(rangeRandom, route);
        isEnable.value = true;
      });
    } else {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerFalseSound();
      }
      isCorrect = false;
      answerColors[selectedAnswer] = ColorResources.RED;
      answerColors.refresh();
      countWrong++;
      isEnable.value = true;
    }
  }

  void checkLevel(MATHLEVEL level) {
    if (title.compareTo('select_game_2'.tr) == 0) {
      isSkip = true;
    }

    switch (level) {
      case MATHLEVEL.EASY:
        textLevel = RxString('easy'.tr);
        rangeRandom = MathLevelValueMax.EASY_VALUE__EX;
        levelAdd = MathLevelValueMin.EASY_VALUE__EX_ADD;
        exponentRandom = MathLevelValueMin.EASY_VALUE_EX_BASE;
        break;
      case MATHLEVEL.MEDIUM:
        textLevel = RxString('medium'.tr);
        rangeRandom = MathLevelValueMax.MEDIUM_VALUE_EX;
        levelAdd = MathLevelValueMin.MEDIUM_VALUE_EX_ADD;
        exponentRandom = MathLevelValueMin.MEDIUM_VALUE_EX_BASE;

        break;
      case MATHLEVEL.HARD:
        textLevel = RxString('hard'.tr);
        rangeRandom = MathLevelValueMax.HARD_VALUE_EX;
        levelAdd = MathLevelValueMin.HARD_VALUE_EX_ADD;
        exponentRandom = MathLevelValueMin.HARD_VALUE_EX_BASE;
        break;
    }
  }

  void generateQuestion(int level, String route) {
    final ex = exponentsModel.value;
    print('ex1 is: $rangeRandom');
    print('ex2 is: $levelAdd');
    print('ex3 is: $exponentRandom');
    final Random random = Random();
    exponentsModel.value.base = random.nextInt(level) + levelAdd;
    // cấp độ khó random k có số mũ 1
    if (textLevel.value.compareTo('hard'.tr) == 0) {
      ex.exponent = random.nextInt(exponentRandom) + 2;
    } else {
      ex.exponent = random.nextInt(exponentRandom) + 1;
    }

    // tăng tỉ lệ random để không bị trùng số mũ nhiều
    ExponentsModel(base: ex.base, exponent: ex.exponent);
    // exponentsModel.value = exponentsModel.value
    //     .createRandomExponents(rangeRandom, levelAdd, exponentRandom);
    correctAnswer = exponentsModel.value.calculateExponent(exponentsModel.value);
    currentOptions.clear();
    currentOptions.add(correctAnswer);
    print('ex4 is: $correctAnswer');

    while (currentOptions.length < 4) {
      final option = generateRandomResult(correctAnswer, rangeRandom);
      if (!currentOptions.contains(option)) {
        currentOptions.add(option);
      }
    }
    currentOptions.shuffle();
  }

  int generateRandomResult(int correctAnswer, int range) {
    int lowerBound = range;
    final random = Random();
    if (correctAnswer > 20) {
      lowerBound = correctAnswer - range;
    }

    final upperBound = correctAnswer + range;
    return lowerBound + random.nextInt(upperBound - lowerBound + 1);
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
