import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/di_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/utils/color_resources.dart';

import 'package:template/main.dart';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/config/routes/route_path/auth_routh.dart';


void main() {
  setUp(() async {
      SharedPreferences.setMockInitialValues({});
      Get.testMode = true;

      WidgetsFlutterBinding.ensureInitialized();

      await di.init(); // dùng để khởi tạo các service, repository, controller

      // Initialize mobile ads.
    // MobileAds.instance.initialize();

      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));

    // time_ago.setLocaleMessages('vi', time_ago.ViMessages());

    // IZITimeZone().initializeTimeZones();

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
    final BuildContext mockContext = widgetTester.element(widgetToFind);
      final getScreenUtilUnit =
          widgetTester.widget<ScreenUtilInit>(widgetToFind);
    final getGestureDetector =
        getScreenUtilUnit.builder!(mockContext, null) as GestureDetector;
    final getMaterialApp = getGestureDetector.child as GetMaterialApp;
    expect(getMaterialApp.initialRoute, AuthRouter.SPLASH);
  });

  testWidgets("routing to home when it not first run", (widgetTester) async {
    sl<SharedPreferenceHelper>().setSplash(status: true);
    var i = sl<SharedPreferenceHelper>().getSplash;

    await widgetTester.pumpWidget(const MyApp());
    await widgetTester.pumpAndSettle();

    final currentRoute = Get.routing.current;

    expect(currentRoute, MainRouters.HOME);
    });

    testWidgets("Checking in splash is not routing to homepage in first run",
        (widgetTester) async {
    // sl<SharedPreferenceHelper>().setSplash(status: false);

    await widgetTester.pumpWidget(const MyApp());
    await widgetTester.pumpAndSettle();

    final currentRoute = Get.routing.current;

    expect(currentRoute, AuthRouter.CHOOSE_LANGUAGE);
    });

  tearDown(() => {
        Get.reset(),
        GetIt.I.reset(),
      });
  
}
