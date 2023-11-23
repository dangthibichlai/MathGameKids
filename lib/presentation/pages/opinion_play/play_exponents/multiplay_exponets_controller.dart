import 'package:get/get.dart';
import 'dart:math';

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/presentation/pages/opinion_play/play_multiplayer/player_model.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

import '../../../../core/utils/color_resources.dart';
import 'exponents_model.dart';

class MultiExponentsController extends GetxController with SingleGetTickerProviderMixin {
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
  RxDouble progress = 0.0.obs;
  bool isScreenExited = false;
  late AnimationController animationController;
  late Animation<double> animation;
  String resultPlay = '';
  final sound = Get.find<SoundController>();
  int levelAdd = 1;
  int exponentRandom = 1;
  Rx<PlayerModel> player1 = PlayerModel(
    id: 1,
    correctAnswer: 0,
    wrongAnswer: 0,
    isEnable: false.obs,
    answerColors: <int, Color>{}.obs,
  ).obs;
  Rx<PlayerModel> player2 = PlayerModel(
    id: 2,
    correctAnswer: 0,
    wrongAnswer: 0,
    isEnable: false.obs,
    answerColors: <int, Color>{}.obs,
  ).obs;
// multi

  @override
  void onInit() {
    super.onInit();
    // textLevel = RxString(level.name);
    checkLevel(level);
    print(level.name);
    print('route is: ${level.name}');
    generateQuestion(rangeRandom, route);
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();

    animation.addListener(() {
      if (isScreenExited) {
        animationController.stop();
      }
      progress.value = animation.value;
      if (animation.isCompleted) {
        count.value++;
        if (count.value > 10) {
          //Nếu đã bỏ qua câu hỏi thứ 10, chuyển đến trang kết quả
          checkAware(player1.value, player2.value);
          if (Get.isRegistered<SoundController>()) {
            sound.closeSoundGame();
            sound.continueBackgroundSound();
          }
          Get.offNamed(MainRouters.RESULTEPONENTS, arguments: {
            'player1': player1.value,
            'player2': player2.value,
            'oldArguments': arguments,
          });
          //   ExtendBackAds.showAdsCompleteGame();
          count = 1.obs;
        } else {
          generateQuestion(rangeRandom, route);
          progress.value = 0;
          animationController.reset();
          animationController.forward();
        }
      }
    });
  }

  @override
  void onClose() {
    // close các controller
    countWrong.close();
    countCorrect.close();
    countSkip.close();
    currentOptions.close();
    progress.close();
    player1.close();
    player2.close();
    exponentsModel.close();
    textLevel.close();
    answerColors.close();
    animationController.dispose();
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

  void checkLevel(MATHLEVEL level) {
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

    final Random random = Random();
    exponentsModel.value.base = random.nextInt(level) + levelAdd;
    // tỉ lệ 1/2 để random số mũ là 1 hoặc 2
    // cấp độ khó random k có số mũ 1
    if (textLevel.value.compareTo('hard'.tr) == 0) {
      ex.exponent = random.nextInt(exponentRandom) + 2;
    } else {
      ex.exponent = random.nextInt(exponentRandom) + 1;
    }

    // tăng tỉ lệ random để không bị trùng số mũ nhiều
    ExponentsModel(base: ex.base, exponent: ex.exponent);
    correctAnswer = exponentsModel.value.calculateExponent(exponentsModel.value);
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

  void resestProgress() {
    progress.value = 0;
    player1.value.isEnable.value = true;
    player2.value.isEnable.value = true;
    animationController.reset();
    animationController.forward();
    // resest màu cho tất cả các button
    player1.value.answerColors.value = {};
    player2.value.answerColors.value = {};
  }

  void checkMultiAnswer(int selectedAnswer, int index, PlayerModel player) {
    if (selectedAnswer == correctAnswer) {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerTrueSound();
      }
      player1.value.isEnable.value = false;
      player2.value.isEnable.value = false;
      player.correctAnswer++;
      player.answerColors.value[index] = ColorResources.GREEN;
      // chuyển  câu hỏi
      Future.delayed(const Duration(milliseconds: 500), () {
        // clear màu
        player.answerColors.value[index] = ColorResources.BD_BT_ANSWER;
        player1.value.isEnable.value = true;
        player2.value.isEnable.value = true;

        resestProgress();
        if (count.value >= 10) {
          print('oke1');
          checkAware(player1.value, player2.value);
          if (Get.isRegistered<SoundController>()) {
            sound.closeSoundGame();
            sound.continueBackgroundSound();
          }
          Get.offNamed(MainRouters.RESULTEPONENTS, arguments: {
            'player1': player1.value,
            'player2': player2.value,
            'oldArguments': arguments,
          });
          return;
        }
        count.value++;
        generateQuestion(rangeRandom, route);
      });
    } else {
      if (Get.isRegistered<SoundController>()) {
        Get.find<SoundController>().playAnswerFalseSound();
      }
      // ignore: unnecessary_statements
      player.wrongAnswer++;
      // enable các button
      player.isEnable.value = false;
      if (player1.value.isEnable.value == false && player2.value.isEnable.value == false) {
        final int index = currentOptions.indexOf(correctAnswer);
        player1.value.answerColors.value[index] = ColorResources.GREEN;
        player2.value.answerColors.value[index] = ColorResources.GREEN;
        print('index is: $index');
        print('Player1:');
        print(player1.value.answerColors.value);
        print('Player2:');
        print(player2.value.answerColors.value);

        Future.delayed(const Duration(milliseconds: 500), () {
          // clear màu
          player.answerColors.value[index] = ColorResources.BD_BT_ANSWER;

          player1.value.isEnable.value = true;
          player2.value.isEnable.value = true;
          player.answerColors.refresh();
          // reset màu cho tất cả các button

          animationController.reset();
          resestProgress();
          if (count.value >= 10) {
            onClose();
            checkAware(player1.value, player2.value);
            if (Get.isRegistered<SoundController>()) {
              sound.closeSoundGame();
              sound.continueBackgroundSound();
            }
            Get.offNamed(MainRouters.RESULTEPONENTS, arguments: {
              'player1': player1.value,
              'player2': player2.value,
              'oldArguments': arguments,
            });
          }
          count.value++;
          generateQuestion(rangeRandom, route);
        });
      }
    }
  }

  void checkAware(PlayerModel play1, PlayerModel play2) {
    print('play1 is: ${play1.correctAnswer}');
    if (play1.correctAnswer > play2.correctAnswer) {
      player1.value.result = 'You Won'.tr;
      player2.value.result = 'You Lose'.tr;
    } else if (play1.correctAnswer < play2.correctAnswer) {
      player2.value.result = 'You Won'.tr;
      player1.value.result = 'You Lose'.tr;
    } else {
      player1.value.result = 'Tie'.tr;
      player2.value.result = 'Tie'.tr;
    }
  }

  void resetGame() {
    count.value = 1;
    countWrong.value = 0;
    countCorrect.value = 0;
    countSkip.value = 0;

    player1.value.correctAnswer = 0;
    player2.value.correctAnswer = 0;
    player1.value.wrongAnswer = 0;
    player2.value.wrongAnswer = 0;
    player1.value.isEnable.value = true;
    player2.value.isEnable.value = true;
    currentOptions.clear();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
    if (isScreenExited) {
      animationController.stop();
    }
    generateQuestion(rangeRandom, route);
  }
}
