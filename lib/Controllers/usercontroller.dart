import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'connection.dart';
class UserController{
  static Future <http.Response> modifyinfo(Map data)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String?token =pref.getString("access token");
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Charset': 'utf-8'
    };
    var body = json.encode(data);
    var url = Uri.parse(baseUrl + 'api/user/modify/info');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    return response;
  }
  static Future <http.Response>comment(String content ,dynamic announceId ,String token)async{
    Map data = {
      "comment": content,
      "announce_id": announceId,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Charset': 'utf-8'
    };
    var body = json.encode(data);
    var url = Uri.parse(baseUrl + 'api/announce/comment');
     http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    return response;
  }
}