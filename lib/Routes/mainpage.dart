// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Routes/favoritepage.dart';
import 'package:projet_fin_etude/Routes/messagespage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:projet_fin_etude/Routes/profilepage.dart';

import 'package:projet_fin_etude/Views/loginview.dart';
import 'package:projet_fin_etude/Views/sigupview.dart';
import 'package:projet_fin_etude/publier_un_announce/ajouterannonce.dart';
import 'package:projet_fin_etude/translations/local_keys.g.dart';
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
      First_page_publier(),
      ProfilePage(),
    ];
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: (LocaleKeys.Home.tr()),
        // activeColorPrimary: Color.activeBlue,
        // inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: Icon(Icons.favorite_border_outlined),
        icon: Icon(Icons.favorite),
        title: (LocaleKeys.Setting.tr()),
        // activeColorPrimary: CupertinoColors.activeBlue,
        // inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message_outlined),
        title: (LocaleKeys.message.tr()),
        // activeColorPrimary: CupertinoColors.activeBlue,
        // inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_outlined),
        title: (LocaleKeys.Favorite.tr()),
        // activeColorPrimary: CupertinoColors.activeBlue,
        // inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  // List of widgets the Navigationbar contains
  // static List<Widget> _widgetOptions = <Widget>[
  //   HomePage(),
  //   FavoritePage(),
  //   MessagesPage(),
  //   LoginView(),
  // ];
  // method to change to the selected widget
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
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
          NavBarStyle.style3, // Choose the nav bar style with this property.
    );
    // Scaffold(
    //   body: Center(
    //     // to display the selected page of the navigationbar
    //     child: _widgetOptions.elementAt(_selectedIndex),
    //   ),
    //   bottomNavigationBar: BottomNavigationBar(
    //     type: BottomNavigationBarType.fixed,
    //     selectedItemColor: Colors.black,
    //     backgroundColor: Colors.white,
    //     items: [
    //       BottomNavigationBarItem(
    //         icon: _selectedIndex == 0 ? home : const Icon(Icons.search),
    //         label: 'Explore ',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: _selectedIndex == 1
    //             ? favorite
    //             : Icon(Icons.favorite_border_outlined),
    //         label: 'Favorite',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: _selectedIndex == 2
    //             ? inbox
    //             : const Icon(Icons.chat_bubble_outline),
    //         label: 'Messages',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: _selectedIndex == 3 ? profile : Icon(Icons.person_outlined),
    //         label: 'Profile',
    //       )
    //     ],
    //     currentIndex: _selectedIndex,
    //     onTap: _onItemTapped,
    //   ),
    // );
  }
}
