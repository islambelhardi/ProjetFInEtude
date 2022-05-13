// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_fin_etude/Routes/profilepage.dart';
import 'package:editable_image/editable_image.dart';

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

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ProfilePage()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProfilePage()));
            },
          ),
        ],
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
            Center(child: imageProfile()

                // EditableImage(
                //   // Define the method that will run on the change process of the image.
                //   onChange: (file) => _directUpdateImage(file),

                //   // Define the source of the image.
                //   image: _profilePicFile.existsSync()
                //       ? Image.file(_profilePicFile, fit: BoxFit.cover)
                //       : null,

                //   // Define the size of EditableImage.
                //   size: 150.0,

                //   // Define the Theme of image picker.
                //   imagePickerTheme: ThemeData(

                //     // Define the default brightness and colors.
                //     primaryColor: Colors.white,
                //     shadowColor: Colors.transparent,
                //     backgroundColor: Colors.white70,

                //     // Define the default font family.
                //     fontFamily: 'Georgia',
                //   ),

                //   // Define the border of the image if needed.
                //   imageBorder:
                //       Border.all(color: Colors.blue.shade900, width: 2.0),

                //   // Define the border of the icon if needed.
                //   editIconBorder:
                //       Border.all(color: Colors.blue.shade900, width: 2.0),
                // ),
                ),
            SizedBox(
              height: 35,
            ),
            buildTextField("Full Name", "Islam belhardi", false),
            buildTextField("E-mail", "tbessi@gmail.com", false),
            buildTextField("Password", "********", true),
            buildTextField("Phone", "0659035919", false),
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
                  onPressed: () {},
                  child: Text("CANCEL",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black)),
                ),
                RaisedButton(
                  onPressed: () {},
                  color: Colors.blue.shade900,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  ),
                )
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
      String labelText, String placeholder, bool isPasswordTextField) {
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
          validator: (value) {},
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
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
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
