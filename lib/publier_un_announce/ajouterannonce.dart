// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_element, prefer_const_literals_to_create_immutables, avoid_types_as_parameter_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:projet_fin_etude/Routes/explorepage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_fin_etude/Widgets/placepicker.dart';

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

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems2 = [
      DropdownMenuItem(child: Text("1"), value: "1"),
      DropdownMenuItem(child: Text("2"), value: "2"),
      DropdownMenuItem(child: Text("3"), value: "3"),
      DropdownMenuItem(child: Text("4"), value: "4"),
      DropdownMenuItem(child: Text("5"), value: "5"),
      DropdownMenuItem(child: Text("6"), value: "6"),
      DropdownMenuItem(child: Text("7"), value: "7"),
    ];
    return menuItems2;
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
                            value == null ? "Select a country" : null,
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
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PickerDemo()));
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
