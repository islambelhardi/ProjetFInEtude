// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AnnounceDetails extends StatefulWidget {
  const AnnounceDetails({Key? key}) : super(key: key);

  @override
  _AnnounceDetailsState createState() => _AnnounceDetailsState();
}

class _AnnounceDetailsState extends State<AnnounceDetails> {
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
    print(lat);
    print(lang);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getposition();
    getLatAndLang();
  }

  Completer<GoogleMapController> _controller = Completer();
  //======================
  // end map thing
  //=======================

  List announceImages = [
    Image.asset('Assets/images/banner.jpg'),
    Image.asset('Assets/images/house.jfif'),
    Image.asset('Assets/images/house.png'),
    Image.asset('Assets/images/banner.jfif'),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var devicedata = MediaQuery.of(context);
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
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  height: devicedata.size.height * 0.5,
                  child: PageView.builder(
                      itemCount: announceImages.length,
                      pageSnapping: true,
                      itemBuilder: (context, i) {
                        return Container(
                            margin: EdgeInsets.all(10),
                            child: announceImages[i]);
                      })),
              Text(
                'House in Le Toquet-Paris Plage',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Divider(
                height: 20,
                thickness: 1,
                indent: 50,
                endIndent: 50,
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text('NYC         .  200m²         .  F3          ')),
              Divider(
                height: 20,
                thickness: 1,
                indent: 50,
                endIndent: 50,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    Text(
                      country + " ," + place,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                width: double.infinity,
                height: devicedata.size.height * 0.5,
                child: GoogleMap(
                  markers: mymarker,
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // void _ondragend(DragEndDetails details) {
  //   setState(() {
  //     if (index < announceImages.length - 1) {
  //       index = index + 1;
  //     }
  //   });
  // }
}
