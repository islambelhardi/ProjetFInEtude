// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projet_fin_etude/Controllers/announcecontroller.dart';
import 'package:projet_fin_etude/Controllers/authcontroller.dart';
import 'package:projet_fin_etude/Controllers/connection.dart';
import 'package:projet_fin_etude/Controllers/usercontroller.dart';
import 'package:projet_fin_etude/Models/comment.dart';
import 'package:projet_fin_etude/Views/loginview.dart';
import 'package:projet_fin_etude/Widgets/announceloading.dart';
import 'package:projet_fin_etude/Widgets/commentwidget.dart';
import 'package:projet_fin_etude/translations/local_keys.g.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart' as fluttermap;
import 'package:latlong2/latlong.dart' as latLng;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class AnnounceDetails extends StatefulWidget {
  final announce_id;
  const AnnounceDetails({Key? key, required this.announce_id})
      : super(key: key);
  @override
  _AnnounceDetailsState createState() => _AnnounceDetailsState();
}

class _AnnounceDetailsState extends State<AnnounceDetails> {
  Iterable _details = [];
  String _phone = '';
  List announceImages = [];
  List<Placemark> placemarks1 = [];
  Map<String, dynamic> place = {};

  LoadDetails() async {
    Response response =
        await AnnounceController().getAnnounce(widget.announce_id);
    setState(() {
      _details = json.decode(response.body);
    });
    print(_details);
    // add agency phone number
    _phone = _details.elementAt(0)['agency']['phone_number'].toString();
    place = (jsonDecode(_details.elementAt(0)['place']));
    placemarks1 = await placemarkFromCoordinates(
        double.parse(place['lat']), double.parse(place['lng']),
        localeIdentifier: "en");

    // for (int i = 0; i < images.length; i++) {
    //
    // }
    setState(() {});
    // print( _details.elementAt(0)['images'].toList());
  }

  var comments = [];
  loadComments() async {
    await LoadDetails();
    try {
      comments = _details
          .elementAt(0)['comments']
          .map((model) => Comment.fromJson(model))
          .toList();
    } catch (e) {
      print(e);
    }
    // add the images form response to show it later
    List images = _details.elementAt(0)['images'];
    for (var image in images) {
      announceImages.add(image);
    }
    // print(_details.elementAt(0)['comments']);
    setState(() {});
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
    loadComments();
  }

  @override
  void dispose() {
    super.dispose();
    print('closed');
  }

  //alert dialog function


  comment_alert(BuildContext context) {
    late String content;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add comment'),
            content: TextField(
              decoration: InputDecoration(hintText: LocaleKeys.Add_new_comment.tr()),
              onChanged: (value) => content = value,
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text(LocaleKeys.Add.tr()),
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  String? token = pref.getString("access token");
                  UserController.comment(content, widget.announce_id, token!);
                  Navigator.pop(context, () {
                    setState() {
                      loadComments();
                    }
                  });
                  //  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(
                  LocaleKeys.Cancel.tr(),
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

//end allert dialog function

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  final controller = PageController(viewportFraction: 1, keepPage: true);
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var devicedata = MediaQuery.of(context);
    return _details.isEmpty
        ? Announceloading()
        : Scaffold(
            // drawerEnableOpenDragGesture: false,
            endDrawerEnableOpenDragGesture: false,
            endDrawer: customdrawer(BuildContext, _closeEndDrawer),
            key: _key,
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Proprety Deatails',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              actions: <Widget>[Container()],
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
            body: Builder(builder: (ctx) {
              return Center(
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
                            _details.elementAt(0)['title'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Container(
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Wrap(
                                spacing: 40,
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.black12,
                                        radius: 20,
                                        child: Icon(
                                          Icons.bed,
                                          color: Colors.black54,
                                          size: 30,
                                        ),
                                      ),
                                      Text(_details
                                              .elementAt(0)['roomnumber']
                                              .toString() +
                                          LocaleKeys.Badroom.tr()),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.black12,
                                        radius: 20,
                                        child: Icon(
                                          Icons.fullscreen,
                                          color: Colors.black54,
                                          size: 30,
                                        ),
                                      ),
                                      Text(_details
                                              .elementAt(0)['surface']
                                              .toString() +
                                          'm??'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocaleKeys.Place.tr(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              SizedBox(
                                height: devicedata.size.width * 0.03,
                              ),
                              Container(
                                width: double.infinity,
                                height: devicedata.size.height * 0.3,
                                child: announcemap(context, place),
                              ),
                              Container(
                                child: placemarks1.isEmpty
                                    ? Text('')
                                    : Text(placemarks1[0].locality! +
                                        ',' +
                                        placemarks1[0].country!),
                              )
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
                            LocaleKeys.Details.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(
                              height: devicedata.size.width * 0.06,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(LocaleKeys.category.tr()),
                                Text(_details.elementAt(0)['propretytype'])
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(LocaleKeys.Purpose.tr()),
                                Text(_details.elementAt(0)['dealtype'])
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(LocaleKeys.Price.tr()),
                                Text(_details.elementAt(0)['price'].toString() +
                                    'Millions')
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(LocaleKeys.nbr_rooms.tr()),
                                Text(_details
                                    .elementAt(0)['roomnumber']
                                    .toString())
                              ],
                            ),
                             Divider(
                              thickness: 1,
                              height: 30,
                            ),
                            Text(LocaleKeys.Description.tr()),
                            SizedBox(
                              height: devicedata.size.width * 0.03,
                            ),
                            ReadMoreText(
                              _details.elementAt(0)['description'],
                              trimLines: 4,
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
                              children:  [
                                Text(
                                  LocaleKeys.Comments.tr(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: devicedata.size.width * 0.03,
                            ),
                            Container(
                              child: comments.isEmpty
                                  ? Text(LocaleKeys.no_comment.tr())
                                  : CommentWidget(
                                      comments: comments,
                                    ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white, // Background color
                                ),
                                child: Text(LocaleKeys.Add_new_comment.tr(),
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    )),
                                onPressed: () async {
                                  String? token =
                                      await AuthController.checklogin();
                                  if (token == null || token.isEmpty) {
                                    _key.currentState!.openEndDrawer();
                                  } else {
                                    comment_alert(context);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(0.0),
              height: 70,
              color: Color(0xfff8f9fa),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      baseUrl + _details.elementAt(0)['agency']['image']),
                ),
                title: Text(LocaleKeys.Agency.tr()),
                subtitle: Text(_details.elementAt(0)['agency']['name']),
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

Widget announcemap(BuildContext context, Map place) {
  return Stack(
    children: [
      fluttermap.FlutterMap(
        options: fluttermap.MapOptions(
          minZoom: 10,
          maxZoom: 16,
          zoom: 15,
          center: latLng.LatLng(
              double.parse(place['lat']), double.parse(place['lng'])),
        ),
        nonRotatedLayers: [
          fluttermap.TileLayerOptions(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/islambelhardi/cl2mhadco004j14l42s8et3dg/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaXNsYW1iZWxoYXJkaSIsImEiOiJjbDNtM2tqMTMwMHppM3BueTM2NHRoMnowIn0.4JvkXzrjgdzbFrvIEdCnTg',
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoiaXNsYW1iZWxoYXJkaSIsImEiOiJjbDNtM2tqMTMwMHppM3BueTM2NHRoMnowIn0.4JvkXzrjgdzbFrvIEdCnTg',
                'id': 'mapbox.mapbox-streets-v8',
              }),
          fluttermap.MarkerLayerOptions(
            markers: [
              fluttermap.Marker(
                point: latLng.LatLng(
                    double.parse(place['lat']), double.parse(place['lng'])),
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

Widget customdrawer(BuildContext, Function()? closeEndDrawer) {
  return Container(
    width: double.infinity,
    child: Drawer(
      child: Center(
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(
                    Icons.close_outlined,
                    color: Colors.black,
                  ),
                  onPressed: closeEndDrawer,
                ),
              ),
              body: LoginView(
                redirect: false,
              )),
        ),
      ),
    ),
  );
}
