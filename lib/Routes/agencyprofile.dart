import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Controllers/authcontroller.dart';
import 'package:projet_fin_etude/Controllers/usercontroller.dart';
import 'package:projet_fin_etude/Routes/profilepage.dart';
import 'package:projet_fin_etude/Views/loginview.dart';
import 'package:projet_fin_etude/Widgets/addannouncewidget.dart';
import 'package:projet_fin_etude/Widgets/announcecolumn.dart';
import 'package:projet_fin_etude/Widgets/editpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/connection.dart';
import '../Models/announce.dart';
import '../Widgets/editprofile.dart';
import '../translations/local_keys.g.dart';

class AgencyProfilePage extends StatefulWidget {
  Map agency;
  AgencyProfilePage({Key? key, required this.agency}) : super(key: key);

  @override
  State<AgencyProfilePage> createState() => _AgencyProfilePageState();
}

class _AgencyProfilePageState extends State<AgencyProfilePage> {
  var announcelist = <Announce>[];
  loadagencyannounces() async {
    http.Response response = await UserController.myannounces();
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      try {
        announcelist = list.map((model) => Announce.fromJson(model)).toList();
      } catch (e) {}
    } else {}
  }

  Logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = await pref.getString("access token");
    http.Response response = await AuthController.logout(token!);
    bool cleared = await pref.clear();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginView()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: CircleAvatar(
                        backgroundImage:
                            widget.agency['image']==null? const AssetImage('Assets/images/user.png'):NetworkImage(baseUrl+widget.agency['image'])as ImageProvider,
                        minRadius: 12,
                        maxRadius: 36,
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 100,
                      child: Center(
                        child: Text(
                          widget.agency['name'],
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
              const Divider(
                color: Colors.black26,
              ),
              _profilelist(Icons.person, (LocaleKeys.Modifier_profil.tr()), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
              }),
              _profilelist(Icons.password_outlined, ("Change Password"), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditPassword()));
              }),
              _profilelist(Icons.add_circle, ("Add Announce"), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddAnnounceWidget()));
              }),
              _profilelist(Icons.list_outlined, ("My Announces"), () async {
                await loadagencyannounces();
                print(announcelist.length);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnnounceColumn(
                              announces: announcelist,
                              redirect: true,
                            )));
              }),
              const Divider(
                color: Colors.black38,
              ),
              _profilelist(Icons.language, (LocaleKeys.Language.tr()), () {
                showDialog(
                    context: context,
                    builder: (BuildContext dialogcontext) {
                      return AlertDialog(
                        title: Text('choose a language'),
                        content: Column(
                          children: [
                            TextButton(
                                onPressed: () async {
                                  await context.setLocale(const Locale('ar'));
                                },
                                child: Text('?????????????? Arabic')),
                            TextButton(
                                onPressed: () async {
                                  await context.setLocale(Locale('en'));
                                },
                                child: Text('English')),
                            TextButton(
                                onPressed: () async {
                                  await context.setLocale(Locale('fr'));
                                },
                                child: Text('Francais')),
                          ],
                        ),
                      );
                    });
              }),
              _profilelist(Icons.comment_outlined, (LocaleKeys.Our_Handbook.tr()), () {}),
              _profilelist(Icons.logout, (LocaleKeys.Log_out.tr()), () => Logout()),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _profilelist(icon, text, press) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    child: TextButton(
      style: TextButton.styleFrom(
        primary: Colors.black87,
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: const Color(0xFFF5F6F9),
      ),
      onPressed: press,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 20),
          Expanded(child: Text(text)),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    ),
  );
}
