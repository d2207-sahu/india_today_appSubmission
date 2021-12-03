import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  MaterialPageRoute<dynamic>? navigateTo(String homeRoute) {
    // return globalKey.currentState?.pushNamed(homeRoute);
  }

  Future<Object?>? navigateandDestroy(routeName) {
    return globalKey.currentState?.popAndPushNamed(routeName);
  }

  // Future<dynamic> permanentNavigateTo(String routeName) {
  //   print(routeName);
  //   return globalKey.currentState.pushReplacementNamed(routeName);
  // }

  void goBack() {
    return globalKey.currentState?.pop();
  }
}
