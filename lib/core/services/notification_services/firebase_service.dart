import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/utils/app_constants.dart';

class FcmService {
  FcmService() {
    // if (_firebaseMessaging == null) {
    //   _firebaseMessaging = FirebaseMessaging();
    // }
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // final DioClient? dioClient = GetIt.I.get<DioClient>();

  Future<void> initForegroundNotification() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> init() async {
    // yêu cầu cấp quyền thông báo
    if (Platform.isIOS) {
      // ignore: unused_local_variable
      final NotificationSettings settings = await _firebaseMessaging.requestPermission(
        announcement: true,
        carPlay: true,
      );
    }

    // final NotificationSettings settings = await requestPermission();
    //Get.log('User granted permission: ${AuthorizationStatus.values[settings.authorizationStatus.index]}');

    await _firebaseMessaging.setAutoInitEnabled(true);

    // subscribeTopic(FCM_TOPIC_DEFAULT);

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        Get.log('getInitialMessage data: ${message.data}');
        Get.log('getInitialMessage notification: ${message.notification}');
        onOpenNotification(message);
      }
    });

    /// Xử lý message khi nhận thông báo ở forgground
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      debugPrint("onMessage: $message");
      Get.log('Message data: ${message?.data}');
      Get.log('Message notification: ${message?.notification}');
      final RemoteNotification? notification = message?.notification;

      if (notification != null && Platform.isAndroid) {
        final Map<String, dynamic> data = message?.data ?? {};
        data[NOTIFICATION_KEY] = notification.hashCode.toString();
        data[NOTIFICATION_TITLE] = notification.title;
        Get.log('data to send: $data');

        // Show local notification.
      }
    });

    /// Xử lý message khi nhân vào thông báo.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('A new onMessageOpenedApp event was published!');
      debugPrint("onMessageOpenedApp: data ${message.data}");
      debugPrint("onMessageOpenedApp: notification ${message.notification}");
      onOpenNotification(message);
    });
  }

  // Yêu cầu cấp quyền
  Future<void> requestPermission() async {
    final requestPermisson = await _firebaseMessaging.getNotificationSettings();
    if (requestPermisson.authorizationStatus == AuthorizationStatus.denied ||
        requestPermisson.authorizationStatus == AuthorizationStatus.notDetermined ||
        requestPermisson.authorizationStatus == AuthorizationStatus.provisional) {
      // ignore: unused_local_variable
      final NotificationSettings settings = await _firebaseMessaging.requestPermission(
        announcement: true,
        carPlay: true,
      );
      // if (settings.authorizationStatus == AuthorizationStatus.denied) {
      //   final PermissionStatus permissionStatus = await NotificationPermissions.getNotificationPermissionStatus();
      //   if (permissionStatus == PermissionStatus.denied || permissionStatus == PermissionStatus.unknown) {
      //     NotificationPermissions.requestNotificationPermissions();
      //   }
      // }
    }
  }

  /// Top function / static function xử lý khi nhận thông báo backdround
  static Future<dynamic> backgroundMessageHandler(RemoteMessage message) async {
    debugPrint("onBackgroundMessage data: ${message.data}");
    debugPrint("onBackgroundMessage notification: ${message.notification}");
    // LocalNotificationService().showNotification(
    //   Random().nextInt(1000),
    //   message.notification?.title ?? '',
    //   message.notification?.body ?? '',
    //   notificationChannelId,
    //   "DPFOOD",
    //   "",
    // );
  }

  /// Open notification
  Future<void> onOpenNotification(RemoteMessage message, {bool isAppClosed = false}) async {
    if (isAppClosed) {}
    debugPrint('onOpenNotification ${message.data}');
  }

  Future<void> backgroundHandler() async {
    await Firebase.initializeApp();

    /// Goi khi nhận thông báo background
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }

  Future<void> subscribeTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeTopic(String topic) async {
    // ignore: deprecated_member_use
    final bool isReset = await deleteInstanceID();
    if (!isReset) {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
    }
  }

  Future<bool> deleteInstanceID() async {
    try {
      await _firebaseMessaging.deleteToken();
      return true;
    } catch (e) {
      return false;
    }
  }
}
