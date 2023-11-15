import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:template/core/helper/izi_alert.dart';

class IZINetwork {
  final Connectivity connectivity;
  IZINetwork(this.connectivity);

  Future<bool> get isConnected async {
    final ConnectivityResult _result = await connectivity.checkConnectivity();
    return _result != ConnectivityResult.none;
  }

  static void checkConnectivity(BuildContext context) {
    bool _firstTime = true;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if (!_firstTime) {
        //bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        bool isNotConnected;
        if (result == ConnectivityResult.none) {
          isNotConnected = true;
        } else {
          isNotConnected = !await _updateConnectivityStatus();
        }
        IZIAlert().error(message: isNotConnected ? "Not connectivity" : "Connected");
      }
      _firstTime = false;
    });
  }

  static Future<bool> _updateConnectivityStatus() async {
    late bool _isConnected;
    try {
      final List<InternetAddress> _result = await InternetAddress.lookup('google.com');
      if (_result.isNotEmpty && _result[0].rawAddress.isNotEmpty) {
        _isConnected = true;
      }
    } catch (e) {
      _isConnected = false;
    }
    return _isConnected;
  }
}
