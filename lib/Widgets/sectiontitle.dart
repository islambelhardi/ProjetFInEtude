// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

  Widget sectiontitle(title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
              onTap: () {
                
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

