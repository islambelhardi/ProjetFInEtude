// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({ Key? key }) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 15, 10,0),
      child: Card(
        child: Column(
          children: [
            Image.asset('Assets/images/banner.jpg', )
          ],
        ),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          ),
      ),

    );
  }
}