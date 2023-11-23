// ignore_for_file: use_setters_to_change_properties

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:ntp/ntp.dart';
import 'package:template/config/routes/route_path/in_app_purchase_routers.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/services/google_admod_services/reward_ads_manager/reward_ads.dart';
import 'package:template/data/export/data_export.dart';
import 'package:template/data/model/response/latest_receipt_info_model.dart';
import 'package:template/data/repositories/in_app_api.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';

class PreniumController extends GetxController with WidgetsBindingObserver {
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();
  final KeyValidateAds _keyValidateAds = GetIt.I.get<KeyValidateAds>();
  final InAppAPI _inAppAPI = GetIt.I.get<InAppAPI>();
  double? priceMonthlyBeforeDiscount;
  RxBool isPremium = false.obs;
  List<Map<String, dynamic>> listViews = [
    {
      'title': 'pre_list_view_title_001'.tr,
      'image': ImagesPath.pre_list_img,
    },
    {
      'title': 'pre_list_view_title_002'.tr,
      'image': ImagesPath.pre_list_img2,
    },
    {
      'title': 'pre_list_view_title_003'.tr,
      'image': ImagesPath.img1_next1,
    },
    {
      'title': 'pre_list_view_title_004'.tr,
      'image': ImagesPath.img_splashImage1,
    },
  ];
  List<String> packageDescription = [
    'Answer from GPT-4'.tr,
    'Unlimited messages'.tr,
    'Voice chat available'.tr,
    'Create unlimited apps'.tr,
  ];

  RxInt currentIndexPackage = 1.obs;
  RxBool isLoading = true.obs;
  bool _isShowRewardAds = false;
  final ScrollController controller = ScrollController();

  // void fomatMoney(double number) {

  /// In app purchase.
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  RxList<ProductDetails> productsList = <ProductDetails>[].obs;
  double? originalMonthlyPrice;

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addObserver(this);

    // Get arguments.
    _getArguments();

    //  Listen subscriptions.
    _listenSubscriptions();
    // Init in app purchase.
    _initInAppPurchase();
  }

  @override
  void onClose() {
    super.onClose();

    WidgetsBinding.instance.removeObserver(this);

    // Close stream.
    _subscription.cancel();
    isLoading.close();
    currentIndexPackage.close();
    productsList.close();

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
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
  /// Get arguments.
  ///
  void _getArguments() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      _isShowRewardAds = Get.arguments as bool;
    }
  }

  ///
  /// Listen subscriptions.
  ///
  void _listenSubscriptions() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
    });
  }

  ///
  /// Init in app purchase.
  ///
  Future<void> _initInAppPurchase() async {
    await InAppPurchaseService.instance.initService();
    //  if (InAppPurchaseService.priceMonthBeforeDiscount > 0) {
    //     priceMonthlyBeforeDiscount = InAppPurchaseService.priceMonthBeforeDiscount;
    //   }

    productsList.value = InAppPurchaseService.products;
    print('TechMind ${productsList.length}');

    // currentIndex ban đầu focus vào gói 1 tháng
    currentIndexPackage.value = productsList.indexWhere(
        (element) => element.id.compareTo(IdSubscription.monthlyId) == 0);

    final weelkyPackageIndex = productsList.indexWhere(
        (element) => element.id.compareTo(IdSubscription.weeklyId) == 0);
    originalMonthlyPrice = weelkyPackageIndex == -1
        ? null
        : productsList[weelkyPackageIndex].rawPrice * 4;

    if (isLoading.value) {
      isLoading.value = false;
    }
  }

  ///
  /// Listen purchase.
  ///
  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    //
    // Show toast don't have purchase.
    if (purchaseDetailsList.isEmpty) {
      IZIAlert().info(message: 'not_vip'.tr);
    }

    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      // Purchasing...
      if (purchaseDetails.status == PurchaseStatus.pending) {
        EasyLoading.show(status: 'buy_Package_5'.tr);
      } else {
        EasyLoading.dismiss();

        // If has error.
        if (purchaseDetails.status == PurchaseStatus.error) {
          log('Error in app purchase: ${purchaseDetails.productID} && ${purchaseDetails.error?.code} & ${purchaseDetails.error?.message}');
        }

        // Restored.
        else if (purchaseDetails.status == PurchaseStatus.restored) {
          //
          // Check have purchase and login app.
          _verifyPurchase(purchaseDetails: purchaseDetails);
        }

        // If purchased
        else if (purchaseDetails.status == PurchaseStatus.purchased) {
          //
          // Create user when buy account.
          if (IdSubscription.listProductId
              .contains(purchaseDetails.productID)) {
            _deliverProduct(
              purchaseDetails: purchaseDetails,
              isPremium: true,
              serverVerificationData:
                  purchaseDetails.verificationData.serverVerificationData,
            );
            Get.toNamed(MainRouters.HOME);
          }
        }

        // Complete purchase
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  ///
  /// Restore purchase.
  ///
  Future<void> restorePurchase() async {
    try {
      await _inAppPurchase.restorePurchases();
    } catch (ex, trace) {
      IZIAlert().error(message: 'buy_Package_9'.tr);
      log(ex.toString());
      log(trace.toString());
    }
    EasyLoading.dismiss();
  }

  ///
  /// Login user.
  ///
  Future<void> continueLoginApp() async {
    //
    // Check if user purchase.
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iapStoreKitPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }

    // Purchase package.
    _purchasePackage();
  }

  ///
  /// Buy package.
  ///
  void _purchasePackage() {
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productsList[currentIndexPackage.value]);
    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  ///
  /// Verify purchase.
  ///
  Future<void> _verifyPurchase(
      {required PurchaseDetails purchaseDetails}) async {
    //
    // Set premium with condition purchaseID.
    if (purchaseDetails.purchaseID != null) {
      //
      // Set premium on Android.
      if (Platform.isIOS) {
        //
        // Verify in IOS with API.
        _inAppAPI.verifyReceiptApple(
          idProduct: purchaseDetails.productID,
          receipt: purchaseDetails.verificationData.serverVerificationData,
          onSuccess: (data) async {
            //
            // Check expire date of purchase..
            late DateTime _dateTimeNow;
            try {
              _dateTimeNow = await NTP.now();
            } catch (e) {
              _dateTimeNow = DateTime.now();
            }

            // Check expire date until premium.
            if (_dateTimeNow.isBefore(data.expiresDateMs!)) {
              _deliverProduct(isPremium: true, latestReceiptInfoModel: data);
            } else {
              _deliverProduct(isPremium: false);
            }
          },
          onError: (e) {
            //
            // Error then set false premium.
            _deliverProduct(isPremium: false);
          },
        );
      } else {
        //
        // Set premium on Android.
        _deliverProduct(isPremium: true, purchaseDetails: purchaseDetails);
      }

      IZIAlert().success(message: 'buy_Package_8'.tr);
    } else {
      _deliverProduct(isPremium: false);
    }
  }

  ///
  /// Deliver the purchase.
  ///
  Future<void> _deliverProduct({
    PurchaseDetails? purchaseDetails,
    LatestReceiptInfoModel? latestReceiptInfoModel,
    required bool isPremium,
    String? serverVerificationData,
  }) async {
    final AuthModel _authPremium = AuthModel();
    _authPremium.isPremium = isPremium;
    _authPremium.language = sl<SharedPreferenceHelper>().getLocale;
    sl<SharedPreferenceHelper>().setPremium(isPremium: isPremium);
    if (Get.isRegistered<DashBoardController>()) {
      Get.find<DashBoardController>().isPremium.value = isPremium;
    }

    if (serverVerificationData != null) {
      _authPremium.idPremium = serverVerificationData;
    }

    if (purchaseDetails != null) {
      _authPremium.premiumEndDate = CommonHelper.getPremiumEndDate(
          startDate: DateTime.fromMillisecondsSinceEpoch(
              IZINumber.parseInt(purchaseDetails.transactionDate)),
          idPurchase: purchaseDetails.productID);
    } else if (latestReceiptInfoModel != null) {
      _authPremium.premiumEndDate = latestReceiptInfoModel.expiresDateMs;
    }

    log('TechMind run here $isPremium');
    sl<SharedPreferenceHelper>()
        .setEndTimePremium(date: _authPremium.premiumEndDate.toString());
  }

  ///
  /// On change current index package.
  ///
  void onChangePackage({required int index}) {
    currentIndexPackage.value = index;
  }

  ///
  /// Go to privacy policy.
  ///
  void goToPrivacyPolicy() {
    Get.toNamed(InAppPurchaseRouters.PRIVACY_POLICY);
  }

  ///
  /// Go to term of user.
  ///
  void goToTermOfUser() {
    Get.toNamed(InAppPurchaseRouters.TERM_OF_USER);
  }

  ///
  ///  Handle get back.
  ///
  void handleGetBack(BuildContext context) {
    if (_isShowRewardAds) {
      BaseDialog.showBaseDialog(
        context: context,
        callBackWatchAds: () {
          RewardAds.getInstance().showRewardAds(
            onSuccess: (adWithoutView, item) {
              //
              // Increase free message.
              _authRepository.increaseFreeMessage(
                amount: 2,
                onSuccess: (data) {
                  Get.find<DashBoardController>().countMessageOfUser.value =
                      Get.find<DashBoardController>().countMessageOfUser.value +
                          2;
                  log('Get ads reward done');
                  Get.back();
                },
                onError: (e) {
                  log('Error increase free message');
                },
              );
            },
            onError: () {
              IZIAlert().error(message: 'Ad loading failed.');
            },
          );
        },
        callBackGetPro: () {
          Get.back();
        },
        callBackOffDialog: () {
          Get.back();
        },
        callbackAgree: () {},
      );
      return;
    }
    Get.back();
  }
}
