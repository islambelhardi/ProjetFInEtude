// ignore_for_file: prefer_const_constructors

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
                    child: Card(
                      elevation: 0.5,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
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
                                          favorite = Icon(
                                              Icons.favorite_border_outlined);
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
                            Padding(
                              padding: const EdgeInsets.only(left: 10 , bottom: 10),
                              child: Container(
                                color: Colors.white,
                                height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.house_outlined),
                                        Text('Appartement'),
                                      ],
                                    ),
                                    Text(
                                      '1,098.00 USD',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('34353 Newcastle, Calabasas, Calofornia'),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.bed_outlined),
                                            Text('2'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.bathtub_outlined,
                                            ),
                                            Text('1'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.bathroom),
                                            Text('200 m²'),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                  );
  }
}
