import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zealth_assignment/Views/ImageScreen.dart';
import 'package:zealth_assignment/Views/MainScreen.dart';
import 'package:zealth_assignment/Views/ProfileScreen.dart';

import '../Constant.dart';

class Routers {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => MainScreen());
      case imageRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => ImageScreen());
      case profileRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => ProfileScreen());
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => MainScreen());
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
