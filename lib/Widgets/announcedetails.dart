// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projet_fin_etude/Controllers/announcecontroller.dart';
import 'package:projet_fin_etude/Controllers/connection.dart';
import 'package:projet_fin_etude/Widgets/announceloading.dart';
import 'package:projet_fin_etude/Widgets/comment.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart' as fluttermap;
import 'package:latlong2/latlong.dart' as latLng;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AnnounceDetails extends StatefulWidget {
  final announce_id;
  const AnnounceDetails({Key? key, required this.announce_id})
      : super(key: key);
  @override
  _AnnounceDetailsState createState() => _AnnounceDetailsState();
}

class _AnnounceDetailsState extends State<AnnounceDetails> {
  dynamic _details;
  String _phone = '';
  List announceImages = [];
  List<Placemark> placemarks1 = [];

  LoadDetails() async {
    Response response =
        await AnnounceController().getAnnounce(widget.announce_id);

    setState(() {
      _details = json.decode(response.body);
    });
    // add agency phone number
    _phone = _details[0]['agency']['phone_number'].toString();
    placemarks1 = await placemarkFromCoordinates(34.724931, 8.059845);
    setState(() {
      placemarks1;
    });
    // add the images form response to show it later
    List images = _details[0]['images'].toList();
    for (int i = 0; i < images.length; i++) {
      announceImages.add(images[i]);
    }
  }

  int index = 0;
  bool _hasCallSupport = false;
  Future<void>? _launched;

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
    // getposition();
    // getLatAndLang();
    LoadDetails();
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
    return _details == null
        ? Announceloading()
        : Scaffold(
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
                                  image: NetworkImage(
                                      baseUrl + announceImages[i]['url']),
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 250,
                                ),
                              );
                            }),
                      ),
                      SmoothPageIndicator(
                        controller: controller,
                        count: announceImages.length,
                        effect: ScrollingDotsEffect(
                          activeStrokeWidth: 2.6,
                          activeDotScale: 1.3,
                          maxVisibleDots: 5,
                          radius: 10,
                          spacing: 7,
                          dotHeight: 6,
                          dotWidth: 6,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          _details[0]['title'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: const [
                                      Icon(
                                        Icons.bed,
                                      ),
                                      Text('4 Bedrooms')
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: const [
                                      Icon(
                                        Icons.bed,
                                      ),
                                      Text('200m²'),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Location',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            SizedBox(
                              height: devicedata.size.width * 0.03,
                            ),
                            Container(
                              width: double.infinity,
                              height: devicedata.size.height * 0.3,
                              child: announcemap(context),
                            ),
                            Text(placemarks1[0].locality! +
                                ',' +
                                placemarks1[0].country!)
                          ],
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
                          Text(
                            'Properties Details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: devicedata.size.width * 0.03,
                          ),
                          Text(
                            _details[0]['description'],
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
                          Row(
                            children: const [
                              Text(
                                'Comments',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
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
                            ),
                          ),
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
                  backgroundImage:
                      NetworkImage(baseUrl + _details[0]['agency']['image']),
                ),
                title: Text('Agency'),
                subtitle: Text(_details[0]['agency']['name']),
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

Widget announcemap(BuildContext context) {
  final location = latLng.LatLng(34.724931, 8.059845);
  return Stack(
    children: [
      fluttermap.FlutterMap(
        options: fluttermap.MapOptions(
          minZoom: 10,
          maxZoom: 16,
          zoom: 15,
          center: location,
        ),
        nonRotatedLayers: [
          fluttermap.TileLayerOptions(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/islambelhardi/cl2mhadco004j14l42s8et3dg/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaXNsYW1iZWxoYXJkaSIsImEiOiJjbDJtaDFzbnowbjIzM2luazQ4bWd6eDVkIn0.7UfDUhS-W8wqpmjeThO-6Q',
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoiaXNsYW1iZWxoYXJkaSIsImEiOiJjbDJtaDFzbnowbjIzM2luazQ4bWd6eDVkIn0.7UfDUhS-W8wqpmjeThO-6Q',
                'id': 'mapbox.mapbox-streets-v8',
              }),
          fluttermap.MarkerLayerOptions(
            markers: [
              fluttermap.Marker(
                point: location,
                builder: (_) {
                  return Container(
                    child: Image.asset('Assets/images/marker.png'),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
