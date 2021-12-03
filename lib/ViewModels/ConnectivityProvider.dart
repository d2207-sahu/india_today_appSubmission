import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:zealth_assignment/ViewModels/BaseModel.dart';

class ConnectivityProvider extends BaseModel {
  Connectivity _connectivity = Connectivity();

  bool _isOnline = true;

  bool get isOnline => _isOnline;

  startMonitoring() async {
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        await _updateConnectionStatus().then((bool i) {
          _isOnline = i;
          notifyListeners();
        });
      }
    });
  }

  Future<void> initConnectivity() async {
    try {
      var event = await _connectivity.checkConnectivity();
      if (event == ConnectivityResult.mobile) {
        print("******* Mobile is ON ******");
        _isOnline = true;
        notifyListeners();
      } else if (event == ConnectivityResult.wifi) {
        print("******* Wifi is ON ******");
        _isOnline = true;
        notifyListeners();
      } else {
        _isOnline = false;
        notifyListeners();
      }
    } on PlatformException {
      print("PlatformException");
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _updateConnectionStatus() async {
    bool isConnected = true;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (r) {
      isConnected = false;
    }
    return isConnected;
  }
}
