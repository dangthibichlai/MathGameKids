import 'dart:math';

class ExponentsModel {
  int base;
  int exponent;
  ExponentsModel({required this.base, required this.exponent});
  // random exponents number
  ExponentsModel createRandomExponents(int level, int levelAdd) {
    final Random random = Random();
    base = random.nextInt(level) + levelAdd;
    exponent = random.nextInt(3) + 1;

    return ExponentsModel(base: base, exponent: exponent);
  }

  // tinh ket qua phep luy thua trả về 1 số
  int calculateExponent(ExponentsModel exponentsModel) {
    return pow(exponentsModel.base, exponentsModel.exponent).toInt();
  }
}
