// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:projet_fin_etude/Routes/profilepage.dart';
import 'package:http/http.dart' as http;
import 'package:projet_fin_etude/Controllers/authcontroller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:projet_fin_etude/Views/loginview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupView extends StatefulWidget {
  SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }
  String _email = "";
  String _password = "";
  String _name = "";
  String _type="user";
  signup() async {
    http.Response response =
        await AuthController.register(_name, _email, _password,_type);
    // print(json.decode(response.body));
    showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          return AlertDialog(
            title: Text(json.decode(response.body)),
            actions: <Widget>[
              TextButton(
                child: const Text('Login'),
                onPressed: () {
                  Navigator.of(dialogcontext).pop();
                },
              ),
            ],
          );
        });
  }
  bool isChecked = false;
   

  @override
  Widget build(BuildContext context) {
    var devicedata = MediaQuery.of(context);
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 0),
          child: ListView(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Register new\naccount',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'Assets/images/accent.png',
                  width: 99,
                  height: 4,
                ),
              ]),
              SizedBox(
                height: 48,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xfff1f1f5),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ).copyWith(color: Color(0xff94959b)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your name';
                          }
                          return null;
                        },
                        onChanged: (value) => _name = value,
                      ),
                    ),
                    SizedBox(
                      height: devicedata.size.height * 0.050,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xfff1f1f5),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ).copyWith(color: Color(0xff94959b)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              EmailValidator.validate(value) == false) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (value) => _email = value,
                      ),
                    ),
                    SizedBox(
                      height: devicedata.size.height * 0.050,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xfff1f1f5),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
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
                        validator: (value) {
                          if (value == null || value.length < 8) {
                            return 'password must be 8 caracters';
                          }
                          return null;
                        },
                        onChanged: (value) => _password = value,
                      ),
                    ),
                    SizedBox(
                      height: devicedata.size.height * 0.050,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xfff1f1f5),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          hintText: 'Password Confirmation',
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
                        validator: (value) {
                          if (value != _password ) {
                            return 'enter a match password';
                          }
                          return null;
                        },
                      ),  
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                              _type="agency";
                            });
                          },
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text('Sign Up as Agency',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                        width: double.infinity,
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                            child: const Text('Sign up',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )),
                            onPressed: () => {
                                  if (_formKey.currentState!.validate())
                                    {
                                      signup(),
                                    }
                                })),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ).copyWith(color: Color(0xff94959b)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ).copyWith(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
