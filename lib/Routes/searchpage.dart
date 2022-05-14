// ignore_for_file: prefer_final_fields, prefer_const_constructors, non_constant_identifier_names, unused_local_variable, unnecessary_null_comparison

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:projet_fin_etude/Widgets/maploadingwidget.dart';
import 'package:projet_fin_etude/custom_icon_icons.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Position cl;
  late CameraPosition _kGooglePlex;
  late Set<Marker> mymarker;
  late var lat;
  late var lang;
  // late var place;
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
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getposition();
    loadmap();
  }

  Completer<GoogleMapController> _controller = Completer();
  List<String> ButtonList = [
    "Apartment",
    "Studio",
    "Villa",
    "For Rent",
    "For Sale"
  ];
  bool isloading = true;
  Future loadmap() async {
    await getLatAndLang();
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var devicedata = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Row(
                children: const [
                  Text(
                    'Current location',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.lightBlue[300],
                  ),
                  Text(
                    'Algeria , ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                        labelText: 'what are you looking for ? ',
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: Icon(CustomIcon.settings , size: 18,)),
                ],
              ),
            ),
            Container(
                height: 50,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: ButtonList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(),
                            onPressed: () {},
                            child: Text(ButtonList[index])),
                      );
                    })),
            Expanded(
              child: isloading
                  ? MapLoadingWidget()
                  : Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      height: devicedata.size.height * 0.3,
                      child: GoogleMap(
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
      ),
    );
  }
}
