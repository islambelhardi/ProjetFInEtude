import 'dart:convert';
import 'package:http/http.dart' as http;
import 'connection.dart';
class AuthService {
  static Future <http.Response>register (String name,String email ,String password) async{
    Map data = {
      "name": name,
      "email":email,
      "password":password,
      //"password_confirmation":passwordConfirmation,
    };
    var body =json.encode(data);
    var url = Uri.parse(baseUrl+'register');
    
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }
  static Future<http.Response> login(String email, String password)async{
    Map data = {
      "email":email,
      "password":password,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseUrl+'api/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
      );
    return response;
  }
}