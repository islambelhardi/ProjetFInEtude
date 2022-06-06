// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, must_be_immutable, prefer_collection_literals, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_location_picker/google_map_location_picker.dart';
import 'package:projet_fin_etude/Controllers/announcecontroller.dart';
import 'package:http/http.dart' as http;
import '../Controllers/connection.dart';

class ModifyAnnounceWidget extends StatefulWidget {
  final announce_id;
  ModifyAnnounceWidget({Key? key, required this.announce_id}) : super(key: key);

  @override
  State<ModifyAnnounceWidget> createState() => _ModifyAnnounceWidgetState();
}

class _ModifyAnnounceWidgetState extends State<ModifyAnnounceWidget> {
  Iterable details = [];
  Map? place;
  String? location;
  List<Placemark>? placemarks1;
  LocationResult? pickedLocation;
  List? images;
  loaddetails() async {
    Response response =
        await AnnounceController().getAnnounce(widget.announce_id);
    setState(() {
      details = json.decode(response.body);
      selectedValue = details.elementAt(0)['propretytype'];
      selectedValue2 = details.elementAt(0)['dealtype'];
      place = jsonDecode(details.elementAt(0)['place']);
      images = details.elementAt(0)['images'];
    });
    placemarks1 = await placemarkFromCoordinates(
        double.parse(place!['lat']), double.parse(place!['lng']),
        localeIdentifier: "en");
    setState(() {
      placemarks1;
    });
  }

  List<Placemark> placemark = [];
  getlocation(double lat, double lng) async {
    placemark = await placemarkFromCoordinates(lat, lng);
    setState(() {
      location = placemark[0].country! +
          ',' +
          placemark[0].locality! +
          ',' +
          placemark[0].name!;
      details;
    });
  }

  String? selectedValue;
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Villa"), value: "villa"),
      const DropdownMenuItem(child: Text("Studio"), value: "studio"),
      const DropdownMenuItem(child: Text("Logment"), value: "Logment"),
      const DropdownMenuItem(child: Text("Appartement"), value: "appartement"),
    ];
    return menuItems;
  }

  String? selectedValue2;
  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems2 = [
      const DropdownMenuItem(child: Text("For rent"), value: "rent"),
      const DropdownMenuItem(child: Text("For sale"), value: "sale"),
      const DropdownMenuItem(child: Text("For exchange"), value: "exchange"),
    ];
    return menuItems2;
  }

  String title = '';
  String description = '';
  String dealtype = '';
  String propretytype = '';
  String roomnumber = '';
  String surface = '';
  String price = '';
  String selectedplace = '';
  List<XFile> uploaded_images = [];
  List<String> todeleteimages = [];
  modifyannounce(
      String title,
      String description,
      String dealtype,
      String propretytype,
      String roomnumber,
      String surface,
      String price,
      String selectedplace,
      List<String>? todeleteimages,
      List<XFile>? uploaded_images) async {
    var changes = Map<String, String>();
    changes['id'] = widget.announce_id.toString();
    changes['title'] = title.isEmpty ? details.elementAt(0)['title'] : title;
    changes['description'] =
        description.isEmpty ? details.elementAt(0)['description'] : description;
    changes['dealtype'] =
        dealtype.isEmpty ? details.elementAt(0)['dealtype'] : dealtype;
    changes['propretytype'] =
        dealtype.isEmpty ? details.elementAt(0)['propretytype'] : propretytype;
    changes['roomnumber'] = roomnumber.isEmpty
        ? details.elementAt(0)['roomnumber'].toString()
        : roomnumber;
    changes['surface'] =
        surface.isEmpty ? details.elementAt(0)['surface'].toString() : surface;
    changes['price'] =
        price.isEmpty ? details.elementAt(0)['price'].toString() : price;
    changes['place'] =
        selectedplace.isEmpty ? details.elementAt(0)['place'] : selectedplace;
    var response = await AnnounceController.modifyannounce(
        changes, todeleteimages, uploaded_images);
    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (BuildContext dialogcontext) {
            return AlertDialog(
              title: const Text('Announce Updated'),
              content: Image.asset('Assets/images/success.gif'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(dialogcontext).pop();
                  },
                ),
              ],
            );
          });
    }else{
      showDialog(
          context: context,
          builder: (BuildContext dialogcontext) {
            return AlertDialog(
              title: const Text('Something went wrong'),
              content: Image.asset('Assets/images/warning.gif',height: 60,width: 60,),
              actions: <Widget>[
                TextButton(
                  child: const Text('Retry'),
                  onPressed: () {
                    Navigator.of(dialogcontext).pop();
                  },
                ),
              ],
            );
          });
    }
  }
  final ImagePicker imgpicker = ImagePicker();
  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        for (var file in pickedfiles) {
          uploaded_images.add(file);
        }
        setState(() {
          uploaded_images;
        });
      } else {
        // print("No image is selected.");
      }
    } catch (e) {
      // print("error while picking file.");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddetails();
  }

  @override
  Widget build(BuildContext context) {
    // loading
    if (details.isEmpty) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Center(child: CircularProgressIndicator())),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Modify'),
          actions: [
            OutlinedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext dialogcontext) {
                        return AlertDialog(
                          title: const Text('Are you sure?'),
                          actions: [
                            TextButton(
                              child: const Text('Yes'),
                              onPressed: () {
                                AnnounceController.deleteannounce(
                                    widget.announce_id);
                              },
                            ),
                            ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(dialogcontext).pop(),
                                child: const Text('No')),
                          ],
                        );
                      });
                },
                child: const Text('Delete'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Container(
                height: 200,
                width: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images!.length + 1,
                    itemBuilder: ((context, index) {
                      if (index >= 1) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          height: 300,
                          width: 200,
                          // color: Colors.black,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 200,
                                child: Image.network(
                                  baseUrl + images!.elementAt(index - 1)['url'],
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    todeleteimages.add(
                                        images!.elementAt(index - 1)['url']);
                                    images!.removeAt(index - 1);
                                    setState(() {
                                      images;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        );
                      }
                      if (index == 0) {
                        return OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.black),
                              fixedSize: const Size(200, 200),
                              elevation: 0,
                              backgroundColor: Colors.grey[350],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              openImages();
                            },
                            label: const Text('Add photo'),
                            icon: Icon(Icons.add),
                            );
                      }
                      return Container();
                    })),
              ),
              Text('images to added '),
              uploaded_images != null
                  ? Wrap(
                      spacing: 12,
                      children: uploaded_images.map((imageone) {
                        return Stack(
                          fit: StackFit.loose,
                          // clipBehavior: Clip.none,
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: 120,
                              height: 100,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.file(
                                  File(imageone.path),
                                  width: 100,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    uploaded_images.remove(imageone);
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  )),
                            ),
                          ],
                        );
                      }).toList(),
                    )
                  : const Text('no images uploaded'),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('title'),
                ),
                initialValue: details.elementAt(0)['title'],
                onChanged: (value) {
                  title = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('description'),
                ),
                initialValue: details.elementAt(0)['description'],
                onChanged: (value) {
                  description = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Room number'),
                ),
                initialValue: details.elementAt(0)['roomnumber'].toString(),
                onChanged: (value) {
                  roomnumber = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Surface'),
                ),
                initialValue: details.elementAt(0)['surface'].toString(),
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          label: Text(''),
                          enabledBorder: OutlineInputBorder(),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                            propretytype = selectedValue!;
                          });
                        },
                        items: dropdownItems),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                        value: selectedValue2,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue2 = newValue!;
                            dealtype = selectedValue2!;
                          });
                        },
                        items: dropdownItems2),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(placemarks1 == null
                      ? ''
                      : placemarks1![0].administrativeArea! +
                          ',' +
                          placemarks1![0].locality! +
                          ',' +
                          placemarks1![0].country!),
                  TextButton(
                      onPressed: () async {
                        LocationResult? result = await showLocationPicker(
                          context,
                          "AIzaSyD0MLw5kYq9egZ-e1JWF4NDRQjaaH1oHwc",
                          myLocationButtonEnabled: true,
                          layersButtonEnabled: true,
                          desiredAccuracy: LocationAccuracy.bestForNavigation,
                          countries: ['IN'],
                          language: 'en',
                          requiredGPS: true,
                        );
                        debugPrint("result = $result");
                        setState(() {
                          pickedLocation = result;
                          place = getlocation(pickedLocation!.latLng.latitude,
                              pickedLocation!.latLng.longitude);
                        });
                      },
                      child: const Text('change location')),
                  Text(location ?? 'No changes on announce location '),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (pickedLocation != null) {
                String lat = pickedLocation!.latLng.longitude.toString();
                String lng = pickedLocation!.latLng.latitude.toString();
                selectedplace = jsonEncode({'lat': '$lat', 'lng': '$lng'});
              }
              modifyannounce(
                  title,
                  description,
                  dealtype,
                  propretytype,
                  roomnumber,
                  surface,
                  price,
                  selectedplace,
                  todeleteimages,
                  uploaded_images);
            },
            label: const Text('Save')),
      );
    }
  }
}
