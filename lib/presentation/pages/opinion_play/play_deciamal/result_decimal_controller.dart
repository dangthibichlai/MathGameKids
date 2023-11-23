// ignore_for_file: parameter_assignments

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/shared_pref/constants/enum_helper.dart';
import 'package:template/presentation/pages/opinion_play/extend_back_ads.dart';
import 'package:template/presentation/pages/opinion_play/play_multiplayer/player_model.dart';

class ResultDecimalController extends GetxController {
  final Map<String, dynamic> arguments = Get.arguments['oldArguments']; // bị trống
  MATHLEVEL level = MATHLEVEL.EASY;
  String route = "";
  String title = '';
  PlayerModel player1 = PlayerModel(
    id: 1,
    correctAnswer: 0,
    wrongAnswer: 0,
    isEnable: true.obs,
    answerColors: <int, Color>{},
  );
  PlayerModel player2 = PlayerModel(
    id: 2,
    correctAnswer: 0,
    wrongAnswer: 0,
    isEnable: true.obs,
    answerColors: <int, Color>{},
  );
  @override
  void onInit() {
    Future.delayed(const Duration(microseconds: 2000), () {
      ExtendBackAds.showAdsCompleteGame();
    });
    route = arguments['route'];
    title = arguments['title'];
    level = arguments['level'];

    getData();
    super.onInit();
  }

  void getData() {
    log('TechMind00 ${Get.arguments}');
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      log('TechMind01 ${Get.arguments}');
      player1 = Get.arguments['player1'];
      player2 = Get.arguments['player2'];
    }
  }

  void onClosed() {
    super.onClose();
  }
}
