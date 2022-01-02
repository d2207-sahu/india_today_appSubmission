import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:india_today/ViewModels/AstroViewModel.dart';
import 'Constant.dart';
import 'Navigation/Router.dart';
import 'ViewModels/ConnectivityProvider.dart';
import 'ViewModels/DailyPanchangViewModel.dart';
import 'ViewModels/MainViewModel.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.black54,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<MainViewModel>()),
        ChangeNotifierProvider<DailyPanchangViewModel>(
          create: (_) => locator<DailyPanchangViewModel>(),
        ),
        ChangeNotifierProvider<AstroViewModel>(
          create: (_) => locator<AstroViewModel>(),
        ),
        ChangeNotifierProvider(create: (_) => locator<ConnectivityProvider>()),
      ],
      child: MaterialApp(
        onGenerateRoute: Routers.onGenerateRoute,
        initialRoute: mainRoute,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.orange,
        ),
        color: Colors.white,
        navigatorKey: GlobalKey<NavigatorState>(),
        debugShowCheckedModeBanner: false,
        title: 'India Today',
      ),
    );
  }
}
