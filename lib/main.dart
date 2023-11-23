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
import 'core/di_container.dart' as di;

DateTime? now;
Future<void> main() async {
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

  _setOrientation();

  runApp(const MyApp());
}

///
/// Set Device Orientation.
///
void _setOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
      builder: (context, index) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: GetMaterialApp(
            darkTheme: AppTheme.dark,
            initialRoute: AuthRouter.SPLASH,
            //  initialRoute: MainRouters.TEST,
            initialBinding: AppBinding(),
            locale: LocalizationService.locale,
            fallbackLocale: LocalizationService.fallbackLocale,
            translations: LocalizationService(),
            defaultTransition: Transition.leftToRight,
            transitionDuration: const Duration(),
            getPages: AppPages.list,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(backgroundColor: Colors.black),
            localizationsDelegates: localizationsDelegates,
            supportedLocales: LocalizationService.locales,
            builder: EasyLoading.init(
              builder: (context, widget) {
                return Theme(
                  data: darkTheme,
                  child: MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: 1.0,
                      boldText: false,
                    ),
                    child: widget!,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
