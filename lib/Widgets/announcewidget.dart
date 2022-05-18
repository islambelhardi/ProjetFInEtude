// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Widgets/announcedetails.dart';
import 'package:projet_fin_etude/translations/local_keys.g.dart';

class AnnounceWidget extends StatefulWidget {
  AnnounceWidget({Key? key}) : super(key: key);
  late String herotag;
  @override
  _AnnounceWidgetState createState() => _AnnounceWidgetState();
}

class _AnnounceWidgetState extends State<AnnounceWidget> {
  bool isfavorite = false;
  Icon favorite = Icon(
    Icons.favorite_rounded,
    color: Colors.white,
  );

  //when u click the announce widget the announcedtails shows up
  void _gotoAnnounceDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const AnnounceDetails(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'herotag',
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
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Image.asset('Assets/images/house.jfif'),
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
                                LocaleKeys.For_rent.tr(),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'House in Le Toquet-Paris Plage',
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
                          'DZD 300 Million',
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
                          'Newcastle,Calofornia',
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
                                  LocaleKeys.Badroom.tr(),
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
                                  '200 sqft',
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
