// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Routes/agencyprofile.dart';
import 'package:projet_fin_etude/Routes/profilepage.dart';
import 'package:projet_fin_etude/Views/sigupview.dart';
import 'package:projet_fin_etude/Controllers/authcontroller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class LoginView extends StatefulWidget {
  bool? redirect;
  LoginView({Key? key, this.redirect}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool isChecked = false;
  Map user = {};
  String userdetails = '';
  String ? type;
  // the login function
  Login() async {
    http.Response response = await AuthController.login(_email, _password);
    SharedPreferences pref = await SharedPreferences.getInstance();
    // to redirect the user to profile
    if (widget.redirect == true) {
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        //get the user data
        user = responsebody['user'];
        userdetails = jsonEncode(responsebody['user']);
        pref.setString('user', userdetails);
        //get the user data
        AuthController.savetoken(responsebody['access token']);
        if(user['type']=='user'){
          pref.setString('type', 'user');
          
          // pushNewScreen(context, screen: ProfilePage(user: user),withNavBar: true);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage(user: user)),);
        }else{
          pref.setString('type', 'agency');
          // pushNewScreen(context, screen: AgencyProfilePage(agency: user), withNavBar: true);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AgencyProfilePage(agency: user)),);
        }
      } else {
        showDialog(
            context: context,
            builder: (BuildContext dialogcontext) {
              return AlertDialog(
                title: Text(json.decode(response.body)),
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
    } else {
      // to popup the login view in case loged in correctly
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        //get the user data
        user = responsebody['user'];
        userdetails = jsonEncode(responsebody['user']);
        pref.setString('user', userdetails);
        //get the user data
        AuthController.savetoken(responsebody['access token']);
        if(user['type']=='user'){
          pref.setString('type', 'user'); 
        }else{
          pref.setString('type', 'agency');
        }
        Navigator.pop(context);
      } else {
        showDialog(
            context: context,
            builder: (BuildContext dialogcontext) {
              return AlertDialog(
                title: Text(json.decode(response.body)),
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
    type= pref.getString('type');
  }

  bool isloged = false;
  Future checklogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = await pref.getString("access token");
    // check if the token is there and not null
    if (token != null) {
      String? encodedMap = pref.getString('user');
      user = jsonDecode(encodedMap!);
      isloged = true;
      type =pref.getString('type');
      setState(() {});
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ProfilePage(
      //               user: user,
      //             )),
      //     (route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checklogin();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var devicedata = MediaQuery.of(context);
    if(isloged && type=='user'){
      return ProfilePage(user: user);
    }else{
      if(isloged && type == 'agency'){
        return AgencyProfilePage(agency: user);
      }else{
        return  Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 0),
              child: ListView(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'Login to your\naccount',
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
                            hintText: 'Email',
                            hintStyle: const TextStyle(
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
                      SizedBox(height: devicedata.size.height * 0.050),
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
                          onChanged: (value) => _password = value,
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
                              });
                            },
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text('Remember me',
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
                            child: const Text('Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )),
                            // if the password and email is valide
                            onPressed: () => {
                              if (_formKey.currentState!.validate())
                                {
                                  Login(),
                                }
                            },
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ).copyWith(color: Color(0xff94959b)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //     width: double.infinity,
                      //     height: 50,
                      //     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      //     child: ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //         primary: Colors.black, // Background color
                      //       ),
                      //       child: const Text('Login with Google',
                      //           style: TextStyle(
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.w600,
                      //           )),
                      //       onPressed: () {},
                      //     )),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ).copyWith(color: Color(0xff94959b)),
                          ),
                          TextButton(
                            onPressed: () {
                              pushNewScreen(
                                context,
                                screen: SignupView(),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ).copyWith(color: Colors.blue),
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     pushNewScreen(
                          //       context,
                          //       screen: SignupView(),
                          //       withNavBar: true, // OPTIONAL VALUE. True by default.
                          //       pageTransitionAnimation:
                          //           PageTransitionAnimation.cupertino,
                          //     );
                          //   },
                          //   child: Text(
                          //     'Register',
                          //     style: TextStyle(
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.w400,
                          //     ).copyWith(color: Colors.blue),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                ),
              ]),
            )),
          );
      }
    };
    
  }
}
