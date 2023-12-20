import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/di_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:template/core/utils/color_resources.dart';

import 'package:template/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:template/config/routes/route_path/auth_routh.dart';
import 'package:template/config/theme/dark_theme.dart';
import 'package:template/core/helper/izi_timezone.dart';
import 'package:template/core/services/multi_language_service/localization_service.dart';
import 'package:template/config/routes/app_pages.dart';
import 'package:template/config/theme/app_theme.dart';
import 'package:template/core/utils/app_constants.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/app_binding.dart';
import 'package:timeago/timeago.dart' as time_ago;

void main() {
  group('Check function for routing correct screen', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      Get.testMode = true;

      WidgetsFlutterBinding.ensureInitialized();

      await di.init(); // dùng để khởi tạo các service, repository, controller

      // Initialize mobile ads.
      MobileAds.instance.initialize();

      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));

      time_ago.setLocaleMessages('vi', time_ago.ViMessages());

      IZITimeZone().initializeTimeZones();

      EasyLoading.instance
        ..displayDuration = const Duration(milliseconds: 1500)
        ..indicatorType = EasyLoadingIndicatorType.fadingCircle
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..indicatorType = EasyLoadingIndicatorType.threeBounce
        ..progressColor = ColorResources.WHITE
        ..backgroundColor = ColorResources.PRIMARY_1
        ..indicatorColor = ColorResources.WHITE
        ..textColor = ColorResources.WHITE
        ..maskColor = Colors.transparent
        ..userInteractions = false
        ..textStyle = const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: ColorResources.WHITE,
        )
        ..dismissOnTap = false;
    });

    testWidgets("Checking - Is Splash in first loading", (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp(), const Duration(seconds: 0));
      final widgetToFind = find.byType(ScreenUtilInit);
      expect(widgetToFind, findsOneWidget);
      final getScreenUtilUnit =
          widgetTester.widget(widgetToFind) as ScreenUtilInit;
      final getMaterialApp = getScreenUtilUnit.builder;

      expect(getMaterialApp.hashCode, AuthRouter.SPLASH);
    });

    testWidgets("Checking in splash is not routing to homepage in first run",
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp());
      await widgetTester.pumpAndSettle();
      final widgetToFind = find.byType(BaseAppBar);
      expect(widgetToFind, findsOneWidget);
      final baseAppBar = widgetTester.widget(widgetToFind) as BaseAppBar;
      expect(baseAppBar.title, "Chọn ngôn ngữ");
    });
  });
}
