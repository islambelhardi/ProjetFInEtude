import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Routes/mainpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.orange.shade100,
        indicatorColor: Colors.blue,
        splashColor: Colors.grey,
        //navigationBarTheme: ,
      ),
      home: const MainPage(),
    );
  }
}

