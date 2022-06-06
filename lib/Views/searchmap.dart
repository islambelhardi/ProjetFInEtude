import 'dart:convert';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projet_fin_etude/Controllers/announcecontroller.dart';
import 'package:http/http.dart' as http;
import 'package:projet_fin_etude/Controllers/connection.dart';
import 'package:projet_fin_etude/Widgets/announcedetails.dart';

class mapSearch extends StatefulWidget {
  static const Marker _offermarker = Marker(
      markerId: MarkerId('_offermarker'),
      infoWindow: InfoWindow(title: 'offer'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(37.42200058560960000000, -122.08400286734100000000));
  @override
  _mapSearchState createState() {
    return _mapSearchState();
  }
}

class _mapSearchState extends State<mapSearch> {
  late BitmapDescriptor mapMarker;
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  List<Marker> allMarkers = [];
  var _offerData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getloc(context));
    _loadData();
    setCustomMarker();
  }

  Position? position = null;
  double? lat = null;
  double? long = null;
  getloc(BuildContext context) async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
    } catch (e) {
      throw e;
    }
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/images/pin2.png');
  }

  @override
  Widget build(BuildContext context) {
    while (lat == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Center(child: CircularProgressIndicator())),
      );
    }
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _customInfoWindowController.googleMapController = controller;
              },
              markers: allMarkers == null
                  ? {mapSearch._offermarker}
                  : Set.from(allMarkers),
              initialCameraPosition:
                  CameraPosition(target: LatLng(lat!, long!), zoom: 15),
              zoomGesturesEnabled: true,
              onTap: (position) {
                _customInfoWindowController.hideInfoWindow!();
              },
              onCameraMove: (position) {
                _customInfoWindowController.onCameraMove!();
              },
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              height: 150,
              width: 380,
              offset: 35,
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic>? place;
  _loadData() async {
    http.Response response = await AnnounceController.getall();
    if (response.statusCode == 200) {
      setState(() {
        _offerData = json.decode(response.body);
        for (int i = 0; i < _offerData.length; i++) {
          place = json.decode(_offerData[i]['place']);
          allMarkers.add(
            Marker(
              markerId: MarkerId(_offerData[i]['id'].toString()),
              draggable: false,
              position: LatLng(
                double.parse(place!['lat']),
                double.parse(
                  place!['lng'],
                ),
              ),
              // icon: mapMarker,
              onTap: () {
                _customInfoWindowController.addInfoWindow!(
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnnounceDetails(
                                announce_id: _offerData[i]['id'])),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 07, 10, 7),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              flex: 10,
                              child: SizedBox(
                                child: Image.network(
                                  baseUrl + _offerData[i]['img'],
                                  fit: BoxFit.fill,
                                ),
                                width: 100,
                              ),
                            ),
                            Flexible(
                              flex: 16,
                              child: Container(
                                color: Colors.white,
                                padding:
                                    // EdgeInsets.fromLTRB(left, top, right, bottom)
                                    const EdgeInsets.fromLTRB(10, 1, 0, 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      _offerData[i]['title'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 15,
                                            child: Icon(
                                              Icons.bed_rounded,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            _offerData[i]['roomnumber']
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 13,
                                              child: Icon(Icons.fullscreen)),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            _offerData[i]['surface']
                                                    .toString() +
                                                'm²',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      _offerData[i]['propretytype'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'DZD' +
                                              _offerData[i]['price']
                                                  .toString() +
                                              'Millions',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          height: 20,
                                          width: 60,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color:
                                                  Colors.grey.withOpacity(0.5)),
                                          child: Text(
                                            'For ' + _offerData[i]['dealtype'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xff023e8a),
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        height: 150,
                        margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF605F5F).withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: const Offset(2, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  LatLng(
                    double.parse(place!['lat']),
                    double.parse(
                      place!['lng'],
                    ),
                  ),
                );
              },
            ),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }
}
