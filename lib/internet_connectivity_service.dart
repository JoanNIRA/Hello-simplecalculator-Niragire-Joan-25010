import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InternetConnectivityService with ChangeNotifier {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  InternetConnectivityService() {
    _initConnectivity();
  }

  ConnectivityResult get connectionStatus => _connectionStatus;

  Future<void> _initConnectivity() async {
    ConnectivityResult result = (await _connectivity.checkConnectivity()) as ConnectivityResult;
    _updateConnectionStatus(result);

    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    } as void Function(List<ConnectivityResult> event)?);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (_connectionStatus != result) {
      _connectionStatus = result;
      notifyListeners();
      print('Connectivity Changed: $result');
      _showToast(result);
    }
  }

  void _showToast(ConnectivityResult result) {
    String message;
    if (result == ConnectivityResult.mobile) {
      message = 'Connected to Mobile Network';
    } else if (result == ConnectivityResult.wifi) {
      message = 'Connected to WiFi';
    } else {
      message = 'No Internet Connection';
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
