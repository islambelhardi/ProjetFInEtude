// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Controllers/announcecontroller.dart';
import 'package:projet_fin_etude/Models/announce.dart';
import 'package:projet_fin_etude/Routes/searchpage.dart';

import 'package:projet_fin_etude/Widgets/announcesrow.dart';

import 'package:projet_fin_etude/Widgets/sectiontitle.dart';
import 'package:projet_fin_etude/translations/local_keys.g.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getrentannounces();
    _getsellannounces();
  }

  var rentinglist = <Announce>[];
  _getrentannounces() {
    AnnounceController().getAnnouncesdetails('forrent').then((response) {
      Iterable list = json.decode(response.body);
      try {
        rentinglist = list.map((model) => Announce.fromJson(model)).toList();
      } catch (e) {
        print(e);
      }
      print(response.body);
      setState(() {});
    });
  }

  var sellinglist = <Announce>[];
  _getsellannounces() {
    AnnounceController().getAnnouncesdetails('forsell').then((response) {
      Iterable list = json.decode(response.body);
      try {
        sellinglist = list.map((model) => Announce.fromJson(model)).toList();
      } catch (e) {
        // print(e);
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          body: RefreshIndicator(
            onRefresh: () async{
              _getrentannounces();
              _getsellannounces();
              throw'null';
            },
            child: CustomScrollView(
              slivers: [
                // app bar that shows a banner and search button
                SliverAppBar(
                  // backgroundColor: Colors.black,
                  backgroundColor: Color(0xfff8f9fa),
                  expandedHeight: 270,
                  toolbarHeight: 80,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset('Assets/images/Discover.png',fit: BoxFit.fill,),
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
                          LocaleKeys.What_are_you_looking_for.tr(),
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
                    LocaleKeys.For_rent.tr()
                  ),
                  AnnouncesRow(announces: rentinglist),
                  sectiontitle(
                    LocaleKeys.A_vendre.tr()
                  ),
                  AnnouncesRow(announces: sellinglist),
                ]))
              ],
            ),
          )),
    );
  }
}
