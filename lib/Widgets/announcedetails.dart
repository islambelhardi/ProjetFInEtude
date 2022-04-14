// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:projet_fin_etude/Widgets/announcewidget.dart';
import 'package:projet_fin_etude/Widgets/comment.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AnnounceDetails extends StatefulWidget {
  const AnnounceDetails({Key? key}) : super(key: key);

  @override
  _AnnounceDetailsState createState() => _AnnounceDetailsState();
}

class _AnnounceDetailsState extends State<AnnounceDetails> {
  List announceImages = [
    AssetImage('Assets/images/banner.jpg'),
    AssetImage('Assets/images/house.jfif'),
    AssetImage('Assets/images/house.png'),
    AssetImage('Assets/images/banner.jfif'),
    AssetImage('Assets/images/banner.jpg'),
    AssetImage('Assets/images/house.jfif'),
    AssetImage('Assets/images/house.png'),
  ];
  int index = 0;
  bool _hasCallSupport = false;
  Future<void>? _launched;
  String _phone = '066472612';
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

  //=================
  //map things
  //==============
  late Position cl;
  late CameraPosition _kGooglePlex;
  late Set<Marker> mymarker;
  var lat;
  var lang;
  var place;
  var country;
  late List<Placemark> placemarks;

  Future getposition() async {
    bool services;
    LocationPermission per;

    services = await Geolocator.isLocationServiceEnabled();
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    return per;
  }

  Future<void> getLatAndLang() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);

    lat = cl.latitude;
    lang = cl.longitude;

    _kGooglePlex = CameraPosition(
      target: LatLng(lat, lang),
      zoom: 14.4746,
    );
    mymarker = {
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(lat, lang),
      )
    };
    placemarks = await placemarkFromCoordinates(lat, lang);
    place = placemarks[0].locality;
    country = placemarks[0].country;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunch('tel:123').then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
    getposition();
    getLatAndLang();
  }

  Completer<GoogleMapController> _controller = Completer();
  //======================
  // end map thing
  //=======================
  //alert dialog function
  TextEditingController _textFieldController = TextEditingController();

  comment_alert(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add comment'),
            content: TextField(
              decoration: InputDecoration(hintText: "Add new comment"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Add'),
                onPressed: () {},
              ),
              FlatButton(
                child: new Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

//end allert dialog function
  final controller = PageController(viewportFraction: 1, keepPage: true);

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
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(8),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: double.infinity,
                    height: devicedata.size.height * 0.5,
                    child: PageView.builder(
                        controller: controller,
                        itemCount: announceImages.length,
                        pageSnapping: true,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image(
                              image: announceImages[i],
                              fit: BoxFit.cover,
                              height: 200,
                              width: 250,
                            ),
                          );
                        })),
                SmoothPageIndicator(
                  controller: controller,
                  count: announceImages.length,
                  effect: ScrollingDotsEffect(
                    activeStrokeWidth: 2.6,
                    activeDotScale: 1.3,
                    maxVisibleDots: 5,
                    radius: 8,
                    spacing: 7,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'House in Le Toquet-Paris Plage',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 40,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.bed,
                                ),
                                Text('4 Bedrooms')
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.bed,
                                ),
                                Text('200 sqft')
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    height: devicedata.size.height * 0.5,
                    child: lat == null
                        ? SizedBox(
                            height: 16,
                            width: 16,
                            child: Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                            )))
                        : GoogleMap(
                            markers: mymarker,
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          ),
                  ),
                ),
              ],
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Properties Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(
                      height: devicedata.size.width * 0.03,
                    ),
                    Text(
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ).copyWith(color: Color(0xff94959b)),
                    )
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    Row(children: [
                      Text('Comments',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ]),
                    SizedBox(
                      height: devicedata.size.width * 0.03,
                    ),
                    Comment(),
                    Container(
                        width: double.infinity,
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, // Background color
                          ),
                          child: const Text('Add new comment +',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              )),
                          onPressed: () => comment_alert(context),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(0.0),
        height: 70,
        color: Color(0xfff8f9fa),
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
}
