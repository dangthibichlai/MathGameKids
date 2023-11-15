import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/config/routes/route_path/auth_routh.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';
import 'package:template/data/model/response/settings_model.dart';
import 'package:template/data/repositories/setting_repositories.dart';

import '../../../../core/services/google_admod_services/open_ads_manager/app_open_ads.dart';
import '../../../../data/data_source/dio/dio_client.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController? _animationController;
  final DioClient? dioClient = GetIt.I.get<DioClient>();
  final SettingRepository _settingRepository = GetIt.I.get<SettingRepository>();
  SettingsModel settingModel = SettingsModel();

  // Open ads when open add and resumed app.
  AppOpenAds appOpenAdManager = AppOpenAds();
  //final KeyValidateAds _keyValidateAds = GetIt.I.get<KeyValidateAds>();

  @override
  void onInit() {
    super.onInit();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    final _splash = sl<SharedPreferenceHelper>().getSplash;
    // final _logger = sl<SharedPreferenceHelper>().getLogger;
    final _premium = sl<SharedPreferenceHelper>().getPremium;

    // install _animationController
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    // check logged in or not.
    _animationController!.forward().whenComplete(
      () async {
        if (_splash) {
          if (_premium) {
            Get.toNamed(MainRouters.HOME);
            //_onLoginApp(isLogger: _logger);
          } else {
            // Load ads.
            appOpenAdManager.showOpenAppAds(
              onSuccess: () {
                Get.toNamed(MainRouters.HOME);
              },
              onError: () {
                Get.toNamed(AuthRouter.NEXTPAGE1);
              },
            );
          }
        } else {
          Get.offNamed(AuthRouter.CHOOSE_LANGUAGE);
        }
      },
    );
  }

  // void _onLoginApp({required bool isLogger}) {
  //   if (isLogger) {
  //     Get.toNamed(MainRouters.HOME);
  //   } else {
  //     Get.offNamed(AuthRouter.NEXTPAGE1);
  //   }
//  }

  /// lấy share link
  void getAppStoreLink() {
    _settingRepository.getSetting(
        filter: '/one?appType=A4_MATH',
        onSuccess: (data) {
          settingModel = data;
          sl<SharedPreferenceHelper>()
              .setLinkIos(data.linkShareIos ?? 'https://www.google.com.vn/');
          sl<SharedPreferenceHelper>().setLinkAndroid(
              data.linkShareAndroid ?? 'https://www.youtube.com/');
        },
        onError: (onError) {
          sl<SharedPreferenceHelper>()
              .setLinkIos(sl<SharedPreferenceHelper>().getLinkIos);
          sl<SharedPreferenceHelper>()
              .setLinkAndroid(sl<SharedPreferenceHelper>().getLinkAndroid);
        });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }
}
