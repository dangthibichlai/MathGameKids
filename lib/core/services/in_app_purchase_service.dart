import 'dart:developer';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:template/core/services/in_app_purchase_service/id_subscription.dart';

class InAppPurchaseService {
  static InAppPurchaseService instance = InAppPurchaseService();

  static InAppPurchaseService getInstance() {
    return instance;
  }

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  static List<ProductDetails> _products = [];
  static final List<PurchaseDetails> _purchases = <PurchaseDetails>[];

  static List<ProductDetails> get products => _products;
  static List<PurchaseDetails> get purchases => _purchases;

  ///
  /// Init service.
  ///
  Future<void> initService() async {
    final bool _isAvailable = await _inAppPurchase.isAvailable();

    if (!_isAvailable) {
      log('In app purchase is not available');
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse _productDetailResponse =
        await _inAppPurchase.queryProductDetails(IdSubscription.listProductId.toSet());

    if (_productDetailResponse.error != null) {
      _products = _productDetailResponse.productDetails;
    }

    final List<ProductDetails> _items = _productDetailResponse.productDetails;

    _products.clear();

    // Check have this package.
    for (final e in _items) {
      if (IdSubscription.listProductId.contains(e.id)) {
        _products.add(e);
      }
    }

    _products.sort((ProductDetails a, ProductDetails b) => a.rawPrice.compareTo(b.rawPrice));
  }

  Future<bool> verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
