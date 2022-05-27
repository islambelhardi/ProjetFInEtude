import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Models/announce.dart';
import 'package:projet_fin_etude/Views/announceHview.dart';

class AnnounceColumn extends StatelessWidget {
  final List<Announce> announces;
  const AnnounceColumn({Key? key, required this.announces}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: announces.isEmpty
            ? const Center(child: Text('no announces founded'))
            : ListView.builder(
              itemCount: announces.length,
              itemBuilder: (context, index) {
                return AnnounceHview(
                  AnnounceId: announces[index].id,
                  title: announces[index].title,
                  img: announces[index].img,
                  roomnumber: announces[index].roomnumber.toString(),
                  surface: announces[index].surface.toString(),
                  dealtype: announces[index].dealtype,
                  price: announces[index].price.toString(),
                  propretytype: announces[index].propretytype,
                );
              }),
      ),
    );
  }
}
