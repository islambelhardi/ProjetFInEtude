import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({ Key? key }) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child:Text('MessagesPage'),
      ),
    );
  }
}