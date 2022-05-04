import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Widgets/maploadingwidget.dart';
import 'package:shimmer/shimmer.dart';

class Announceloading extends StatefulWidget {
  const Announceloading({Key? key}) : super(key: key);

  @override
  State<Announceloading> createState() => _AnnounceloadingState();
}

class _AnnounceloadingState extends State<Announceloading> {
  @override
  Widget build(BuildContext context) {
    var devicedata = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color(0xfff8f9fa),
      appBar: AppBar(
        backgroundColor: Color(0xfff8f9fa),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Proprety Deatails',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        // leading:
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Shimmer.fromColors(
            child: Container(
              color: Colors.black,
              width: double.infinity,
              height: devicedata.size.height * 0.5,
              padding: const EdgeInsets.all(10.0),
            ),
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(0.0),
        height: 70,
        child: ListTile(
          leading: CircleAvatar(
            foregroundColor: Colors.grey,
            backgroundColor: Colors.grey,
            child: Shimmer.fromColors(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black,
                ),
                
              ),
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.grey[300]!,
            ),
          ),
          title: const Text('Agency'),
          subtitle: Shimmer.fromColors(
              child: Container(
                height: 10,
                width: 20,
                color: Colors.black,
              ),
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.grey[300]!,),
        ),
      ),
    );
  }
}
