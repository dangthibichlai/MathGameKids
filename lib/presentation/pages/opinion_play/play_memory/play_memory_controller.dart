// ignore_for_file: parameter_assignments

import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

import '../../../../core/utils/color_resources.dart';
import 'ui_model/title_model.dart';

class PlayMemoryController extends GetxController
    implements DisposableInterface {
  RxString currentQuestion = "5 + 8 ".obs;
  List<Tile> questions = [];
  List<Tile> answers = [];
  RxList<bool> flippedStatuses = List<bool>.filled(24, false).obs;
  RxList<bool> matchedStatuses = List<bool>.filled(24, false).obs;
  int previousIndex = -1;
  RxBool isProcessing = false.obs;
  RxBool isCorrect = false.obs;
  RxInt count = 1.obs;
  RxInt countWrong = 0.obs;
  RxInt countCorrect = 0.obs;
  RxInt countSkip = 0.obs;
  final Map<String, dynamic> arguments = Get.arguments;
  MATHLEVEL level = Get.arguments['level'];
  String route = Get.arguments['route'];
  String title = Get.arguments['title'];
  int rangeRandom = 10;
  int correctAnswer = 13;
  int levelAdd = 1;
  RxString textLevel = ''.obs;
  RxList<Tile> listGrid = <Tile>[].obs;
  RxBool isVisible = true.obs;
  RxBool isDone = false.obs;
  bool isDisposed = false;
  final sound = Get.find<SoundController>();
  final isRegistered = Get.isRegistered<SoundController>();

  @override
  void onClose() {
    super.onClose();
    count.close();
    countWrong.close();
    countCorrect.close();
    countSkip.close();
    currentQuestion.close();
    flippedStatuses.close();
    matchedStatuses.close();
    isProcessing.close();
    isCorrect.close();
    isVisible.close();
    isDone.close();
    listGrid.close();
    isDisposed = true;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    checkLevel(level);
    generateQuestion(rangeRandom, route);
    previousIndex = -1;
    isProcessing.value = false;
    hideTextAfterDelay();

    // Lật tất cả các ô trong listGrid trong 5s nếu là cấp độ dễ
    if (level == MATHLEVEL.EASY) {
      for (int i = 0; i < listGrid.length; i++) {
        listGrid[i].isFlipped = true;
        listGrid.refresh();
      }
      await Future.delayed(const Duration(seconds: 4), () {
        for (int i = 0; i < listGrid.length; i++) {
          listGrid[i].isFlipped = false;
          listGrid.refresh();
        }
      });
    }
  }

  void hideTextAfterDelay() {
    // nếu không phải cấp thì ẩn luôn text
    if (level != MATHLEVEL.EASY) {
      isVisible.value = false;
      return;
    }
    Timer(const Duration(seconds: 6), () {
      isVisible.value = false;
    });
  }

  void checkLevel(MATHLEVEL level) {
    switch (level) {
      case MATHLEVEL.EASY:
        textLevel = RxString('easy'.tr);
        rangeRandom = MathLevelValueMax.EASY_VALUE;
        levelAdd = MathLevelValueMin.EASY_VALUE_ADD;

        break;
      case MATHLEVEL.MEDIUM:
        textLevel = RxString('medium'.tr);
        rangeRandom = MathLevelValueMax.MEDIUM_VALUE;
        levelAdd = MathLevelValueMin.MEDIUM_VALUE_ADD;

        break;
      case MATHLEVEL.HARD:
        textLevel = RxString('hard'.tr);
        rangeRandom = MathLevelValueMax.HARD_VALUE;
        levelAdd = MathLevelValueMin.HARD_VALUE_ADD;
        break;
    }
  }

  void generateQuestion(int level, String route) {
    final Random random = Random();
    String routeOperation = '';

    for (int i = 0; i < 6; i++) {
      int num1 = random.nextInt(level) + levelAdd;
      int num2 = random.nextInt(level) + levelAdd;
      print('num1 is: $num1');
      print('num1 is: $num2');
      switch (route) {
        case MainRouters.ADDITION:
          routeOperation = '+';
          correctAnswer = num1 + num2;
          break;
        case MainRouters.SUBTRACTION:
          routeOperation = '-';
          while (num1 < num2) {
            num1 = random.nextInt(level) + levelAdd;
            num2 = random.nextInt(level) + levelAdd;
          }
          correctAnswer = num1 - num2;
          break;
        case MainRouters.MULTIPLICATION:
          routeOperation = 'x';
          if (level == MathLevelValueMax.HARD_VALUE) {
            level = MathLevelValueMax.HARD_VALUE_MUL;
            levelAdd = MathLevelValueMin.HARD_VALUE_MUL_ADD;
          } else if (level == MathLevelValueMax.MEDIUM_VALUE) {
            level = MathLevelValueMax.MEDIUM_VALUE_MUL;
            levelAdd = MathLevelValueMin.MEDIUM_VALUE_MUL_ADD;
          }
          num1 = random.nextInt(level) + levelAdd;
          num2 = random.nextInt(level) + levelAdd;
          correctAnswer = num1 * num2;
          break;
        case MainRouters.DIVISION:
          routeOperation = '/';
          while (num1 % num2 != 0 || num1 == num2) {
            num1 = random.nextInt(level) + levelAdd;
            num2 = random.nextInt(level) + levelAdd;
          }
          correctAnswer = num1 ~/ num2;
          break;
      }
      listGrid.add(Tile(
        expression: '$num1 $routeOperation $num2  ',
        result: correctAnswer,
        isFlipped: false,
      ));
      listGrid.add(Tile(
        expression: correctAnswer.toString(),
        result: correctAnswer,
        isFlipped: false,
      ));
      listGrid.shuffle();
    }
  }

  Future<void> flipTile(int index) async {
    if (isProcessing.value) {
      return;
    }
    if (listGrid[index].isFlipped ?? false) {
      return;
    }

    /// Thực hiện hành động khi lật ô thứ index trong listGrid
    if (previousIndex == -1) {
      previousIndex = index;
      listGrid[index].isFlipped = true;
      listGrid.refresh();
      if (isRegistered) {
        sound.playClickGameSound();
      }
    } else {
      /// Nếu đã có ô được lật trước đó

      listGrid[index].isFlipped = true;
      listGrid.refresh();

      /// Nếu ô hiện tại và ô trước đó có cùng kết quả
      if (listGrid[index].result == listGrid[previousIndex].result) {
        // hiện âm thanh đúng
        if (isRegistered) {
          sound.playAnswerTrueSound();
        }
        listGrid[index].isMatched = true;
        listGrid[previousIndex].isMatched = true;
        countCorrect.value++;
        isCorrect.value = true;
        listGrid[index].color =
            ColorResources.GREEN; // Gán màu nền mới cho ô thứ index
        listGrid[previousIndex].color = ColorResources.GREEN;
        listGrid.refresh();

        /// Nếu tất cả các ô đều đã được lật và khớp
        if (countCorrect.value == listGrid.length ~/ 2) {
          isDone.value = true;
          // delay 1s để hiện ads
          await Future.delayed(const Duration(seconds: 1), () {
            ExtendBackAds.showAdsCompleteGame();
          });
          listGrid.refresh();
        }
      } else {
        /// Nếu ô hiện tại và ô trước đó không khớp
        ///
        if (isRegistered) {
          sound.playAnswerFalseSound();
        }
        isProcessing.value = true;
        countWrong.value++;
        listGrid.refresh();

        await Future.delayed(const Duration(seconds: 1), () {
          print('delay');
          listGrid[index].isFlipped = false;
          print('index is: $index');
          print('previousIndex: $previousIndex');
          listGrid[previousIndex].isFlipped = false;
          isProcessing.value = false;
          // previousIndex = -1;
          listGrid.refresh();
        });
      }

      previousIndex = -1;
    }

    listGrid.refresh();
  }

  void reset() {
    // Các bước đặt lại trạng thái khác
    currentQuestion.value = "5 + 8 ";
    questions.clear();
    answers.clear();
    flippedStatuses = List<bool>.filled(24, false).obs;
    matchedStatuses = List<bool>.filled(24, false).obs;
    previousIndex = -1;
    isProcessing.value = false;
    isCorrect.value = false;
    count.value = 1;
    countWrong.value = 0;
    countCorrect.value = 0;
    countSkip.value = 0;
    isVisible.value = true;
    isDone.value = false;
    listGrid.clear();
    dispose();
  }
}
