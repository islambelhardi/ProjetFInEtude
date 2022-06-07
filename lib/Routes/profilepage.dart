// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:projet_fin_etude/Routes/edit_profile_page.dart';
import 'package:projet_fin_etude/Routes/mainpage.dart';
import 'package:projet_fin_etude/Controllers/authcontroller.dart';
import 'package:projet_fin_etude/Views/loginview.dart';
import 'package:projet_fin_etude/Widgets/select_language.dart';
import 'package:projet_fin_etude/translations/local_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = await pref.getString("access token");
    http.Response response = await AuthController.logout(token!);
    bool cleared = await pref.clear();
    pushNewScreen(
      context,
      screen: LoginView(),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://scontent.fogx1-1.fna.fbcdn.net/v/t1.6435-9/80389008_464366174489481_380651642795589632_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeE-ASAJ3WrGoRMsG1fMdE2qDD6YTYl6PVMMPphNiXo9UznoV1VEB_WJPVV2Ugw3wnb3YqlK7KkjgpnvwRhlyPDi&_nc_ohc=Ez67yqI-_qsAX_0uz8q&_nc_ht=scontent.fogx1-1.fna&oh=00_AT_WW1siVeEO_a4WEC56NWJ2nYRoYYYgHmb9CYDl1hFUQg&oe=62895683'),
                        minRadius: 12,
                        maxRadius: 36,
                      ),
                    ),
                  ),
                  Container(
                      height: 100,
                      child: Center(
                        child: Text(
                          "Gouder Haithem",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
              Divider(
                color: Colors.black26,
              ),
              _profilelist(Icons.person, (LocaleKeys.Personal_data.tr()), () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => EditProfilePage()));
              }),
              _profilelist(Icons.settings, (LocaleKeys.Setting.tr()), () {}),
              _profilelist(Icons.settings_input_antenna_sharp,
                  (LocaleKeys.Statment.tr()), () {}),
              _profilelist(Icons.favorite, (LocaleKeys.Favorite.tr()), () {}),
              Divider(
                color: Colors.black38,
              ),
              _profilelist(Icons.language, (LocaleKeys.Language.tr()), () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Select_Language()));
              }),
              _profilelist(Icons.comment_outlined,
                  (LocaleKeys.Our_Handbook.tr()), () {}),
              _profilelist(
                  Icons.logout, (LocaleKeys.Log_out.tr()), () => Logout()),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _profilelist(icon, text, press) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    child: TextButton(
      style: TextButton.styleFrom(
        primary: Colors.black87,
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Color(0xFFF5F6F9),
      ),
      onPressed: press,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 20),
          Expanded(child: Text(text)),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    ),
  );
}
