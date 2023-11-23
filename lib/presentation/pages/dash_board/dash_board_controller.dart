// ignore_for_file: use_setters_to_change_properties

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/pages/dash_board/UIGame_model.dart';

class DashBoardController extends GetxController with WidgetsBindingObserver {
  ///
  /// Declare the API.
  final KeyValidateAds _keyValidateAds = GetIt.I.get<KeyValidateAds>();
  final _sharedHelper = sl<SharedPreferenceHelper>();

  /// Declare the data.
  List<Game> listEight = [];
  List<Game> listFour = [];
  List<Game> listFourDecimal = [];
  List<Game> listFourAlgebra = [];
  List<Game> listThree = [];
  List<Game> listThreeSquareRoot = [];

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
    init();

    WidgetsBinding.instance.addObserver(this);

    _checkUserHavePurchase();
    super.onInit();

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

  void init() {
    listEight = [
      Game(
        name: 'select_game_1'.tr,
        image: ImagesPath.practiceIcon,
        route: MainRouters.PRACTICE,
      ),
      Game(
        name: 'select_game_2'.tr,
        image: ImagesPath.quizIcon,
        route: MainRouters.QUIZ,
      ),
      Game(
        name: 'select_game_3'.tr,
        image: ImagesPath.multiplayerIcon,
        route: MainRouters.MULTIPLAYER,
      ),
      Game(
        name: 'select_game_4'.tr,
        image: ImagesPath.misingNumberIcon,
        route: MainRouters.MISSINGNUMBER,
      ),
      Game(
        name: 'select_game_5'.tr,
        image: ImagesPath.truephoneIcon,
        route: MainRouters.TRUEFALSE,
      ),
      Game(
        name: 'select_game_6'.tr,
        image: ImagesPath.memoryIcon,
        route: MainRouters.MEMMORY,
      ),
      Game(
        name: 'select_game_7'.tr,
        image: ImagesPath.longAdditionIcon,
        route: MainRouters.LONGADDITION,
      ),
      Game(
        name: 'select_game_8'.tr,
        image: ImagesPath.timeChallenge,
        route: MainRouters.TIMECHALLENGE,
      ),
    ];
    listFour = [
      Game(
        name: 'select_four_1'.tr,
        image: ImagesPath.practice_addition,
        route: MainRouters.FRACTICE_PLAY,
      ),
      Game(
        name: 'select_four_2'.tr,
        image: ImagesPath.practiceSubtractionIcon,
        route: MainRouters.FRACTICE_PLAY,
      ),
      Game(
        name: 'select_four_3'.tr,
        image: ImagesPath.practiceMultiplicationIcon,
        route: MainRouters.FRACTICE_PLAY,
      ),
      Game(
        name: 'select_four_4'.tr,
        image: ImagesPath.practiceDivisionIcon,
        route: MainRouters.FRACTICE_PLAY,
      ),
    ];
    listFourDecimal = [
      Game(
        name: 'select_four_1'.tr,
        image: ImagesPath.practice_addition,
        route: MainRouters.PLAYDECIMAL,
      ),
      Game(
        name: 'select_four_2'.tr,
        image: ImagesPath.practiceSubtractionIcon,
        route: MainRouters.PLAYDECIMAL,
      ),
      Game(
        name: 'select_game_2'.tr,
        image: ImagesPath.quizIcon,
        route: MainRouters.PLAYDECIMAL,
      ),
      Game(
        name: 'select_game_3'.tr,
        image: ImagesPath.multiplayerIcon,
        route: MainRouters.PLAYDECIMALMULTI,
      ),
    ];
    listFourAlgebra = [
      Game(
        name: 'select_four_1'.tr,
        image: ImagesPath.practice_addition,
        route: MainRouters.PLAYALGEBRA,
      ),
      Game(
        name: 'select_four_2'.tr,
        image: ImagesPath.practiceSubtractionIcon,
        route: MainRouters.PLAYALGEBRA,
      ),
      Game(
        name: 'select_four_3'.tr,
        image: ImagesPath.practiceMultiplicationIcon,
        route: MainRouters.PLAYALGEBRA,
      ),
      Game(
        name: 'select_four_4'.tr,
        image: ImagesPath.practiceDivisionIcon,
        route: MainRouters.PLAYALGEBRA,
      ),
    ];
    listThree = [
      Game(
        name: 'select_game_1'.tr,
        image: ImagesPath.practiceIcon,
        route: MainRouters.PLAYEXPONENTS,
      ),
      Game(
        name: 'select_game_2'.tr,
        image: ImagesPath.quizIcon,
        route: MainRouters.PLAYEXPONENTS,
      ),
      Game(
        name: 'select_game_3'.tr,
        image: ImagesPath.multiplayerIcon,
        route: MainRouters.MULTIEXPONETS,
      ),
    ];
    listThreeSquareRoot = [
      Game(
        name: 'select_game_1'.tr,
        image: ImagesPath.practiceIcon,
        route: MainRouters.PLAYSQUAREROOT,
      ),
      Game(
        name: 'select_game_2'.tr,
        image: ImagesPath.quizIcon,
        route: MainRouters.PLAYSQUAREROOT,
      ),
      Game(
        name: 'select_game_3'.tr,
        image: ImagesPath.multiplayerIcon,
        route: MainRouters.MULTISQUARE,
      ),
    ];
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
