// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_function_declarations_over_variables

import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_fin_etude/Controllers/connection.dart';
import 'package:projet_fin_etude/Controllers/usercontroller.dart';
import 'package:projet_fin_etude/Routes/profilepage.dart';
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
  loaduserdetails() async {
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
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordCotroller = new TextEditingController();
  //email validator possible structure
  String? Function(String email) emailValidator = (String email) {
    if (email == null ||
        email.isEmpty ||
        EmailValidator.validate(email) == false) {
      return 'email empty';
    } else if (email.length < 3) {
      return 'email short';
    }
    return null;
  };
  String? Function(String name) nameValidator = (String name) {
    // if (name == null || name.isEmpty) {
    //   this.name=name;
    //   return 'email empty';
    // } 
    return null;
  };

  modifyinfo(String name, String email, String password) async {
    await UserController.modifyinfo(name, email, password);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaduserdetails();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   // widget.emailController.dispose();

  // }

  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Edit Profile",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            Center(child: imageProfile()),
            SizedBox(
              height: 35,
            ),
            // Form(
            //   key: _formKey,
            //   child: Column(
            //     children: [
            //       buildTextField(
            //         'name',
            //         _details['name'] ?? '',
            //         false,
            //         nameController,
            //         nameValidator
            //       ),
            //       buildTextField("E-mail", _details['email'] ?? '', false,
            //           emailController, emailValidator),
            //       buildTextField(
            //           "Password", "********", true, passwordCotroller,nameValidator),
            //       RaisedButton(
            //         onPressed: () {
            //           if ('email' == 'email') {
            //             print(true);
            //           } else {
            //             print(false);
            //           }
            //           if (_formKey.currentState!.validate()) {
            //             // If the form is valid, display a snackbar. In the real world,
            //             // you'd often call a server or save the information in a database.
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               const SnackBar(content: Text('Processing Data')),
            //             );
            //           }
            //         },
            //         color: Colors.blue.shade900,
            //         padding: EdgeInsets.symmetric(horizontal: 50),
            //         elevation: 2,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(20)),
            //         child: Text(
            //           "SAVE",
            //           style: TextStyle(
            //               fontSize: 14,
            //               letterSpacing: 2.2,
            //               color: Colors.white),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlineButton(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("CANCEL",
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
        CircleAvatar(
            radius: 60.0,
            backgroundImage: _imageFile == null
                ? NetworkImage(
                        'https://scontent.fogx1-1.fna.fbcdn.net/v/t1.6435-9/80389008_464366174489481_380651642795589632_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeE-ASAJ3WrGoRMsG1fMdE2qDD6YTYl6PVMMPphNiXo9UznoV1VEB_WJPVV2Ugw3wnb3YqlK7KkjgpnvwRhlyPDi&_nc_ohc=Ez67yqI-_qsAX_0uz8q&_nc_ht=scontent.fogx1-1.fna&oh=00_AT_WW1siVeEO_a4WEC56NWJ2nYRoYYYgHmb9CYDl1hFUQg&oe=62895683')
                    as ImageProvider
                : FileImage(
                    File(_imageFile!.path),
                  )),
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
