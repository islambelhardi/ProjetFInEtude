import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projet_fin_etude/Routes/loginview.dart';
import 'package:projet_fin_etude/net/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  String _name = '';
  String _email = '';
  String _password = '';
  String _passwordConfirmation = '';
  Future<void> _showMyDialog() async {
    await Signup();
    
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext dialogcontext) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(dialogcontext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future Signup() async {
    http.Response response = await AuthService.register(
      _name,
      _email,
      _password,
    );
    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign up',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black)),
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.access_alarms),
                      label: Text('Continue with Google'))),
              const Divider(indent: 10, endIndent: 10),
              TextFormField(
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
                  )
                ),
                controller: _nameController,
                onChanged: (value) => _name = value,
              ),
              TextFormField(
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                  )
                ),
                controller: _emailController,
                onChanged: (value) => _email = value,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder()
                ),
                controller: _passwordController,
                onChanged: (value) => _password = value,
              ),
              TextFormField(
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  labelText: 'Password-Confirmation',
                  border: OutlineInputBorder()
                ),
                controller: _passwordController,
                onChanged: (value) => _passwordConfirmation = value,
              ),
              TextButton(
                  onPressed: () => _showMyDialog(), child: const Text('Sign up')),
              const Divider(indent: 10, endIndent: 10),
              Text('Already have Account?'),
              TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const LoginView(),
                      )),
                  child: Text('Log in'))
            ],
          ),
        ),
      ),
    );
  }
}
