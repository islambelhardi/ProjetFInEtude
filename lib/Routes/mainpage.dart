// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Routes/favoritepage.dart';
import 'package:projet_fin_etude/Routes/messagespage.dart';
import 'package:projet_fin_etude/Routes/profilepage.dart';
import 'package:projet_fin_etude/Routes/searchpage.dart';


import 'homepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    int _selectedIndex = 0;
  // List of widgets the Navigationbar contains 
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavoritePage(),
    SearchPage(),
    MessagesPage(),
    ProfilePage()
  ];
  // method to change to the selected widget 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          // to display the selected page of the navigationbar
           child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.mail),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            )
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}