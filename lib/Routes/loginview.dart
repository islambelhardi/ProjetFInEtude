import 'package:flutter/material.dart';
import 'package:projet_fin_etude/net/auth_service.dart';
import 'package:http/http.dart' as http;
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  String _email = '';
  String _password = '';
   Future login() async {
    http.Response response = await AuthService.login(
      _email,
      _password,
    );
    print(response.body);
   }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextFormField(
              textAlign: TextAlign.start,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              controller: _emailController,
              onChanged: (value) => _email = value,
            ),
            TextFormField(
              textAlign: TextAlign.start,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              controller: _passwordController,
              onChanged: (value) => _password = value,
            ),
            ElevatedButton(onPressed:()=>login() , child: Text('Login'))
          ],
        ),
      ),
    );
  }
}
