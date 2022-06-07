// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Controllers/authcontroller.dart';
import 'package:http/http.dart' as http;
import 'package:projet_fin_etude/Controllers/connection.dart';
import 'package:projet_fin_etude/Views/announceHview.dart';
import 'package:projet_fin_etude/Views/loginview.dart';
import 'package:projet_fin_etude/Widgets/announcecolumn.dart';

import '../Models/announce.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool isloged = false;
  checklogin() async {
    String? token = await AuthController.checklogin();
    if (token != null) {
      setState(() {
        isloged = true;
      });
    } else {
      setState(() {
        isloged = false;
      });
    }
  }

  var likedlist = <Announce>[];
  getlikedannounces() async {
    String? token = await AuthController.checklogin();
    if (token != null) {
      var url = Uri.parse(baseUrl + 'api/likes');
      Map<String, String> headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Authorization': 'Bearer $token',
        'Charset': 'utf-8'
      };
      var response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        try {
          likedlist = list.map((model) => Announce.fromJson(model)).toList();
          setState(() {
            likedlist;
          });
        } catch (e) {
          print(e);
        }
      } else {
        setState(() {
          likedlist = [];
        });
      }
    } else {
      return null;
    }
  }

  Widget? body;
  Future<Widget?> showbody() async {
    await checklogin();
    await getlikedannounces();
    if (isloged == false) {
      body = Center(
        child: Column(
          children: [
            const Text('Log in to view your wishlists'),
            const Text('You can create, view, or edit Wishlists once you'
                've logged in'),
            ElevatedButton(
                onPressed: () {
                  _key.currentState!.openEndDrawer();
                },
                child: Text('Log in')),
          ],
        ),
      );
    } else {
      if (likedlist.length == 0) {
        body = Center(child: Text('No liked Announces'));
      } else {
        body = AnnounceColumn(announces: likedlist);
      }
    }
    return body;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checklogin();
    // getlikedannounces();
    showbody();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  bool isfavorite = false;
  Icon favorite = Icon(
    Icons.favorite_rounded,
    color: Colors.white,
  );

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawerEnableOpenDragGesture: false,
        key: _key,
        endDrawer: customdrawer(BuildContext, _closeEndDrawer),
        backgroundColor: Color(0xfff8f9fa),
        appBar: AppBar(
          actions: <Widget>[Container()],
          backgroundColor: Color(0xfff8f9fa),
          elevation: 0,
          title: Text(
            'Wishlists',
            style: TextStyle(color: Colors.black),
          ),
        ),
        // check if the user is logged if not list of instruction and button of login shows
        body: body == null
            ? Center(
                child: Container(
                child: CircularProgressIndicator(),
              ))
            : body);
  }
}

Widget customdrawer(BuildContext, Function()? closeEndDrawer) {
  return Container(
    width: double.infinity,
    child: Drawer(
      child: Center(
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(
                    Icons.close_outlined,
                    color: Colors.black,
                  ),
                  onPressed: closeEndDrawer,
                ),
              ),
              body: LoginView(
                redirect: false,
              )),
        ),
      ),
    ),
  );
}
