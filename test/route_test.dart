// ignore_for_file: unused_local_variable, prefer_final_locals
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/core/helper/izi_timezone.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/data/repositories/auth_repositories.dart';
import 'package:mockito/mockito.dart';
import 'package:template/core/di_container.dart' as di;
import 'package:template/main.dart';
import 'package:template/presentation/pages/begin_screen/onboarding/onboarding_controller.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() async {
  // ignore: await_only_futures
  // await WidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

  await di.init(); // dùng để khởi tạo các service, repository, controller
  SharedPreferences.setMockInitialValues({});

  // Initialize mobile ads.
  MobileAds.instance.initialize();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));

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

  PackageDescriptionController packageDescriptionController;
  PageController _pageController;
  AuthRepository authRepository = GetIt.instance<AuthRepository>();
  SharedPreferences sharedPreferences = GetIt.instance<SharedPreferences>();

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    sharedPreferences = GetIt.instance<SharedPreferences>();

    SharedPreferences.setMockInitialValues({});
    packageDescriptionController = PackageDescriptionController();
    _pageController = PageController();
    authRepository = GetIt.instance<AuthRepository>();
  });

  testWidgets('Splash screen navigates to introduce screen', (WidgetTester tester) async {
    final authRepository = MockAuthRepository();

    await tester.pumpWidget(const MyApp());

    await tester.pump(const Duration(seconds: 2));

    // Check for a widget that is present in the introduce screen
    expect(find.text('TextInIntroduceScreen'), findsOneWidget);
    expect(1, 1);
  });
}
