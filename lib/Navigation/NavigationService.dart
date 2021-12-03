import 'package:flutter/material.dart';

/// Not used this, getting error.
/// Have to migrate this logic to dart 2.0 with null safety.
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
