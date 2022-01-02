import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> list;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.list,
  }); // ValueChanged<int>

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.08,
      child: CupertinoTabBar(
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          onTap: onTap,
          activeColor: Colors.orange,
          inactiveColor: Colors.black45,
          items: list),
    );
  }
}

const List<BottomNavigationBarItem> bottomNavItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: ImageIcon(
      AssetImage(
        "assets/images/home.png",
      ),
    ),
  ),
  BottomNavigationBarItem(
    icon: ImageIcon(
      AssetImage(
        "assets/images/ask.png",
      ),
    ),
  ),
];
