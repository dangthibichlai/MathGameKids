import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/di_container.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';

import '../../../core/export/core_export.dart';

// ignore: deprecated_member_use
class HomeController extends GetxController
    // ignore: deprecated_member_use
    with
        SingleGetTickerProviderMixin,
        WidgetsBindingObserver {
// viết hàm rung ảnh ở đây: truyền vào ảnh cần rung
  late AnimationController _animationController;
  AppOpenAds appOpenAdManager = AppOpenAds();
  RxBool isPremium = false.obs;

  // tạo danh sách chứa  các nút có ở trang home để đổ vào gridview ở trang home và truyền vào các tham số cần thiết
  List<Map<String, dynamic>> listButton = [
    {
      'title': ImagesPath.addIcon,
      'color': ColorResources.HOME_BG_1,
      'borderColor': ColorResources.HOME_BD_1,
      'routerPage': MainRouters.ADDITION,
    },
    {
      'title': ImagesPath.subtraction,
      'color': ColorResources.HOME_BG_2,
      'borderColor': ColorResources.HOME_BD_2,
      'routerPage': MainRouters.SUBTRACTION,
    },
    {
      'title': ImagesPath.multiplyIcon,
      'color': ColorResources.HOME_BG_3,
      'borderColor': ColorResources.HOME_BD_3,
      'routerPage': MainRouters.MULTIPLICATION,
    },
    {
      'title': ImagesPath.division,
      'color': ColorResources.HOME_BG_4,
      'borderColor': ColorResources.HOME_BD_4,
      'routerPage': MainRouters.DIVISION,
    },
    {
      'title': ImagesPath.fractionIcon,
      'color': ColorResources.HOME_BG_5,
      'borderColor': ColorResources.HOME_BD_5,
      'routerPage': MainRouters.PRACTION,
    },
    {
      'title': ImagesPath.decimalIcon,
      'color': ColorResources.HOME_BG_6,
      'borderColor': ColorResources.HOME_BD_6,
      'routerPage': MainRouters.DECIMAL,
    },
    {
      'title': ImagesPath.exponentsIcon,
      'color': ColorResources.HOME_BG_7,
      'borderColor': ColorResources.HOME_BD_7,
      'routerPage': MainRouters.EXPONENTS,
    },
    {
      'title': ImagesPath.squareRootIcon,
      'color': ColorResources.HOME_BG_8,
      'borderColor': ColorResources.HOME_BD_8,
      'routerPage': MainRouters.SQUARE_ROOTS,
    },
    {
      'title': ImagesPath.algebraIcon,
      'color': ColorResources.HOME_BG_9,
      'borderColor': ColorResources.HOME_BD_9,
      'routerPage': MainRouters.ALGEBRA,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    getSound();
    log('premium: $sl<SharedPreferenceHelper>().getPremium.toString()');
  }

  Future<void> getSound() async {
    if (Get.isRegistered<SoundController>()) {
      log('init sound home');
      print(Get.find<SoundController>().isPlayMusic.value);
      if (!Get.find<SoundController>().isPlayMusic.value) {
        Get.find<SoundController>().playBackgroundSound();
      }
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();

    super.dispose();
  }

  // @override
  // Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
  //   if (state == AppLifecycleState.resumed) {
  //     print('isPremium.value: ${isPremium.value}');
  //     if (!_keyValidateAds.isShowingAdsAward && !isPremium.value) {
  //       // Load ads.
  //       appOpenAdManager.showOpenAppAds(
  //         onSuccess: () {},
  //         onError: () {},
  //       );
  //     }
  //   }
  // }

  Future<void> refreshPremium() async {
    // Get count message of user.
    // if (!sl<SharedPreferenceHelper>().getPremium) {
    //   _getCurrentMessageOfUser();
    // }

    // Check user have purchase.
    _checkUserHavePurchase();
  }

  void _checkUserHavePurchase() {
    // kiểm tra ngày hết hạn premium
    if (DateTime.parse(sl<SharedPreferenceHelper>().getEndTimePremium)
        .isAfter(DateTime.now())) {
      sl<SharedPreferenceHelper>().setPremium(isPremium: true);
    } else {
      sl<SharedPreferenceHelper>().setPremium(isPremium: false);
    }
    // if (sl<SharedPreferenceHelper>()
    //     .getEndTimePremium
    //     .isBefore(DateTime.now())) {
    //   sl<SharedPreferenceHelper>().setPremium(isPremium: false);
    // }
    // _authRepository.checkDeviceHavePurchase(
    //   onSuccess: (data) {
    //     if (data.isPremium! &&
    //         !IZIValidate.nullOrEmpty(data.premiumEndDate) &&
    //         data.premiumEndDate!.isAfter(DateTime.now())) {
    //       isPremium.value = true;

    //       // Set premium.
    //       sl<SharedPreferenceHelper>().setPremium(isPremium: isPremium.value);
    //     }
    //   },
    //   onError: (e) {
    //     log('Error check purchase $e');
    //   },
    // );
  }
}
