// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Routes/profilepage.dart';

class SignupView extends StatefulWidget {
  SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
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
        child: ListView(children: [
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
          Expanded(
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
                      hintText: 'Agency Name',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ).copyWith(color: Color(0xff94959b)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
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
                  ),
                ),
                SizedBox(
                  height: devicedata.size.height * 0.050,
                ),

                //size
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
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
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
                      onPressed: () {},
                    )),

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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
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
        ]),
      )),
    );
    ;
  }
}