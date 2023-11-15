import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerModel {
  int id;
  int correctAnswer;
  int wrongAnswer;
  Rx<bool> isEnable;
  String? result = '';
  Rx<Map<int, Color>> answerColors = Rx<Map<int, Color>>(<int, Color>{});

  PlayerModel({
    required this.id,
    required this.correctAnswer,
    required this.wrongAnswer,
    required this.isEnable,
    this.result,
    Map<int, Color>? answerColors,
  }) {
    this.answerColors.value = answerColors ?? <int, Color>{};
    isEnable = Rx<bool>(true);
  }
  // toJson answerColors
  
 
}
