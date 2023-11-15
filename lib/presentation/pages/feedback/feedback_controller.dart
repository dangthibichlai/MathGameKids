// ignore_for_file: use_setters_to_change_properties

import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/response/feedback_model.dart';
import 'package:template/data/repositories/feedback_repositories.dart';
import 'package:template/data/repositories/image_upload_repositories.dart';

import '../../../core/export/core_export.dart';

class FeedbackController extends GetxController with WidgetsBindingObserver {
  List<String> feedBackData = [
    'feedback_006'.tr,
    'feedback_007'.tr,
    'feedback_008'.tr,
    'feedback_009'.tr,
    'feedback_010'.tr,
  ];

  List<String> feedBackVietnam = [
    'Sự cố & Lỗi',
    'Trải nghiệm',
    'Chất lượng',
    'Giao diện',
    'Khác',
  ];

  ///
  /// Declare the API.
  final KeyValidateAds _keyValidateAds = GetIt.I.get<KeyValidateAds>();
  final FeedbackRepository _feedbackRepository =
      GetIt.I.get<FeedbackRepository>();
  final ImageUploadRepository _uploadRepository =
      GetIt.I.get<ImageUploadRepository>();

  /// Declare the data.
  RxInt currentIndex = 0.obs;
  RxList<File> fileFeedBack = <File>[].obs;

  /// Declare the controller.
  TextEditingController feedbackController = TextEditingController();

  int? pointRate;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);

    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      pointRate = IZINumber.parseInt(Get.arguments.toString());
    }
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);

    currentIndex.close();
    fileFeedBack.close();

    // Dispose controller.
    feedbackController.dispose();
    super.onClose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    _keyValidateAds.setIsShowingAdsAward(value: true);
  }

  ///
  /// On change current index.
  ///
  void onChangeCurrentIndex({required int index}) {
    currentIndex.value = index;
  }

  ///
  /// Delete image.
  ///
  void deleteImage({required int index}) {
    fileFeedBack.removeAt(index);
  }

  ///
  /// Image picker.
  ///
  Future<void> pickImage() async {
    try {
      final _result = await ImagePicker().pickMultiImage(imageQuality: 70);

      if (_result.isEmpty) return;
      final _fileResult = _result.map((e) => File(e.path)).toList();

      fileFeedBack.addAll(_fileResult);
      fileFeedBack.refresh();
    } on PlatformException catch (e) {
      log("Failed to pick image: $e");
    }
  }

  Future<void> sendFeedback() async {
    if (feedbackController.text.length < 6) {
      IZIAlert().info(message: 'feedback_011'.tr);
      return;
    }
    final deviceInfoPlugin = DeviceInfoPlugin();

    late String _deviceId;

    if (Platform.isAndroid) {
      final _androidInfo = await deviceInfoPlugin.androidInfo;
      _deviceId = _androidInfo.model;
    } else {
      final _iosInfo = await deviceInfoPlugin.iosInfo;
      _deviceId = _iosInfo.model;
    }
    IZIAlert().success(message: "feedback_012".tr);
    Get.back();

    List<String> imagesPath = [];
    if (fileFeedBack.isNotEmpty) {
      final images = await _uploadRepository.addImages(fileFeedBack);
      imagesPath = images.map((e) => e.originImage.toString()).toList();
    }

    final FeedbackModel feedbackModel = FeedbackModel(
      rating: pointRate,
      deviceID: _deviceId,
      feedbackReply: feedBackVietnam[currentIndex.value],
      feedbackText: feedbackController.text,
      feedbackImage: imagesPath,
    );
    _feedbackRepository.sendFeedback(
      feedbackModel: feedbackModel,
      onSuccess: (returnData) {},
      onError: (e) {},
    );
  }
}
