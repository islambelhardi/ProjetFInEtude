// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnounceDetails extends StatefulWidget {
  const AnnounceDetails({Key? key}) : super(key: key);

  @override
  _AnnounceDetailsState createState() => _AnnounceDetailsState();
}

class _AnnounceDetailsState extends State<AnnounceDetails> {
  List announceImages = [
    Image.asset('Assets/images/banner.jfif'),
    Image.asset('Assets/images/banner.jpg'),
    Image.asset('Assets/images/house.jfif'),
    Image.asset('Assets/images/house.png')
  ];
  int index = 0;
  bool _hasCallSupport = false;
  Future<void>? _launched;
  String _phone = '066472612';
  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunch('tel:123').then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 400,
                  child: GestureDetector(
                      // onHorizontalDragEnd: _ondragend,
                      onHorizontalDragUpdate: _ondragstart,
                      child: announceImages[index]),
                ),
                // carousel indicator
                Padding(
                  padding: const EdgeInsets.only(left:137,top: 10),
                  child: Row(
                    children: List.generate(announceImages.length, (indexDots) {
                      return Container(
                        margin: const EdgeInsets.only(right: 2),
                        height: 2,
                        width: index == indexDots ? 25 : 8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index == indexDots
                                ? Colors.blue
                                : Colors.blue.withOpacity(0.5)),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'House in Le Toquet-Paris Plage',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 1,
                  indent: 50,
                  endIndent: 50,
                ),
                SizedBox(
                  height: 500,
                ),
                Divider(
                  height: 20,
                  thickness: 1,
                  indent: 50,
                  endIndent: 50,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(0.0),
        height: 70,
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('Assets/images/avatar.png'),
          ),
          title: Text('Agency'),
          subtitle: Text('SARL Mobilier'),
          trailing: IconButton(
            iconSize: 30,
            color: Colors.blue,
            icon: Icon(Icons.phone),
            onPressed: _hasCallSupport
                ? () => setState(() {
                      _launched = _makePhoneCall(_phone);
                    })
                : null,
          ),
        ),
      ),
    );
  }

  void _ondragstart(DragUpdateDetails details) {
    if (details.primaryDelta! > 6.0) {
      setState(() {
        if (index >= 1) {
          index = index - 1;
        }
      });
    } else {
      setState(() {
        if (index < announceImages.length - 1) {
          index = index + 1;
        }
      });
    }
  }
}
