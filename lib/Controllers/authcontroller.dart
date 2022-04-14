import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'connection.dart';

class AuthController {
  // signup function
  static Future<http.Response> register(String name, String email, String password) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
      //"password_confirmation":passwordConfirmation,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseUrl + 'api/user/register');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    // print(response.body);
    return response;
  }
  // login function
  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseUrl + 'api/user/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print('object');
    return response;
  }

  // if there's a saved token it will auto redirect the user to his profile
  static Future savetoken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // to save the token to a secure storage to use it later
    await pref.setString("access token", token);
  }
  //logout function
  static Future logout(String token) async {
    var url = Uri.parse(baseUrl + 'api/logout');
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Charset': 'utf-8'
    };
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    return response;
  }
}
