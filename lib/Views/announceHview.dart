// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AnnounceHview extends StatefulWidget {
  const AnnounceHview({Key? key}) : super(key: key);

  @override
  State<AnnounceHview> createState() => _AnnounceHviewState();
}

class _AnnounceHviewState extends State<AnnounceHview> {
  bool isfavorite = false;
  Icon favorite = Icon(
    Icons.favorite_rounded,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  Image.asset(
                    'Assets/images/house.jpeg',
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.maxFinite,
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
                              color: Colors.grey.withOpacity(0.6)),
                          child: Text(
                            'For Rent',
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
                                favorite = Icon(Icons.favorite_border_outlined);
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
                      // Text(
                      //   '1,098.00 USD',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.black45,
                          ),
                          Text(
                            '34353 Newcastle, Calabasas, Calofornia',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ],
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
                                  children: const [
                                    Icon(
                                      Icons.house_outlined,
                                      color: Colors.black45,
                                    ),
                                    Text(
                                      'Appartement',
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
                                      '4 Bedrooms',
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
    );
  }
}
