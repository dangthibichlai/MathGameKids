import 'dart:async';
import 'dart:developer';
import 'dart:io';

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
import 'package:template/data/export/data_export.dart';
import 'package:template/data/model/response/latest_receipt_info_model.dart';
import 'package:template/data/repositories/in_app_api.dart';

class PackageDescriptionController extends GetxController {
  ///
  ///
  /// Declare the API.
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();
  final DioClient _dioClient = GetIt.I.get<DioClient>();
  final InAppAPI _inAppAPI = GetIt.I.get<InAppAPI>();

  /// Declare the data.
  List<String> packageDescription = [
    'Answer from GPT-4'.tr,
    'Unlimited messages'.tr,
    'Voice chat available'.tr,
    'Create unlimited apps'.tr,
  ];

  /// In app purchase.
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  ProductDetails? productsMonthly;

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    //  Listen subscriptions.
    _listenSubscriptions();

    // Init in app purchase.
    _initInAppPurchase();
  }

  @override
  void onClose() {
    // Close stream.
    _subscription.cancel();
    isLoading.close();

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }

    super.onClose();
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

    productsMonthly = InAppPurchaseService.productMonthly;
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
      IZIAlert().info(
          message:
              'You are not a VIP member. Please subscribe to become a VIP member'
                  .tr);
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
            handleBuyPremiumAndCreateUser(
              purchaseDetails: purchaseDetails,
              isPremium: true,
              serverVerificationData:
                  purchaseDetails.verificationData.serverVerificationData,
            );
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
        PurchaseParam(productDetails: productsMonthly!);
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
              handleBuyPremiumAndCreateUser(
                  isPremium: true, latestReceiptInfoModel: data);
            } else {
              handleBuyPremiumAndCreateUser(isPremium: false);
            }
          },
          onError: (e) {
            //
            // Error then set false premium.
            handleBuyPremiumAndCreateUser(isPremium: false);
          },
        );
      } else {
        //
        // Set premium on Android.
        handleBuyPremiumAndCreateUser(
            isPremium: true, purchaseDetails: purchaseDetails);
      }

      IZIAlert().success(message: 'buy_Package_8'.tr);
    } else {
      handleBuyPremiumAndCreateUser(isPremium: false);
    }
  }

  ///
  /// Create user.
  ///
  void handleBuyPremiumAndCreateUser({
    PurchaseDetails? purchaseDetails,
    LatestReceiptInfoModel? latestReceiptInfoModel,
    required bool isPremium,
    String? serverVerificationData,
  }) {
    EasyLoading.show(status: 'buy_Package_10'.tr);
    final AuthModel _auth = AuthModel();
    _auth.deviceID = sl<SharedPreferenceHelper>().getTokenDevice;
    // _auth.appType = AppTypeEnum.A3_AI_CHAT.name;

    _authRepository.signInSocial(
      data: _auth,
      onSuccess: (data) async {
        sl<SharedPreferenceHelper>().setJwtToken(data.accessToken.toString());
        sl<SharedPreferenceHelper>().setLogger(idLogger: true);
        sl<SharedPreferenceHelper>().setIdUser(idUser: data.id.toString());

        log('Update user success!');

        // Refresh dio.
        await _dioClient.refreshToken();

        // Update premium.
        await _deliverProduct(
          purchaseDetails: purchaseDetails,
          isPremium: isPremium,
          latestReceiptInfoModel: latestReceiptInfoModel,
          serverVerificationData: serverVerificationData,
        );
        EasyLoading.dismiss();
        Get.offAllNamed(MainRouters.HOME);
      },
      onError: (e) {
        log(e.toString());
        EasyLoading.dismiss();
      },
    );
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

    await _authRepository.update(
      id: sl<SharedPreferenceHelper>().getIdUser,
      data: _authPremium,
      onSuccess: (data) {
        log('Update premium success!');
      },
      onError: (e) {
        log('Error at update premium $e');
      },
    );
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
}
