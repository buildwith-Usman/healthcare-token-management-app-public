import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class AppConnectivity extends WidgetsBindingObserver {
  AppConnectivity._internal();

  static final AppConnectivity instance = AppConnectivity._internal();

  Future<bool> isInternetAvailable() async {
    try {
      final checkConnectivity = await Connectivity().checkConnectivity();

      // Check if any valid connection type is available
      final result = checkConnectivity.contains(ConnectivityResult.wifi) ||
          checkConnectivity.contains(ConnectivityResult.mobile) ||
          checkConnectivity.contains(ConnectivityResult.vpn) ||
          checkConnectivity.contains(ConnectivityResult.ethernet);

      return result;
    } catch (e) {
      print('Error checking connectivity: $e');
      return false;
    }
  }

}
