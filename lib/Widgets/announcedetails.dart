// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
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
    Image.asset('Assets/images/banner.jfif'),
    Image.asset('Assets/images/banner.jpg'),
    Image.asset('Assets/images/house.jfif'),
    Image.asset('Assets/images/house.png'),
    Image.asset('Assets/images/banner.jfif'),
    Image.asset('Assets/images/banner.jpg'),
    Image.asset('Assets/images/house.jfif'),
    Image.asset('Assets/images/house.png'),
    Image.asset('Assets/images/banner.jfif'),
    Image.asset('Assets/images/banner.jpg'),
    Image.asset('Assets/images/house.jfif'),
    Image.asset('Assets/images/house.png'),
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
      body:  ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: [
            Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    height: devicedata.size.height * 0.5,
                    child: PageView.builder(
                      itemCount: announceImages.length,
                      pageSnapping: true,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.all(10),
                            child: announceImages[index]);
                            // to display a loading gif while getting photos
                            // FadeInImage.assetNetwork(placeholder: 'Assets/images/loading.gif', image: 'https://picsum.photos/250?image=9')
                      },
                      onPageChanged: (index) => setState(() {
                        this.index = index;
                      }),
                    )),
                Center(
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
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    height: 40,
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
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'Location',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  height: devicedata.size.height * 0.2,
                  child: GoogleMap(
                    markers: mymarker,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Placeholder(
                  fallbackHeight: 150,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Placeholder(
                  fallbackHeight: 150,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'Comments',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Placeholder(
                  fallbackHeight: 150,
                ),
              ],
            ),
          ],
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
