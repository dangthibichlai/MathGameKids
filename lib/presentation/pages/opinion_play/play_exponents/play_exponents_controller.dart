import 'package:get/get.dart';
import 'dart:math';

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

import '../../../../core/utils/color_resources.dart';
import 'exponents_model.dart';

class PlayExponentsController extends GetxController
    with SingleGetTickerProviderMixin {
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
  RxString textLevel = ''.obs;
  Rx<ExponentsModel> exponentsModel = ExponentsModel(base: 0, exponent: 0).obs;
  bool isSkip = false;
  bool isScreenExited = false;

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
    }
  }

  void checkLevel(MATHLEVEL level) {
    if (title.compareTo('select_four_5'.tr) == 0) {
      isSkip = true;
    }
    switch (level) {
      case MATHLEVEL.EASY:
        textLevel = RxString('Easy');
        rangeRandom = 8;
        break;
      case MATHLEVEL.MEDIUM:
        textLevel = RxString('Medium');
        rangeRandom = 15;
        break;
      case MATHLEVEL.HARD:
        textLevel = RxString('Hard');
        rangeRandom = 22;
    }
  }

  void generateQuestion(int level, String route) {
    exponentsModel.value =
        exponentsModel.value.createRandomExponents(rangeRandom, 2);
    correctAnswer =
        exponentsModel.value.calculateExponent(exponentsModel.value);
    currentOptions.clear();
    currentOptions.add(correctAnswer);
    print('ex1:${exponentsModel.value.base}');
    print('ex2:${exponentsModel.value.exponent}');
    print('num1 is: $correctAnswer');

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
