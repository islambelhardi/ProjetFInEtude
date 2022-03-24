// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Routes/favoritepage.dart';
import 'package:projet_fin_etude/Routes/messagespage.dart';
import 'package:projet_fin_etude/Routes/profilepage.dart';
import 'package:projet_fin_etude/Routes/searchpage.dart';


import 'explorepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    int _selectedIndex = 0;
    Icon home = Icon(Icons.search);
    Icon favorite = Icon(Icons.favorite);
    Icon inbox= Icon(Icons.chat_bubble);
    Icon profile= Icon(Icons.person);
  // List of widgets the Navigationbar contains 
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavoritePage(),
    //SearchPage(),
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
    return  Scaffold(
        body: Center(
          // to display the selected page of the navigationbar
           child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: _selectedIndex==0 ? home :const Icon(Icons.search),
              label: 'Explore ',
              
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex==1 ? favorite :Icon(Icons.favorite_border_outlined),
              label: 'Favorite',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon( Icons.search_outlined,),
            //   label: 'Search',
            // ),
            BottomNavigationBarItem(
              icon: _selectedIndex==2 ? inbox :const Icon(Icons.chat_bubble_outline),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex==3 ? profile :Icon(Icons.person_outlined),
              label: 'Profile',
            )
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      
    );
  }
}