// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Models/announce.dart';
import 'package:projet_fin_etude/Widgets/announcewidget.dart';

class AnnouncesRow extends StatelessWidget {
  final List<Announce> announces;
  const AnnouncesRow({Key? key, required this.announces}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 340,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemCount: announces.length,
            itemBuilder: (context, index) {
              final announce = announces[index];
              return AnnounceWidget(
                AnnounceId: announces[index].id,
                title: announces[index].title,
                img: announces[index].img,
                roomnumber: announces[index].roomnumber.toString(),
                surface: announces[index].surface.toString(),
                dealtype: announces[index].dealtype,
                price: announces[index].price.toString(),
              );
            }));
  }
}
