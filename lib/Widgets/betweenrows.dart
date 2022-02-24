// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class BetweenRow extends StatefulWidget {
   const BetweenRow({Key? key}) : super(key: key);
  @override
  _BetweenRowState createState() => _BetweenRowState();
}

class _BetweenRowState extends State<BetweenRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Villa',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 270,
          ),
          GestureDetector(
              onTap: () {
                print('taped');
              },
              child: Text(
                'View All',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
