// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:projet_fin_etude/Widgets/modifyannouncewidget.dart';
import 'package:projet_fin_etude/translations/local_keys.g.dart';

import '../Controllers/connection.dart';
import '../Widgets/announcedetails.dart';

class AnnounceHview extends StatefulWidget {
  final AnnounceId;
  final String title;
  final String img;
  final String roomnumber;
  final String surface;
  final String dealtype;
  final String price;
  final String propretytype;
  bool? redirect;
  AnnounceHview(
      {Key? key,
      this.redirect,
      required this.AnnounceId,
      required this.title,
      required this.img,
      required this.roomnumber,
      required this.surface,
      required this.dealtype,
      required this.price,
      required this.propretytype})
      : super(key: key);

  @override
  State<AnnounceHview> createState() => _AnnounceHviewState();
}

class _AnnounceHviewState extends State<AnnounceHview> {
  bool isfavorite = false;
  Icon favorite = Icon(
    Icons.favorite_rounded,
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
  void _gotoModifyDetails(BuildContext context){
    pushNewScreen(
      context,
      screen: ModifyAnnounceWidget(
        announce_id: widget.AnnounceId,
      ),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.redirect==true){
          _gotoModifyDetails(context);
        }else{
          _gotoAnnounceDetails(context);
        }
      } ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
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
            elevation: 0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Image.network(
                      baseUrl + widget.img,
                      fit: BoxFit.fill,
                      height: 150,
                      width: double.maxFinite,
                    ),
                    // Image.asset(
                    //   'Assets/images/house.jpeg',
                    //   fit: BoxFit.cover,
                    //   height: 150,
                    //   width: double.maxFinite,
                    // ),
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
                                color: Colors.grey.withOpacity(0.6)),
                            child: Text(
                              widget.dealtype,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff023e8a),
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: IconButton(
                            icon: favorite,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            color: Colors.grey,
                            onPressed: () {
                              // to change the icon if u liked it or dislike it
                              setState(() {
                                if (isfavorite == true) {
                                  isfavorite = false;
                                  favorite =
                                      Icon(Icons.favorite_border_outlined);
                                } else {
                                  isfavorite = true;
                                  favorite = Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  );
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    color: Colors.white,
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.price + '\$',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        // Text(
                        //   '1,098.00 USD',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Icon(
                        //       Icons.location_on,
                        //       color: Colors.black45,
                        //     ),
                        //     Text(
                        //       '34353 Newcastle, Calabasas, Calofornia',
                        //       style: TextStyle(color: Colors.black87),
                        //     ),
                        //   ],
                        // ),

                        Container(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 10,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.house_outlined,
                                        color: Colors.black45,
                                      ),
                                      Text(
                                        widget.propretytype,
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.bed,
                                        color: Colors.black45,
                                      ),
                                      Text(
                                        widget.roomnumber + LocaleKeys.Rooms.tr(),
                                        style: TextStyle(color: Colors.black45),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.fullscreen,
                                        color: Colors.black45,
                                      ),
                                      Text(
                                        widget.surface + LocaleKeys.m.tr(),
                                        style: TextStyle(color: Colors.black45),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Row(
                        //       children: [
                        //         Icon(Icons.bed_outlined),
                        //         Text('2'),
                        //       ],
                        //     ),
                        //     Row(
                        //       children: [
                        //         Icon(
                        //           Icons.bathtub_outlined,
                        //         ),
                        //         Text('1'),
                        //       ],
                        //     ),
                        //     Row(
                        //       children: [
                        //         Icon(Icons.bathroom),
                        //         Text('200 m²'),
                        //       ],
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
