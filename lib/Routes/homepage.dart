// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Widgets/announcesrow.dart';
import 'package:projet_fin_etude/Widgets/betweenrows.dart';
import 'package:projet_fin_etude/Widgets/headerwidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: ListView(
        children: [
          HeaderWidget(),
          BetweenRow(),
          AnnouncesRow(),
          BetweenRow(),
          AnnouncesRow(),
        ],
      ),
    );
  }
}
