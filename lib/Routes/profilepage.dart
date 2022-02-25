import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
  Login() async {
    http.Response response =
        await AuthService.register(_name, _email, _password);
    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('true');
    } else {
      print(json.decode(response.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Text(
          'Sign up',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.highlight_off_outlined,
        //     ),
        //   )
        // ],
      ),
      body: Center(
        child: Column(
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
              ),
              controller: _nameController,
              onChanged: (value) => _name=value,
            ),
            TextFormField(
              textAlign: TextAlign.start,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              controller: _emailController,
              onChanged: (value) => _email=value,
            ),
            TextFormField(
              textAlign: TextAlign.start,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              controller: _passwordController,
              onChanged: (value) => _password = value,
            ),
            TextButton(onPressed: () => Login(), child: const Text('Sign up')),
            const Divider(indent: 10, endIndent: 10),
            Text('Already have Account?'),
            TextButton(onPressed: (){}, child: Text('Log in'))
          ],
        ),
      ),
    );
  }
}
