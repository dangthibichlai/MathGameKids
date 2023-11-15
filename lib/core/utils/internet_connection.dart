// ignore_for_file: camel_case_types

import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum CONNECTION_STATUS {
  CONNECTED,
  DISCONNECTED,
}

class InternetConnection {
  StreamSubscription<InternetConnectionStatus>? _listener;
  Rx<CONNECTION_STATUS> _connectedStatus = CONNECTION_STATUS.CONNECTED.obs;
  InternetConnection() {
    // WidgetsBinding.instance.addObserver(this);
    _initState();
    _onListenerStatus();
  }

  Future<void> _initState() async {
    _connectedStatus.value = await InternetConnectionChecker().hasConnection ? CONNECTION_STATUS.CONNECTED : CONNECTION_STATUS.DISCONNECTED;
  }

  CONNECTION_STATUS get getConnectionStatus => _connectedStatus.value;

  CONNECTION_STATUS get internetConnectedStatus => _connectedStatus.value;
  // ignore: use_setters_to_change_properties
  void setConnectionChecker({required Rx<CONNECTION_STATUS> status}) {
    _connectedStatus = status;
  }

  Future<void> _onListenerStatus() async {
    _listener = InternetConnectionChecker().onStatusChange.listen(
      (status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            _connectedStatus.value = CONNECTION_STATUS.CONNECTED;
            break;
          case InternetConnectionStatus.disconnected:
            _connectedStatus.value = CONNECTION_STATUS.DISCONNECTED;
            break;
        }
      },
    );
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // super.didChangeAppLifecycleState(state);
  //   switch (state) {
  //     case AppLifecycleState.inactive:
  //       print("Close app");
  //       // SystemChannels.textInput.invokeMethod('TextInput.hide');
  //       // onCancel();
  //       break;
  //     case AppLifecycleState.paused:
  //       print("paused app");
  //       break;
  //     case AppLifecycleState.resumed:
  //       print("resumed app");
  //       WidgetsBinding.instance.addObserver(this);
  //       _onListenerStatus();
  //       // _initState();
  //       break;
  //     default:
  //       break;
  //   }
  // }

  ///
  /// dispose
  ///
  void onCancel() {
    _listener?.cancel();
    // WidgetsBinding.instance.removeObserver(this);
    _connectedStatus.close();
  }
}
