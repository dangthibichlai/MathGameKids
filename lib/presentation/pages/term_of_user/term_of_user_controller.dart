import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/repositories/setting_repositories.dart';

class TermOfUserController extends GetxController with WidgetsBindingObserver {
  ///
  /// Declare the API.
  final SettingRepository _settingRepository = GetIt.I.get<SettingRepository>();
  final KeyValidateAds _keyValidateAds = GetIt.I.get<KeyValidateAds>();

  /// Declare the data.
  RxString termValue = ''.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    // Call API get term.
    _calAPIGetTerm();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);

    termValue.close();
    super.onClose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      _keyValidateAds.setIsShowingAdsAward(value: false);
    }

    if (state == AppLifecycleState.inactive) {
      _keyValidateAds.setIsShowingAdsAward(value: true);
    }
  }

  ///
  /// Call API get term.
  ///
  void _calAPIGetTerm() {
    _settingRepository.getPolicyTerms(
      onSuccess: (data) {
        termValue.value = data.termsOfServices.toString();
      },
      onError: (e) {
        log('Error get term at $e');
      },
    );
  }
}
