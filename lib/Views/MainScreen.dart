import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:india_today/ViewModels/ConnectivityProvider.dart';
import 'package:india_today/ViewModels/MainViewModel.dart';
import 'package:india_today/Views/AstroSearchScreen.dart';
import 'package:india_today/Views/DailyPanchangScreen.dart';
import 'Widgets/CustomBottomNavigationBar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController? _pageController;

  /// Hitting the back button will make the app closed
  Future<bool> goBack() async {
    /// we are checking if the screen is MainScreen. if not than can't leave the app.
    /// had to move to MainScreen than only can leave the app.
    if (_pageController!.page == 0.0) {
      SystemNavigator.pop();
    } else {
      Provider.of<MainViewModel>(context, listen: false).changePage(0);
      _pageController!.animateToPage(
        0,
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    }
    //TODO : IOS Differently Handle it.
    return false;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Consumer<ConnectivityProvider>(
      builder: (context, connection, child) {
        return connection.isOnline
            ? child ?? Scaffold(body: Text('Error'))
            : Scaffold(
                body: Container(
                  height: height,
                  child: Center(
                    child: Text(
                      'No Internet Connection',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              );
      },
      child: SafeArea(
          child: WillPopScope(
              child: SafeArea(
                child: Scaffold(
                  body: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[AstroScreen(), DailyPanchangScreen()],
                  ),
                  bottomNavigationBar: Consumer<MainViewModel>(
                    builder: (context, model, child) {
                      return CustomBottomNavigationBar(
                        currentIndex: model.currentPage,
                        onTap: (index) {
                          index == model.currentPage
                              ? print('')
                              : _pageController?.jumpToPage(
                                  index,
                                );
                          model.changePage(index);
                        },
                        list: bottomNavItems,
                      );
                    },
                  ),
                ),
              ),
              onWillPop: goBack)),
    );
  }
}
