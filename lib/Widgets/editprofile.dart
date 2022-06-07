// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_function_declarations_over_variables, unnecessary_new, unused_field, prefer_collection_literals, unused_local_variable, prefer_if_null_operators, use_key_in_widget_constructors, deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_fin_etude/Controllers/connection.dart';
import 'package:projet_fin_etude/Controllers/usercontroller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // File _profilePicFile = File('');

  // @override
  // void initState() {
  //   super.initState();
  // }

  // // A simple usage of EditableImage.
  // // This method gets called when trying to change an image.
  // void _directUpdateImage(File? file) async {
  //   if (file == null) return;

  //   _profilePicFile = file;
  //   setState(() {});
  // }
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile!;
    });
  }

  Map _details = {};
  var _formKey = GlobalKey<FormState>();
  Future loaduserdetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("access token");
    var url = Uri.parse(baseUrl + 'api/user/info');
    var headers = {'Authorization': 'Bearer $token'};
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    setState(() {
      _details = jsonDecode(response.body);
    });
  }

  String name = '';
  String email = '';
  String password = '';
  modifyinfo(String name, String email, String password) async {
    var data = Map<String, String>();
    data['name'] = name.isEmpty ? _details['name'] : name;
    data['email'] = email.isEmpty ? _details['email'] : email;
    data['password'] = password;
    var response = await UserController.modifyinfo(data);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.body)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.body)),
      );
    }
  }

  //set password visible/
  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  setbackground() {
    if (_details['image'] != null && _imageFile == null) {
      return NetworkImage(baseUrl + _details['image']);
    }
    if (_imageFile != null) {
      return FileImage(
        File(_imageFile!.path),
      );
    }
    return AssetImage('Assets/images/user.png') as ImageProvider;
  }

  //set password visible/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaduserdetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('closed');
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return _details.isEmpty
        ? SafeArea(
            child: Container(
              color: Colors.white,
              // child: Text('Something went wrong'),
            ),
          )
        : Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 1,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.green,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Container(
              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
              child: ListView(
                children: [
                  Text(
                    "Paramétre de profil",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(child: imageProfile()),
                  SizedBox(
                    height: 35,
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue:
                              _details.isEmpty ? 'username' : _details['name'],
                          onChanged: (value) => name = value,
                        ),
                        TextFormField(
                          initialValue:
                              _details.isEmpty ? 'email' : _details['email'],
                          onChanged: (value) => email = value,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                EmailValidator.validate(value) == false) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: _details.isEmpty
                              ? 'your phone number here '
                              : _details['phone_number'].toString(),
                          onChanged: (value) => email = value,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                EmailValidator.validate(value) == false) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ).copyWith(color: Color(0xff94959b)),
                            suffixIcon: IconButton(
                              color: Color(0xff94959b),
                              splashRadius: 1,
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: togglePassword,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) => password = value,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("CANCEL",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          modifyinfo(name, email, password);
                        },
                        child: Text("Save",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  )
                ],
              ),
            ),
          );
  }

  Widget buildTextField(
      String labelText,
      String placeholder,
      bool isPasswordTextField,
      TextEditingController mycontroller,
      String? Function(String?)? validator) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(labelText,
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
          controller: mycontroller,
          onFieldSubmitted: (value) {},
          obscureText: isPasswordTextField ? showPassword : false,
          decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ).copyWith(color: Color.fromARGB(255, 0, 0, 0)),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          validator: validator,
        ),
      ),
    ]);
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(radius: 60.0, backgroundImage: setbackground()
            // _imageFile == null
            //     ? AssetImage('Assets/images/user.png') as ImageProvider
            //     : FileImage(
            //         File(_imageFile!.path),
            //       )
            ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }
}
