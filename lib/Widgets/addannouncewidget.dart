// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_element, prefer_const_literals_to_create_immutables, avoid_types_as_parameter_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Constatnts/keys.dart';
import 'package:projet_fin_etude/Controllers/announcecontroller.dart';
import 'package:image_picker/image_picker.dart';

import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart'
import 'package:http/http.dart' as http;
import 'package:projet_fin_etude/Widgets/placepicker.dart';

class AddAnnounceWidget extends StatefulWidget {
  AddAnnounceWidget({Key? key}) : super(key: key);

  @override
  State<AddAnnounceWidget> createState() => _First_page_publierState();
}

class _First_page_publierState extends State<AddAnnounceWidget> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Villa"), value: "villa"),
      DropdownMenuItem(child: Text("Studio"), value: "Studio"),
      DropdownMenuItem(child: Text("Logment"), value: "Logment"),
      DropdownMenuItem(child: Text("Appartement"), value: "appartement"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems2 = [
      DropdownMenuItem(child: Text("For rent"), value: "rent"),
      DropdownMenuItem(child: Text("For sale"), value: "sale"),
      DropdownMenuItem(child: Text("For exchange"), value: "exchange"),
    ];
    return menuItems2;
  }

  final Map<String, String> details = {
    'title': 'null',
    'description': 'null',
    'dealtype': 'null',
    'propretytype': 'null',
    'roomnumber': 'null',
    'surface': 'null',
    'price': 'null',
    'place': 'null'
  };
  String selectedValue = "villa";
  String selectedValue2 = "rent";
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles = [];
  List<XFile>? imagefilessaver;
  List<XFile>? imagefilessaver2;

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        for (var file in pickedfiles) {
          imagefiles!.add(file);
        }
        setState(() {
          imagefiles;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  addannounce(List<XFile>? imagefiles, Map<String, String> details) async {
    http.StreamedResponse response =
        await AnnounceController.addannounce(imagefiles, details);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('announce added successfully ')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('something went wrong ')),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
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
                        return Stack(
                          clipBehavior: Clip.none,
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Card(
                                child: Container(
                              height: 100,
                              width: 100,
                              child: Image.file(File(imageone.path)),
                            )),
                            IconButton(
                                onPressed: () {
                                  imagefiles?.remove(imageone);
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                )),
                          ],
                        );
                      }).toList(),
                    )
                  : Container(),
              Form(
                key: _formKey,
                child: Container(
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
                            hintText: 'type a title for your announce',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ).copyWith(color: Color(0xff94959b)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) => details['title'] = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter your announce title';
                            }
                            return null;
                          },
                        ),
                      ),
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
                              builder: (context) => PlacePicker(
                                initialPosition: PickerDemo.kInitialPosition,
                                apiKey: APIKeys.androidApiKey,

                                onPlacePicked: (result) {
                                  print(result.adrAddress);
                                  Navigator.of(context).pop();
                                },
                                // initialPosition: HomePage.kInitialPosition,
                                useCurrentLocation: true,
                              ),
                            ),
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return PlacePicker(
                          //         apiKey: APIKeys.androidApiKey,
                          //         hintText: "Find a place ...",
                          //         searchingText: "Please wait ...",
                          //         selectText: "Select place",
                          //         outsideOfPickAreaText: "Place not in area",
                          //         initialPosition: PickerDemo.kInitialPosition,
                          //         useCurrentLocation: true,
                          //         selectInitialPosition: true,
                          //         usePinPointingSearch: true,
                          //         usePlaceDetailSearch: true,
                          //         zoomGesturesEnabled: true,
                          //         zoomControlsEnabled: true,
                          //         onPlacePicked: (PickResult result) {
                          //           print("==================");
                          //           print(result.address);
                          //           print("==================");
                          //         },
                          //         onMapTypeChanged: (MapType mapType) {
                          //           print(
                          //               "Map type changed to ${mapType.toString()}");
                          //         },
                          //       );
                          //     },
                          //   ),
                          // );
                        },
                      ),
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
                          onChanged: (value) => details['description'] = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter a discription ';
                            }
                            return null;
                          },
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
                          onChanged: (value) => details['price'] = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter an esttimated price';
                            }
                            return null;
                          },
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
                              value == null ? 'field required' : null,
                          dropdownColor: Color.fromARGB(255, 255, 255, 255),
                          value: selectedValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                              details['propretytype'] = selectedValue;
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '500m²',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ).copyWith(color: Color(0xff94959b)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) => details['surface'] = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter your proprety surface';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text("Deal Type",
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
                              value == null ? "enter the deal type" : null,
                          dropdownColor: Color.fromARGB(255, 255, 255, 255),
                          value: selectedValue2,
                          onChanged: (String? newValue2) {
                            setState(() {
                              selectedValue2 = newValue2!;
                              details['dealtype'] = selectedValue2;
                            });
                          },
                          items: dropdownItems2),
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
                          onChanged: (value) => details['roomnumber'] = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter a the room number';
                            }
                            return null;
                          },
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
                                onPressed: () {
                                  // for (var i = 0; i < details.length; i++) {
                                  //   print(details[i]);
                                  // }
                                  details.forEach(
                                      (k, v) => print("Key : $k, Value : $v"));
                                  //  print(details['roomnumber']);
                                },
                              )),
                          Spacer(
                            flex: 1,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (imagefiles == null || imagefiles!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'please choose your announce pictures')),
                                  );
                                }
                                if (_formKey.currentState!.validate() &&
                                    imagefiles!.isNotEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                  addannounce(imagefiles, details);
                                }
                              },
                              child: Text('Add Announce')),
                          // Container(
                          //     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          //     child: ElevatedButton(
                          //       style: ElevatedButton.styleFrom(
                          //         primary:
                          //             Colors.blue.shade900, // Background color
                          //       ),
                          //       child: const Text('ajouter',
                          //           style: TextStyle(
                          //               fontSize: 18,
                          //               fontWeight: FontWeight.w600,
                          //               color: Colors.white)),
                          //       onPressed: () {
                          //         Navigator.of(context).push(MaterialPageRoute(
                          //             builder: (BuildContext context) =>
                          //                 PickerDemo()));
                          //       },
                          //     )),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
        ));
  }
}
