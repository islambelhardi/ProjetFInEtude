// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Routes/searchpage.dart';
import 'package:projet_fin_etude/Widgets/announcedetails.dart';
import 'package:projet_fin_etude/Widgets/announcesrow.dart';
import 'package:projet_fin_etude/Widgets/sectiontitle.dart';
import 'package:projet_fin_etude/Widgets/headerwidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xfff8f9fa),
          body: CustomScrollView(
            slivers: [
              // app bar that shows a banner and search button
              SliverAppBar(
                // backgroundColor: Colors.black,
                backgroundColor: Color(0xfff8f9fa),
                expandedHeight: 295,
                toolbarHeight: 80,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset('Assets/images/Discover.png'),
                ),
                pinned: true,
                elevation: 0,
                centerTitle: true,
                // made the title a search button
                title: Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 40),
                  child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      label: Text(
                        'What are you looking for ?',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        elevation: 0.5,
                        primary: Colors.white,
                        fixedSize: Size(400, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        // backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const SearchPage(),
                            ),
                          )),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                sectiontitle(
                  'Popular',
                ),
                AnnouncesRow(),
                sectiontitle(
                  'For Rent',
                ),
                AnnouncesRow(),
                SizedBox(
                  height: 30,
                )
              ]))
            ],
          )),
    );
  }
}
