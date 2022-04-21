// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Modeks/announce.dart';
import 'package:projet_fin_etude/Widgets/announcewidget.dart';

// class AnnouncesRow extends StatefulWidget {
//   final List<Announce> announces;
//   const AnnouncesRow({ Key? key , required this.announces}) : super(key: key);

//   @override
//   _AnnouncesRowState createState() => _AnnouncesRowState();
// }

// class _AnnouncesRowState extends State<AnnouncesRow> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 350,
//       child: ListView.builder(
//         itemCount: ,
//         itemBuilder: (context,index){
//         final announce = announces[index];
//         return AnnounceWidget(title: title, img: img, roomnumber: roomnumber, surface: surface, dealtype: dealtype)
//       })
//     );
//   }
// }

// ListView(
//         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//         scrollDirection: Axis.horizontal,
//         children:  [
//           AnnounceWidget(),
//           AnnounceWidget(),
//           AnnounceWidget(),
//           AnnounceWidget(),
//           AnnounceWidget(),
//         ],
//       ),
class AnnouncesRow extends StatelessWidget {
  final List<Announce> announces;
  const AnnouncesRow({Key? key, required this.announces}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemCount: announces.length,
            itemBuilder: (context, index) {
              final announce = announces[index];
              return AnnounceWidget(
                title: announces[index].title,
                img: 'Announcesimages/1827782094.jpg',
                roomnumber: announces[index].roomnumber.toString(),
                surface: announces[index].surface.toString(),
                dealtype: announces[index].dealtype,
                price: announces[index].price.toString(),
              );
            }));
  }
}
