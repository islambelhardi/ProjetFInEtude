// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Routes/mainpage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:projet_fin_etude/translations/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        path: 'Assets/translations',
        supportedLocales: [
          Locale('en'),
          Locale('ar'),
          Locale('fr'),
        ],
        // <-- change the path of the translation files
        fallbackLocale: Locale('en', 'US'),
        assetLoader: CodegenLoader(),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        indicatorColor: Colors.blue,
        splashColor: Colors.grey,
      ),
      home: MainPage(),
    );
  }
}
