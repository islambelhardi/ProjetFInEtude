// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Widgets/announcewidget.dart';

class AnnouncesRow extends StatefulWidget {
  const AnnouncesRow({ Key? key }) : super(key: key);

  @override
  _AnnouncesRowState createState() => _AnnouncesRowState();
}

class _AnnouncesRowState extends State<AnnouncesRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        scrollDirection: Axis.horizontal,
        children:  [
          AnnounceWidget(),
          AnnounceWidget(),
          AnnounceWidget(),
          AnnounceWidget(),
          AnnounceWidget(),  
        ],
      ),
    );
  }
}