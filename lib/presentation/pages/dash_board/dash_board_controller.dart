// ignore_for_file: use_setters_to_change_properties

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/export/core_export.dart';

class DashBoardController extends GetxController with WidgetsBindingObserver {
  ///
  /// Declare the API.
  final KeyValidateAds _keyValidateAds = GetIt.I.get<KeyValidateAds>();
  final _sharedHelper = sl<SharedPreferenceHelper>();

  /// Declare the data.

  // Current index Dashboard.
  RxInt currentIndex = 0.obs;
  DateTime? currentBackPressTime;

  // Premium data.
  RxBool isPremium = false.obs;
  RxInt countMessageOfUser = 0.obs;

  RxString avatarUser = ImagesPath.loadingLogo.obs;

  // Open ads when open add and resumed app.
  AppOpenAds appOpenAdManager = AppOpenAds();

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addObserver(this);

    _checkUserHavePurchase();
    print('pre: ${_sharedHelper.getPremium}');
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);

    // Close stream.
    countMessageOfUser.close();
    isPremium.close();
    avatarUser.close();
    super.onClose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (!_keyValidateAds.isShowingAdsAward && !isPremium.value) {
        // Load ads.
        appOpenAdManager.showOpenAppAds(
          onSuccess: () {},
          onError: () {},
        );
      }
    }

    if (state == AppLifecycleState.paused) {
      _keyValidateAds.setIsShowingAdsAward(value: false);
    }

    log('TechMind $state&& Key ${_keyValidateAds.isShowingAdsAward}');
  }

  ///
  /// On change dashboard page.
  ///
  void onChangeDashboardPage({required int index}) {
    currentIndex.value = index;
  }

  ///
  /// Check exits app.
  ///
  Future<bool> onDoubleBack() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      IZIAlert().info(message: "Chat_026".tr);
      return Future.value(false);
    }
    return Future.value(true);
  }

  ///
  /// Check user have purchase.
  ///
  void _checkUserHavePurchase() {
    if (_sharedHelper.getPremium &&
        !IZIValidate.nullOrEmpty(_sharedHelper.getEndTimePremium) &&
        DateTime.parse(_sharedHelper.getEndTimePremium)
            .isAfter(DateTime.now())) {
      isPremium.value = true;

      // Set premium.
      sl<SharedPreferenceHelper>().setPremium(isPremium: isPremium.value);
    }
  }
}
