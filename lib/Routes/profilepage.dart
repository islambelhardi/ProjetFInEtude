// ignore_for_file: non_constant_identifier_names, await_only_futures, unused_local_variable, sized_box_for_whitespace

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:projet_fin_etude/Controllers/authcontroller.dart';
import 'package:projet_fin_etude/Controllers/connection.dart';
import 'package:projet_fin_etude/Views/loginview.dart';
import 'package:projet_fin_etude/Widgets/editprofile.dart';
import 'package:projet_fin_etude/translations/local_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  Map user;
  ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                    child:  Center(
                      child: CircleAvatar(
                        backgroundImage: widget.user['image']==null? const AssetImage('Assets/images/user.png'):NetworkImage(baseUrl+widget.user['image'])as ImageProvider,
                        minRadius: 12,
                        maxRadius: 36,
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 100,
                      child: Center(
                        child: Text(
                          widget.user['name'],
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
              _profilelist(Icons.password_outlined, (LocaleKeys.change_password.tr()), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
              }),
              _profilelist(
                  Icons.settings_input_antenna_sharp, ("E-Statement"), () {}),
              // _profilelist(Icons.favorite, (LocaleKeys.Favorite.tr()), () {}),
              const Divider(
                color: Colors.black38,
              ),
              _profilelist(Icons.language, (LocaleKeys.Language.tr()), () {
                 showDialog(
                    context: context,
                    builder: (BuildContext dialogcontext) {
                      return AlertDialog(
                        title: Text('choose a language'),
                        content: Container(
                          height: 200,
                          child: Column(
                            children: [
                              TextButton(
                                  onPressed: () async {
                                    await context.setLocale(const Locale('ar'));
                                  },
                                  child: Text('العريبة Arabic')),
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

Widget _agencyprofile() {
  return const Scaffold();
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
