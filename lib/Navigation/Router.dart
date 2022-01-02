import 'package:flutter/material.dart';
import 'package:zealth_assignment/Views/DailyPanchangScreen.dart';
import 'package:zealth_assignment/Views/MainScreen.dart';
import '../Constant.dart';

class Routers {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => MainScreen());
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => DailyPanchangScreen());
    }
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: Text('Something went wrong , please try again'),
      )),
    );
  }
}
