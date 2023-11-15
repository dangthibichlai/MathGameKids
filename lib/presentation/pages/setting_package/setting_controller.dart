import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:ntp/ntp.dart';
import 'package:share_plus/share_plus.dart';
import 'package:template/config/routes/route_path/in_app_purchase_routers.dart';
import 'package:template/core/di_container.dart';
import 'package:template/data/model/auth/auth_model.dart';
import 'package:template/data/model/response/latest_receipt_info_model.dart';
import 'package:template/data/repositories/in_app_api.dart';
import 'package:template/data/repositories/setting_repositories.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/setting_package/rate_us_dialog.dart';
import 'package:template/presentation/pages/setting_package/show_diaolog.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/export/core_export.dart';

class SettingController extends GetxController with WidgetsBindingObserver {
  Rx<bool> isCheckSound = sl<SharedPreferenceHelper>().getPlaySound.obs;
  Rx<bool> isCheckMusic = sl<SharedPreferenceHelper>().getPlayMusic.obs;
  final InAppReview inAppReview = InAppReview.instance;
  bool isSharing = false;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final InAppAPI _inAppAPI = GetIt.I.get<InAppAPI>();
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  RxList<ProductDetails> productsList = <ProductDetails>[].obs;
  RxBool isLoading = true.obs;
  final KeyValidateAds _keyValidateAds = GetIt.I.get<KeyValidateAds>();
  bool isNotAllowShowAds = true;
  static const String UPDATE_RATE_US = 'UPDATE_RATE_US';
  final SettingRepository _settingRepository = GetIt.I.get<SettingRepository>();
  RxString appEmail = 'contact.onigroup@gmail.com'.obs;
  RxString linkAdroid = ''.obs;
  RxString linkIOS = ''.obs;
  RxString text = ''.obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    isCheckSound = sl<SharedPreferenceHelper>().getPlaySound.obs;
    isCheckMusic = sl<SharedPreferenceHelper>().getPlayMusic.obs;
    _listenSubscriptions();
    _initInAppPurchase();
    getAPI();
    super.onInit();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    _keyValidateAds.setIsShowingAdsAward(value: true);
  }

  Future<void> getAPI() async {
    await _settingRepository.getPolicyTerms(
      onSuccess: (data) {
        linkAdroid.value = data.linkAdroid.toString();
        linkIOS.value = data.linkIos.toString();
        appEmail.value = data.appEmail.toString(); 
      },
      onError: (e) {
        log('Error get term at $e');
      },
    );
  }

  @override
  void onClose() {
    //
    // Close stream.
    WidgetsBinding.instance.removeObserver(this);
    _subscription.cancel();
    isLoading.close();
    productsList.close();

    isCheckSound.close();
    isCheckMusic.close();
    super.onClose();
  }

  Future<void> requestReview() async {
    if (await inAppReview.isAvailable()) {
      // Platform-specific review dialog will be shown to the user.
      await inAppReview.requestReview();
      // kiểm tra trạng thái review
    }
  }

  void goToChangeLanguage() {
    Get.toNamed(InAppPurchaseRouters.CHANGE_LANGUAGE);
  }

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

  Future<void> _initInAppPurchase() async {
    await InAppPurchaseService.instance.initService();

    productsList.value = InAppPurchaseService.products;
    // currentIndex ban đầu focus vào gói 1 tháng

    // ignore: unused_local_variable
    final weelkyPackageIndex = productsList.indexWhere(
        (element) => element.id.compareTo(IdSubscription.weeklyId) == 0);

    if (isLoading.value) {
      isLoading.value = false;
    }
  }

  void rateUs(BuildContext context) {
    if (GetIt.I.get<SharedPreferenceHelper>().getIsRatedApp) {
      return;
    }
    ShowDialog.showGenerateDialog(
      context: context,
      childWidget: RateUsDialog(
        callBack: (rate) async {
          if (rate <= 3) {
            Get.toNamed(InAppPurchaseRouters.FEEDBACK);
          } else {
            GetIt.I.get<SharedPreferenceHelper>().setIsRatedApp(isRate: true);
            update([UPDATE_RATE_US]);
            // Inapp review
            final InAppReview inAppReview = InAppReview.instance;
            if (await inAppReview.isAvailable()) {
              inAppReview.requestReview();
            }
          }
        },
      ),
      isAllowCloseOutSize: false,
    );
  }

// Add this flag
  void shareAppLink() {
    Platform.isAndroid
        ? linkAdroid.value
        : linkIOS.value; // Replace myPackageName with your app's Package Name

    isSharing = true; // Set the flag to true when sharing dialog is open
    final String title = 'share_app'.tr;
    final String text =
        '$title.\n${Platform.isAndroid ? linkAdroid.value : linkIOS.value}'; // Replace with your app's actual URL
    // final String text =
    //     '$title.\nhttps://play.google.com/store/apps/details?id=sensustech.math.games.kids.addition.subtraction.multiplication.division'; // Replace with your app's actual URL
    Share.share(text, subject: 'Share App').whenComplete(() {
      isSharing = false; // Reset the flag when sharing is complete
    });
  }

  ///
  ///Restore purchase
  ///
  Future<void> restorePurchase() async {
    final InAppPurchase _inAppPurchase = InAppPurchase.instance;
    try {
      await _inAppPurchase.restorePurchases();
    } catch (ex) {
      IZIAlert().error(message: 'buy_Package_9'.tr);
    }
    EasyLoading.dismiss(); // dùng
  }

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
            _deliverProduct(
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
  /// Contact us
  ///
  Future<void> launchEmail() async {
    appEmail.value = appEmail.value.isNotEmpty
        ? appEmail.value
        : 'contact.onigroup@gmail.com';
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: appEmail.value, // Điền địa chỉ email của bạn ở đây.
      query: CommonHelper.encodeQueryParameters(<String, String>{
        'subject': 'Liên hệ từ ứng dụng của bạn', // Tiêu đề email
        'body': 'Nội dung email: ', // Nội dung email mặc định
      }),
    );

    await launchUrl(_emailLaunchUri);
  }

  void onCheckMusic() {
    isCheckMusic.value = !isCheckMusic.value;

    sl<SharedPreferenceHelper>().setPlayMusic(status: isCheckMusic.value);
    if (Get.isRegistered<SoundController>()) {
      Get.find<SoundController>().playBackgroundSound();
    }
  }

  void onCheckSound() {
    isCheckSound.value = !isCheckSound.value;
    sl<SharedPreferenceHelper>().setPlaySound(status: isCheckSound.value);
  }
}
