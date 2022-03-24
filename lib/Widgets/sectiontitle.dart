// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Sectiontitle extends StatefulWidget {
  const Sectiontitle({Key? key}) : super(key: key);
  @override
  _SectiontitleState createState() => _SectiontitleState();
}

class _SectiontitleState extends State<Sectiontitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Popular',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
              onTap: () {
                print('taped');
              },
              child: Text(
                'more',
                style: TextStyle(
                    color: Color(0xff9E6945), fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
