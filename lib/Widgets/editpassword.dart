import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Controllers/authcontroller.dart';
import 'package:http/http.dart' as http;
import '../Controllers/connection.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({Key? key}) : super(key: key);

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  String password = '';
  String newpassword = '';
  changepassword(String password, String newpassword) async {
    String? token = await AuthController.checklogin();
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Charset': 'utf-8'
    };
    Map data = {
      "password": password,
      "newpassword": newpassword,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseUrl + 'api/user/modify/password');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          return AlertDialog(
            title: Text(json.decode(response.body)),
            actions: <Widget>[
              response.statusCode == 200
                  ? TextButton(
                      child: const Text('ok'),
                      onPressed: () {
                        Navigator.of(dialogcontext).pop();
                      },
                    )
                  : TextButton(
                      onPressed: () {
                        Navigator.of(dialogcontext).pop();
                      },
                      child: Text('Retry'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          heightFactor: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Enter your old password here'),
              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: const Color(0xfff1f1f5),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) => password = value,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Enter your new password here'),
              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: const Color(0xfff1f1f5),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) => password = value,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: 300,
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Change Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                    // if the password and email is valide
                    onPressed: () => changepassword(password, newpassword),
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: 300,
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Cencel',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                    // if the password and email is valide
                    onPressed: () => Navigator.pop(context),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
