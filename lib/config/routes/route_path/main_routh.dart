import 'package:get/get.dart';
import 'package:template/presentation/pages/Mutiplication/multiplication_binding.dart';
import 'package:template/presentation/pages/Mutiplication/multiplication_page.dart';

import 'package:template/presentation/pages/addition/addition_binding.dart/addition_binding.dart';
import 'package:template/presentation/pages/addition/addition_page.dart';
import 'package:template/presentation/pages/algebra/algebra_page.dart';
import 'package:template/presentation/pages/algebra/algebral_binding.dart';
import 'package:template/presentation/pages/decimals/decimal_binding.dart';
import 'package:template/presentation/pages/decimals/decimal_page.dart';
import 'package:template/presentation/pages/division/division_binding.dart';
import 'package:template/presentation/pages/division/division_page.dart';
import 'package:template/presentation/pages/exponents/exponents_binding.dart';
import 'package:template/presentation/pages/exponents/exponents_page.dart';
import 'package:template/presentation/pages/fraction/fraction_binding.dart';
import 'package:template/presentation/pages/fraction/fraction_page.dart';
import 'package:template/presentation/pages/home/home_binding.dart';
import 'package:template/presentation/pages/home/home_page.dart';
import 'package:template/presentation/pages/opinion_play/play_algebra/play_algebra_binding.dart';
import 'package:template/presentation/pages/opinion_play/play_algebra/play_algebra_page.dart';
import 'package:template/presentation/pages/opinion_play/play_deciamal/decimal_multi_page.dart';
import 'package:template/presentation/pages/opinion_play/play_deciamal/play_decimal_binding.dart';
import 'package:template/presentation/pages/opinion_play/play_deciamal/play_decimal_page.dart';
import 'package:template/presentation/pages/opinion_play/play_deciamal/result_decimal.dart';
import 'package:template/presentation/pages/opinion_play/play_deciamal/result_decimal_bingding.dart';
import 'package:template/presentation/pages/opinion_play/play_exponents/exponent_multi_page.dart';
import 'package:template/presentation/pages/opinion_play/play_exponents/play_exponents_binding.dart';
import 'package:template/presentation/pages/opinion_play/play_exponents/play_exponents_page.dart';
import 'package:template/presentation/pages/opinion_play/play_exponents/result_exponents.dart';
import 'package:template/presentation/pages/opinion_play/play_long_addition/play_long_addition_binding.dart';
import 'package:template/presentation/pages/opinion_play/play_long_addition/play_long_addition_page.dart';
import 'package:template/presentation/pages/opinion_play/play_memory/play_memory_binding.dart';
import 'package:template/presentation/pages/opinion_play/play_memory/play_memory_page.dart';
import 'package:template/presentation/pages/opinion_play/play_mising_number/play_mising_binding.dart';
import 'package:template/presentation/pages/opinion_play/play_mising_number/play_missing_page.dart';
import 'package:template/presentation/pages/opinion_play/play_multiplayer/play_multiplyer_page.dart';
import 'package:template/presentation/pages/opinion_play/play_multiplayer/play_multuplayer_binding.dart';
import 'package:template/presentation/pages/opinion_play/play_multiplayer/result_multiplayer.dart';
import 'package:template/presentation/pages/opinion_play/play_practice/play_practice_binding.dart';
import 'package:template/presentation/pages/opinion_play/play_practice/play_practice_page.dart';
import 'package:template/presentation/pages/opinion_play/play_quiz/play_quiz_binding.dart';
import 'package:template/presentation/pages/opinion_play/play_quiz/play_quiz_page.dart';
import 'package:template/presentation/pages/opinion_play/play_square_root/play_square_binding.dart';
import 'package:template/presentation/pages/opinion_play/play_square_root/play_square_root_page.dart';
import 'package:template/presentation/pages/opinion_play/play_square_root/result_square_root.dart';
import 'package:template/presentation/pages/opinion_play/play_square_root/square_root_multi.dart';
import 'package:template/presentation/pages/opinion_play/play_time_challenge/play_time_challege_binding.dart';
import 'package:template/presentation/pages/opinion_play/play_time_challenge/play_time_challenge_page.dart';
import 'package:template/presentation/pages/opinion_play/play_true_false/play_true_false_binding.dart';
import 'package:template/presentation/pages/opinion_play/play_true_false/play_true_false_page.dart';
import 'package:template/presentation/pages/opinion_play/play_fractice/play_fractice_page.dart';
import 'package:template/presentation/pages/result_package/result_binding.dart';
import 'package:template/presentation/pages/result_package/result_page.dart';
import 'package:template/presentation/pages/setting_package/setting_binding.dart';
import 'package:template/presentation/pages/setting_package/setting_page.dart';

import 'package:template/presentation/pages/spuareroot/spuareroot_binding.dart';
import 'package:template/presentation/pages/spuareroot/spuareroot_page.dart';
import 'package:template/presentation/pages/subtraction/subtraction_binding.dart';
import 'package:template/presentation/pages/subtraction/subtraction_page.dart';
import 'package:template/presentation/pages/test.dart';

import '../../../presentation/pages/opinion_play/play_fractice/play_fractice_binding.dart';

mixin MainRouters {
  static const String ADDITION = '/addition';
  static const String SUBTRACTION = '/subtraction';
  static const String DIVISION = '/division';
  static const String MULTIPLICATION = '/multiplication';
  static const String PRACTION = '/fraction';
  static const String DECIMAL = '/decimal';
  static const String EXPONENTS = '/expoents';
  static const String SQUARE_ROOTS = '/square_roots';
  static const String ALGEBRA = '/algebra';
  static const String PLAYPAGEPRACTICE = '/play_practice';
  static const String RESULT = '/result';
  static const String PLAYALGEBRA = '/play_algebra';
  static const String SETTING = '/setting';
  static const String TEST = '/test';
  static const String HOME = '/home';
  static const String PRACTICE = '/play_practice';
  static const String QUIZ = '/play_quiz';
  static const String TIMECHALLENGE = '/play_time_challenge';
  static const String MISSINGNUMBER = '/play_missing_number';
  static const String MULTIPLAYER = '/play_multiplayer';
  static const String TRUEFALSE = '/play_true_false';
  static const String LONGADDITION = '/long_addition';
  static const String MEMMORY = '/play_memory';
  static const String FRACTICE_PLAY = '/practice_play';
  static const String MULTIPLAYER_RESULT = '/multiplayer_result';
  static const String PLAYDECIMAL = '/play_decimal';
  static const String PLAYEXPONENTS = '/play_exponents';
  static const String PLAYDECIMALMULTI = '/play_decimal_multi';
  static const String RESULTDECIMAL = '/result_decimal';
  static const String MULTIEXPONETS = '/multi_exponents';
  static const String RESULTEPONENTS = '/result_exponents';
  static const String PLAYSQUAREROOT = '/play_squareroot';
  static const String MULTISQUARE = '/multi_square';
  static const String RESULTMULTISQUARE = '/result_multi_square';

  static List<GetPage> listPage = [
    GetPage(
      name: TEST,
      page: () => const InAppReviewExampleApp(),

      // binding: AlgebraBinding(),
    ),
    GetPage(
      name: RESULTMULTISQUARE,
      page: () => const ResultSquarePage(),
      binding: ResultDecimalBinding(),
    ),
    GetPage(
      name: RESULTEPONENTS,
      page: () => const ResulExponentsPage(),
      binding: ResultDecimalBinding(),
    ),
    GetPage(
      name: MULTISQUARE,
      page: () => const SquareRootMultiPage(),
      binding: PlaySquareRootBinding(),
    ),
    GetPage(
      name: PLAYSQUAREROOT,
      page: () => const PlaySquareRoot(),
      binding: PlaySquareRootBinding(),
    ),
    GetPage(
      name: MULTIEXPONETS,
      page: () => const ExponentMultiPage(),
      binding: PlayExponentsBinding(),
    ),
    GetPage(
      name: RESULTDECIMAL,
      page: () => const ResultDecilmalPage(),
      binding: ResultDecimalBinding(),
    ),
    // GetPage(
    //   name: PLAYMULTI_RESULT,
    //   page: () => const ResultMultiPlayerPage(),
    //   binding: ResultDecimalBinding(),
    // ),
    GetPage(
      name: PLAYDECIMALMULTI,
      page: () => const DecimalMultiPage(),
      binding: PlayDecimalBinding(),
    ),
    GetPage(
      name: PLAYEXPONENTS,
      page: () => const PlayExponentsPage(),
      binding: PlayExponentsBinding(),
    ),
    GetPage(
      name: PLAYDECIMAL,
      page: () => PlayDecimalPage(),
      binding: PlayDecimalBinding(),
    ),
    GetPage(
      name: PLAYALGEBRA,
      page: () => PlayAlgebraPage(),
      binding: PlayAlgebraBinding(),
    ),
    GetPage(
      name: MULTIPLAYER_RESULT,
      page: () => const ResultMultiPlayerPage(),
      binding: ResultDecimalBinding(),
    ),
    GetPage(
      name: HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: ADDITION,
      page: () => const AdditonPage(),
      binding: AdditionBinding(),
    ),
    GetPage(
      name: SUBTRACTION,
      page: () => const SubtractionPage(),
      binding: SubtractionBinding(),
    ),
    GetPage(
      name: MULTIPLICATION,
      page: () => const MutiplicationPage(),
      binding: MutiplicationBinding(),
    ),
    GetPage(
      name: DIVISION,
      page: () => const DivisionPage(),
      binding: DivisionBinding(),
    ),
    GetPage(
      name: PRACTION,
      page: () => const FractionPage(),
      binding: FractionBinding(),
    ),
    GetPage(
      name: DECIMAL,
      page: () => const DecimalPage(),
      binding: DecimalBinding(),
    ),
    GetPage(
      name: EXPONENTS,
      page: () => const ExponentsPage(),
      binding: ExponentsBinding(),
    ),
    GetPage(
      name: SQUARE_ROOTS,
      page: () => const SpuarerootPage(),
      binding: SpuarerootBinding(),
    ),
    GetPage(
      name: ALGEBRA,
      page: () => AlgebraPage(),
      binding: AlgebraBinding(),
    ),
    GetPage(
      name: RESULT,
      page: () => const ResultPage(),
      binding: ResultBinding(),
    ),
    GetPage(
      name: SETTING,
      page: () => const SettingPage(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: PRACTICE,
      page: () => PlayPracticePage(),
      binding: PlayPracticeBinding(),
    ),
    GetPage(
      name: QUIZ,
      page: () => PlayQuiz(),
      binding: PlayQiuzBinding(),
    ),
    GetPage(
      name: MULTIPLAYER,
      page: () => MultiplayerPage(),
      binding: MultiplayerBinding(),
    ),
    GetPage(
      name: TIMECHALLENGE,
      page: () => PlayTimeChallengePage(),
      binding: PlayTimeChallengeBinding(),
    ),
    GetPage(
      name: MISSINGNUMBER,
      page: () => PlayMissingNumberPage(),
      binding: PlayMissingNumberBinding(),
    ),
    GetPage(
      name: TRUEFALSE,
      page: () => PlayTrueFalsePage(),
      binding: PlayTrueFalseBinding(),
    ),
    GetPage(
      name: LONGADDITION,
      page: () => const PlayLongAdditionPage(),
      binding: PlayLongAdditionBinding(),
    ),
    GetPage(
      name: MEMMORY,
      page: () => PlayMemoryPage(),
      binding: PlayMemoryBinding(),
    ),
    GetPage(
      name: FRACTICE_PLAY,
      page: () => PlayFracticePage(),
      binding: PlayFracticeBinding(),
    ),
  ];
}
