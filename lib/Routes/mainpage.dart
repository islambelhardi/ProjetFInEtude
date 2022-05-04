// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Routes/favoritepage.dart';
import 'package:projet_fin_etude/Routes/messagespage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:projet_fin_etude/Views/loginview.dart';
import 'package:projet_fin_etude/Views/sigupview.dart';
import 'package:projet_fin_etude/custom_icon_icons.dart';
import 'explorepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  Icon home = Icon(Icons.search);
  Icon favorite = Icon(Icons.favorite);
  Icon inbox = Icon(Icons.chat_bubble);
  Icon profile = Icon(Icons.person);
  List<Widget> _buildScreens() {
    return [
      HomePage(),
      FavoritePage(),
      MessagesPage(),
      LoginView(),
    ];
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search_outlined),
        title: ("Explorer"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black87,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: Icon(Icons.favorite_border_rounded),
        icon: Icon(Icons.favorite),
        title: ("Favorite"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black87,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: Icon(Icons.chat_bubble_outline),
        icon: Icon(Icons.chat_bubble),
        title: ("Message"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black87,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: Icon(Icons.person_outline_rounded),
        icon: Icon(Icons.person_rounded),
        title: ("Profile"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black87,
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
      backgroundColor: Color(0xfff8f9fa), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
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
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
