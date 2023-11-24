enum MATHLEVEL { EASY, MEDIUM, HARD }

class MathLevelValueMax {
  static const int EASY_VALUE = 8;
  static const int MEDIUM_VALUE = 89;
  static const int HARD_VALUE = 500;
  // MULTIPLAY
  static const int EASY_VALUE__MUL = 8;
  static const int MEDIUM_VALUE_MUL = 15;
  static const int HARD_VALUE_MUL = 20;
// EXPONENTS
  static const int EASY_VALUE__EX = 8;
  static const int MEDIUM_VALUE_EX = 13;
  static const int HARD_VALUE_EX = 16;

  static const int EASY_VALUE_SQ = 5;
  static const int MEDIUM_VALUE_SQ = 10;
  static const int HARD_VALUE_SQ = 15;
//
  //
}

class MathLevelValueMin {
  static const int EASY_VALUE_ADD = 2;
  static const int MEDIUM_VALUE_ADD = 11;
  static const int HARD_VALUE_ADD = 101;

  static const int EASY_VALUE__MUL_ADD = 5;
  static const int MEDIUM_VALUE_MUL_ADD = 8;
  static const int HARD_VALUE_MUL_ADD = 10;

  /// expont
  ///
  static const int EASY_VALUE__EX_ADD = 2;
  static const int MEDIUM_VALUE_EX_ADD = 5;
  static const int HARD_VALUE_EX_ADD = 8;

  /// base expont ( khi dùng sẽ tăng lên 1 để tránh trường hợp 0^0)
  ///
  static const int EASY_VALUE_EX_BASE = 2;
  static const int MEDIUM_VALUE_EX_BASE = 3;
  static const int HARD_VALUE_EX_BASE = 2;
}
