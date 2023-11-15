import 'package:get/get.dart';
import 'package:template/presentation/pages/premium_package/bottom_premium_page.dart';
import 'package:template/presentation/pages/begin_screen/choose_language/choose_language_binding.dart';
import 'package:template/presentation/pages/begin_screen/choose_language/choose_language_page.dart';
import 'package:template/presentation/pages/begin_screen/onboarding/onboarding_page.dart';
import 'package:template/presentation/pages/begin_screen/splash/splash_page.dart';
import 'package:template/presentation/pages/premium_package/prenium_binding.dart';
import 'package:template/presentation/pages/premium_package/prenium_page.dart';

// ignore: avoid_classes_with_only_static_members
class AuthRouter {
  static const String SPLASH = '/splash';
  static const String CHOOSE_LANGUAGE = '/choose-language';
  static const String NEXTPAGE1 = '/next-page1';
  static const String PRENIUM = '/predium';
  static const String BOTTOMPRRE = '/bottompre';
  static List<GetPage> listPage = [
    GetPage(
      name: SPLASH,
      page: () => SplashPage(),
    ),
    GetPage(
      name: CHOOSE_LANGUAGE,
      page: () => const ChooseLanguagePage(),
      binding: ChooseLanguageBinding(),
    ),
    GetPage(
      name: NEXTPAGE1,
      page: () => const OnboardingPage(),
    ),
    GetPage(
      name: PRENIUM,
      page: () => PreniumPage(),
      binding: PreniumBinding(),
    ),
    GetPage(
      name: BOTTOMPRRE,
      page: () => const BottomPremiumPage(),
      //binding: PreniumBinding(),
    ),
  ];
}
