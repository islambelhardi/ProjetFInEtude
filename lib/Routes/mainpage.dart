// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Routes/favoritepage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:projet_fin_etude/Views/loginview.dart';
import 'package:projet_fin_etude/translations/local_keys.g.dart';
import 'explorepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _buildScreens() {
    return [
      HomePage(),
      FavoritePage(),     
      LoginView(),
    ];
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveIcon: Icon(Icons.home_rounded),
        icon: Icon(
          Icons.home_rounded,
        ),
        title: (LocaleKeys.Home.tr()),
        activeColorPrimary: Color.fromRGBO(255, 255, 255, 1),
        inactiveColorPrimary: Color.fromRGBO(204, 219, 220, 1),
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: Icon(Icons.favorite_outline_rounded),
        icon: Icon(Icons.favorite_rounded),
        title: (LocaleKeys.Favorite.tr()),
        activeColorPrimary: Color.fromRGBO(255, 255, 255, 1),
        inactiveColorPrimary: Color.fromRGBO(204, 219, 220, 1),
      ),
      
      PersistentBottomNavBarItem(
        inactiveIcon: Icon(
          Icons.person_outline_rounded,
          size: 28,
        ),
        icon: Icon(Icons.person_rounded),
        title: (LocaleKeys.Personal_data.tr()),
        activeColorPrimary: Color.fromRGBO(255, 255, 255, 1),
        inactiveColorPrimary: Color.fromRGBO(204, 219, 220, 1),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Color.fromRGBO(20, 33, 61, 1),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: false,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.transparent,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style8, // Choose the nav bar style with this property.
    );
  }
}
