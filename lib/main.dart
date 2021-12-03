import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Constant.dart';
import 'Navigation/Router.dart';
import 'ViewModels/ConnectivityProvider.dart';
import 'ViewModels/MainViewModel.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<MainViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ConnectivityProvider>()),
      ],
      child: MaterialApp(
        onGenerateRoute: Routers.onGenerateRoute,
        initialRoute: mainRoute,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.blue,
        ),
        color: Colors.white,
        navigatorKey: GlobalKey<NavigatorState>(),
        debugShowCheckedModeBanner: false,
        title: 'Zealth',
      ),
    );
  }
}