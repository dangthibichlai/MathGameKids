//PlaySquareRootController
import 'dart:math';

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

import '../../../../core/shared_pref/constants/enum_helper.dart';

class PlaySquareRootController extends GetxController
    with SingleGetTickerProviderMixin {
  int correctAnswer = 13;
  RxList<int> currentOptions = List<int>.generate(4, (index) => 0).obs;
  bool isCorrect = true;
  final RxMap<int, Color> answerColors = <int, Color>{}.obs;
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
  bool isSkip = false;
  RxInt currentQuestion = 0.obs;

  @override
  void onInit() {
    super.onInit();

    print('TechMind run h');

    // textLevel = RxString(level.name);
    checkLevel(level);
    print(level.name);
    print('route is: ${level.name}');
    generateQuestion(rangeRandom, route);

    if (title.compareTo('select_four_5'.tr) == 0) {
      isSkip = true;
    }
  }

  void checkAnswer(int selectedAnswer) {
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
        print('test: $countWrong');
        // chuyển trang và truyền biến qua trang kết quả
        Get.toNamed(MainRouters.RESULT, arguments: {
          'countWrong': countWrong,
          'countCorrect': countCorrect,
          'countSkip': countSkip,
          'route': route,
        });

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
      if (isSkip == true) {
        // hiện xanh cho đáp án đúng và chuyển trang
        answerColors[correctAnswer] = ColorResources.GREEN;
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
        rangeRandom = MathLevelValueMax.EASY_VALUE__MUL;
        break;
      case MATHLEVEL.MEDIUM:
        textLevel = RxString('medium'.tr);
        rangeRandom = MathLevelValueMax.MEDIUM_VALUE_MUL;
        break;
      case MATHLEVEL.HARD:
        textLevel = RxString('hard'.tr);
        rangeRandom = MathLevelValueMax.HARD_VALUE_MUL;
    }
  }

  void generateQuestion(int level, String route) {
    // random theo mức độ với phép tính cộng trừ nhân chia
    final Random random = Random();
    int levelAdd = 10;
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
    correctAnswer = random.nextInt(level) + levelAdd;
    currentQuestion.value = pow(correctAnswer, 2).toInt();

    currentOptions.clear();
    currentOptions.add(correctAnswer);
    print('num1 is: $correctAnswer');

    while (currentOptions.length < 4) {
      int option = random.nextInt(level * 2) + levelAdd;
      if (correctAnswer.toString().length > 2) {
        option = random.nextInt(levelAdd) +
            correctAnswer; // giảm miền giá trị của đáp án với hard
      }
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
