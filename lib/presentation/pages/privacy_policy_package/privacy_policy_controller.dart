import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/repositories/setting_repositories.dart';

class PrivacyPolicyController extends GetxController
    with WidgetsBindingObserver {
  ///
  /// Declare the API.
  final SettingRepository _settingRepository = GetIt.I.get<SettingRepository>();
  final KeyValidateAds _keyValidateAds = GetIt.I.get<KeyValidateAds>();

  /// Declare the data.
  RxString policyData = ''.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    // Call API get policy.
    _calAPIGetPolicy();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);

    policyData.close();
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
  /// Call API get policy.
  ///
  void _calAPIGetPolicy() {
    _settingRepository.getPolicyTerms(
      onSuccess: (data) {
        policyData.value = data.policy.toString();
      },
      onError: (e) {
        log('Error get term at $e');
      },
    );
  }
}
