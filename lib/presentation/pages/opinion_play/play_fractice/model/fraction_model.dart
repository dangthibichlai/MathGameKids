import 'dart:math';

class Fraction {
  int numerator;
  int denominator;

  Fraction(this.numerator, this.denominator);
  // hàm in ra màn hình
  @override
  String toString() {
    return '$numerator/$denominator';
  }

  Fraction operator +(Fraction other) {
    final int newDenominator = denominator * other.denominator;
    final int newNumerator =
        (numerator * other.denominator) + (other.numerator * denominator);

    return Fraction(newNumerator, newDenominator);
  }

  Fraction operator -(Fraction other) {
    final int newDenominator = denominator * other.denominator;
    final int newNumerator =
        (numerator * other.denominator) - (other.numerator * denominator);

    return Fraction(newNumerator, newDenominator);
  }

  Fraction operator *(Fraction other) {
    final int newDenominator = denominator * other.denominator;
    final int newNumerator = numerator * other.numerator;

    return Fraction(newNumerator, newDenominator);
  }

  Fraction operator /(Fraction other) {
    final int newDenominator = denominator * other.numerator;
    final int newNumerator = numerator * other.denominator;

    return Fraction(newNumerator, newDenominator);
  }

  Fraction createRandomFraction(int rangerRandom, int levelRandom) {
    final Random random = Random();
    final int numerator =
        random.nextInt(rangerRandom) + levelRandom; // Tử số từ 1 đến 10
    final int denominator =
        random.nextInt(levelRandom) + levelRandom; // Mẫu số từ 1 đến 10

    return Fraction(numerator, denominator);
  }

  // rút gọn phân số.
  int _gcd(int a, int b) {
    if (b == 0) {
      return a;
    }
    return _gcd(b, a % b);
  }

  Fraction simplify(int numerator, int denominator) {
    final int gcdValue = _gcd(numerator, denominator);
    print(gcdValue);
    return Fraction(numerator ~/ gcdValue, denominator ~/ gcdValue);
  }
}
