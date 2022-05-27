// ignore_for_file: prefer_final_fields, prefer_const_constructors, non_constant_identifier_names, unused_local_variable, unnecessary_null_comparison, prefer_typing_uninitialized_variables

import 'dart:async';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:projet_fin_etude/Widgets/filterannouncesheet.dart';
import 'package:projet_fin_etude/Widgets/maploadingwidget.dart';
import 'package:projet_fin_etude/custom_icon_icons.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
                      onPressed: () {
                        showModalBottomSheet(
                            isDismissible: true,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) =>
                                FilterAnnounce(context: context));
                        // showMaterialModalBottomSheet(
                        //   // backgroundColor: Colors.blue,
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(30)),
                        //   context: context,
                        //   builder: (context) => Container(
                        //       decoration: BoxDecoration(
                        //         // color: Colors.black,
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       height: devicedata.size.height * 0.9,
                        //       child: Column(
                        //         children: [
                        //           Padding(
                        //             padding: EdgeInsets.only(left: 10, top: 5),
                        //             child: Row(
                        //               children: [
                        //                 IconButton(
                        //                     onPressed: () {
                        //                       Navigator.pop(context);
                        //                     },
                        //                     icon: Icon(Icons.arrow_back)),
                        //                 Text('Filters')
                        //               ],
                        //             ),
                        //           ),
                        //           ListView(
                        //             padding: const EdgeInsets.all(8),
                        //             children: <Widget>[
                        //               Container(
                        //                 height: 50,
                        //                 color: Colors.amber[600],
                        //                 child: const Center(
                        //                     child: Text('Entry A')),
                        //               ),
                        //               Container(
                        //                 height: 50,
                        //                 color: Colors.amber[500],
                        //                 child: const Center(
                        //                     child: Text('Entry B')),
                        //               ),
                        //               Container(
                        //                 height: 50,
                        //                 color: Colors.amber[100],
                        //                 child: const Center(
                        //                     child: Text('Entry C')),
                        //               ),
                        //             ],
                        //           )
                        //           // SingleChildScrollView(
                        //           //   child: Column(
                        //           //     children: [
                        //           //       Container(
                        //           //         height:100,
                        //           //         width: 200,
                        //           //         color:Colors.black
                        //           //       ),
                        //           //       Container(
                        //           //         height:100,
                        //           //         width: 200,
                        //           //         color:Colors.black
                        //           //       ),
                        //           //       Container(
                        //           //         height:100,
                        //           //         width: 200,
                        //           //         color:Colors.black
                        //           //       ),
                        //           //       Container(
                        //           //         height:100,
                        //           //         width: 200,
                        //           //         color:Colors.black
                        //           //       ),Container(
                        //           //         height:100,
                        //           //         width: 200,
                        //           //         color:Colors.black
                        //           //       ),
                        //           //       Container(
                        //           //         height:500,
                        //           //         width: 200,
                        //           //         color:Colors.black
                        //           //       ),
                        //           //     ],
                        //           //   ),
                        //           // )
                        //         ],
                        //       )),
                        // );
                      },
                      icon: Icon(
                        CustomIcon.settings,
                        size: 18,
                      )),
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

  // Widget buildsheet() {
  //   RangeValues values = RangeValues(1, 100);
  //   RangeLabels labels = RangeLabels('1', "100");
  //   return DraggableScrollableSheet(
  //     initialChildSize: 0.8,
  //     maxChildSize: 0.9,
  //     minChildSize: 0.8,
  //     builder: (_, controller) => Container(
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
  //       padding: EdgeInsets.all(16),
  //       child: ListView(
  //         controller: controller,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               IconButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   icon: Icon(Icons.arrow_back)),
  //               Text(
  //                 'Filters',
  //                 style: TextStyle(fontSize: 20),
  //               ),
  //               TextButton(onPressed: () {}, child: Text('apply'))
  //             ],
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('Price Range'),
  //               RangeSlider(
  //                   divisions: 5,
  //                   activeColor: Colors.red[700],
  //                   inactiveColor: Colors.red[300],
  //                   min: 1,
  //                   max: 100,
  //                   values: values,
  //                   labels: labels,
  //                   onChanged: (value) {
  //                     print("START: ${value.start}, End: ${value.end}");
  //                     setState(() {
  //                       values = value;
  //                       labels = RangeLabels(
  //                           "${value.start.toInt().toString()}\$",
  //                           "${value.start.toInt().toString()}\$");
  //                     });
  //                   }),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
