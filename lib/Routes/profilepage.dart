import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:projet_fin_etude/Routes/mainpage.dart';
import 'package:projet_fin_etude/Controllers/authcontroller.dart';
import 'package:projet_fin_etude/Views/loginview.dart';
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
    print(cleared);
    // print(json.decode(response.body));
    Navigator.of(context).pop();
    // pushNewScreen(
    //   context,
    //   screen: LoginView(),
    //   withNavBar: true, // OPTIONAL VALUE. True by default.
    //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
    // );
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
                            'https://scontent.fogx1-2.fna.fbcdn.net/v/t39.30808-6/230343407_1439909299727515_7988115582448082082_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeFHu2J1N3AKQO0mMETWDqYBTLDW3V8kRbZMsNbdXyRFtnm3xfWvVvKeNA0_KSLHsv_fGjMeEHE3qITSpBsjifJc&_nc_ohc=fzkfEiCMLJUAX_qTi3p&tn=eoS-ofEnYkm8WG9a&_nc_ht=scontent.fogx1-2.fna&oh=00_AT8YXlLUoIj4SB9VCoHPyBzDy3BfU43xkWC5ZwkamcUmUw&oe=624CA209'),
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
              _profilelist(Icons.person, ("Personal Data"), () {}),
              _profilelist(Icons.settings, ("Settings"), () {}),
              _profilelist(
                  Icons.settings_input_antenna_sharp, ("E-Statement"), () {}),
              _profilelist(Icons.favorite, ("Favorite"), () {}),
              Divider(
                color: Colors.black38,
              ),
              _profilelist(Icons.language, ("Language"), () {}),
              _profilelist(Icons.comment_outlined, ("Our Handbook"), () {}),
              _profilelist(Icons.logout, ("Log Out"), () => Logout()),
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
