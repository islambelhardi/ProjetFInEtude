// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_element, prefer_const_literals_to_create_immutables, avoid_types_as_parameter_names

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:projet_fin_etude/Routes/explorepage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_fin_etude/Widgets/keys.dart';
import 'package:projet_fin_etude/Widgets/placepicker.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;

// Your api key storage.

import '../Widgets/state_picker.dart';

class First_page_publier extends StatefulWidget {
  First_page_publier({Key? key}) : super(key: key);

  @override
  State<First_page_publier> createState() => _First_page_publierState();
}

class _First_page_publierState extends State<First_page_publier> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Villa"), value: "Villa"),
      DropdownMenuItem(child: Text("Studio"), value: "Studio"),
      DropdownMenuItem(child: Text("Logment"), value: "Logment"),
      DropdownMenuItem(child: Text("Appartement"), value: "Appartement"),
    ];
    return menuItems;
  }

  String selectedValue = "Villa";
  String selectedValue2 = "1";
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  List<XFile>? imagefilessaver;
  List<XFile>? imagefilessaver2;

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;

        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff8f9fa),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Add Proprety',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
              child: ListView(
            children: [
              Container(
                  width: double.infinity,
                  height: 180,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade400, // Background color
                    ),
                    child: const Text('+',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        )),
                    onPressed: () {
                      openImages();
                    },
                  )),
              Divider(),
              imagefiles != null
                  ? Wrap(
                      children: imagefiles!.map((imageone) {
                        return Container(
                            child: Card(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.file(File(imageone.path)),
                          ),
                        ));
                      }).toList(),
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text("Title",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Villa on palm hbb',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ).copyWith(color: Color(0xff94959b)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text("Place",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87)),
                    ),
                    Row(children: [
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Villa on palm hbb',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ).copyWith(color: Color(0xff94959b)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {},
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PlacePicker(
                                  apiKey: APIKeys.androidApiKey,
                                  hintText: "Find a place ...",
                                  searchingText: "Please wait ...",
                                  selectText: "Select place",
                                  outsideOfPickAreaText: "Place not in area",
                                  initialPosition: PickerDemo.kInitialPosition,
                                  useCurrentLocation: true,
                                  selectInitialPosition: true,
                                  usePinPointingSearch: true,
                                  usePlaceDetailSearch: true,
                                  zoomGesturesEnabled: true,
                                  zoomControlsEnabled: true,
                                  onPlacePicked: (PickResult result) {
                                    print("==================");

                                    print("==================");
                                  },
                                  onMapTypeChanged: (MapType mapType) {
                                    print(
                                        "Map type changed to ${mapType.toString()}");
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text("Descreption",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Dubai,easten,Saudia Arabia',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ).copyWith(color: Color(0xff94959b)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text("Price",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: '800Da per night ',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ).copyWith(color: Color(0xff94959b)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text("Category",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87)),
                    ),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                        validator: (value) =>
                            value == null ? "Select a category" : null,
                        dropdownColor: Color.fromARGB(255, 255, 255, 255),
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                        items: dropdownItems),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text("measurement",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: '500m * 400m ',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ).copyWith(color: Color(0xff94959b)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text("The number of rooms",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: ' For example 4 ',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ).copyWith(color: Color(0xff94959b)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, // Background color
                              ),
                              child: const Text('Cancel',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red)),
                              onPressed: () {},
                            )),
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    Colors.blue.shade900, // Background color
                              ),
                              child: const Text('ajouter',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                              onPressed: () async {
                                await context.setLocale(Locale('ar'));
                              },
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
