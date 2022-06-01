import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projet_fin_etude/Routes/agencyprofile.dart';
import 'package:projet_fin_etude/Routes/mainpage.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:projet_fin_etude/Routes/searchpage.dart';
import 'package:projet_fin_etude/Widgets/addannouncewidget.dart';
import 'package:projet_fin_etude/Widgets/announcedetails.dart';
import 'package:projet_fin_etude/Widgets/editprofile.dart';
import 'package:projet_fin_etude/Widgets/filterannouncesheet.dart';

late Box box;
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
            
            useMaterial3: true),
        home: SearchPage());
  }
}
