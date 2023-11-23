import 'dart:math';

import 'package:template/core/shared_pref/constants/enum_helper.dart';

class ExponentsModel {
  int base;
  int exponent;
  ExponentsModel({required this.base, required this.exponent});
  // random exponents number
  ExponentsModel createRandomExponents(
      int level, int levelAdd, int exponentRandom) {
    final Random random = Random();
    base = random.nextInt(level) + levelAdd;
    // tỉ lệ 1/2 để random số mũ là 1 hoặc 2
    // cấp độ khó random k có số mũ 1
    if (levelAdd == MathLevelValueMin.HARD_VALUE_EX_BASE) {
      exponent = random.nextInt(exponentRandom) + 2;
    }
    exponent = random.nextInt(exponentRandom) + 1;

    // tăng tỉ lệ random để không bị trùng số mũ nhiều
    return ExponentsModel(base: base, exponent: exponent);
  }

  // tinh ket qua phep luy thua trả về 1 số
  int calculateExponent(ExponentsModel exponentsModel) {
    return pow(exponentsModel.base, exponentsModel.exponent).toInt();
  }
}
