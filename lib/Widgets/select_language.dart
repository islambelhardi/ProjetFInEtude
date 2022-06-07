// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Routes/profilepage.dart';

class Select_Language extends StatefulWidget {
  Select_Language({Key? key}) : super(key: key);

  @override
  State<Select_Language> createState() => _Select_LanguageState();
}

enum OS { mac, windows, linux }

class _Select_LanguageState extends State<Select_Language> {
  OS? _os = OS.mac;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ProfilePage()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProfilePage()));
            },
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: ListView(children: [
            Text(
              "Language",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                      title: const Text('Mac'),
                      leading: Radio<OS>(
                        value: OS.mac,
                        groupValue: _os,
                        onChanged: (OS? value) {
                          setState(() {
                            _os = value;
                          });
                        },
                      )),
                  ListTile(
                      title: const Text('Windows'),
                      leading: Radio<OS>(
                        value: OS.windows,
                        groupValue: _os,
                        onChanged: (OS? value) {
                          setState(() {
                            _os = value;
                          });
                        },
                      )),
                  ListTile(
                      title: const Text('Linux'),
                      leading: Radio<OS>(
                        value: OS.linux,
                        groupValue: _os,
                        onChanged: (OS? value) {
                          setState(() {
                            _os = value;
                          });
                        },
                      )),
                ],
              ),
            )
          ])),
    );
  }
}
