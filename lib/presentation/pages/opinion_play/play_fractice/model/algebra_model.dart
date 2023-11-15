import 'dart:math';

class AlgebbraModel {
  int number1;
  int number2;
  int result;
  int positionHiden;
  AlgebbraModel(
      {required this.number1, required this.number2, required this.result, this.positionHiden = 0});
  void createRandomAlgebbra(int rangerRandom, int levelRandom) {
    final Random random = Random();
    number1 = random.nextInt(rangerRandom) + levelRandom;
    number2 = random.nextInt(rangerRandom) + levelRandom;
  }
  int getPositionHiden() {
    final Random random = Random();
    // ignore: join_return_with_assignment
    positionHiden = random.nextInt(4);
    return positionHiden;
  }
}
