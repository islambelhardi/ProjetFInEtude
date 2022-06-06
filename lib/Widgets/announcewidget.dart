// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:projet_fin_etude/Controllers/authcontroller.dart';
import 'package:projet_fin_etude/Controllers/connection.dart';
import 'package:projet_fin_etude/Controllers/usercontroller.dart';
import 'package:projet_fin_etude/Widgets/announcedetails.dart';
import 'package:http/http.dart' as http;

class AnnounceWidget extends StatefulWidget {
  final AnnounceId;
  final String title;
  final String img;
  final String roomnumber;
  final String surface;
  final String dealtype;
  final String price;
  AnnounceWidget(
      {Key? key,
      required this.AnnounceId,
      required this.title,
      required this.img,
      required this.roomnumber,
      required this.surface,
      required this.dealtype,
      required this.price})
      : super(key: key);

  late String herotag;
  @override
  _AnnounceWidgetState createState() => _AnnounceWidgetState();
}

class _AnnounceWidgetState extends State<AnnounceWidget> {
  bool isfavorite = false;
  Icon favorite = Icon(
    Icons.favorite_border_outlined,
    color: Colors.white,
  );

  //when u click the announce widget the announcedtails shows up
  void _gotoAnnounceDetails(BuildContext context) {
    pushNewScreen(
      context,
      screen: AnnounceDetails(
        announce_id: widget.AnnounceId,
      ),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  like() async {
    String? token = await AuthController.checklogin();
    if (token == null) {
      showDialog(context: context, builder: (_){
        return AlertDialog(
              content: Text('You have to login to like this announce'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(_).pop();
                  },
                ),
              ],
            );
      });
    } else {
      http.Response response = await UserController.like(widget.AnnounceId);
      if (response.statusCode == 200) {
        setState(() {
          isfavorite = true;
          favorite = Icon(
            Icons.favorite,
            color: Colors.red,
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('you already like this announce')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.AnnounceId,
      child: GestureDetector(
        onTap: () => _gotoAnnounceDetails(context),
        child: Container(
          height: 600,
          width: 280,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3.0,
                  blurRadius: 5.0)
            ],
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Card(
            color: Colors.white,
            elevation: 0,
            child: Container(
              height: 500,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Container(
                        height: 200,
                        padding: const EdgeInsets.all(6.0),
                        child: Image.network(
                          baseUrl + widget.img,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.withOpacity(0.5)),
                              child: Text(
                                'For ' + widget.dealtype,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff023e8a),
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 175, 175, 175),
                              radius: 16,
                              child: IconButton(
                                iconSize: 26,
                                padding: EdgeInsets.zero,
                                icon: favorite,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                color: Colors.grey,
                                onPressed: () {
                                  // to change the icon if u liked it or dislike it
                                  setState(() {
                                    if (isfavorite == true) {
                                      isfavorite = false;
                                      favorite = Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.white,
                                      );
                                    }
                                    like();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'DZD ' + widget.price + ' Millions',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.black45,
                        ),
                        Text(
                          'Tipaza,Algeria',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 10,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.bed,
                                  color: Colors.black45,
                                ),
                                Text(
                                  widget.roomnumber + 'Bedrooms',
                                  style: TextStyle(color: Colors.black45),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.fullscreen,
                                  color: Colors.black45,
                                ),
                                Text(
                                  widget.surface + 'm²',
                                  style: TextStyle(color: Colors.black45),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
