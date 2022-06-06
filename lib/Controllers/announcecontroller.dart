import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:projet_fin_etude/Controllers/authcontroller.dart';
import 'connection.dart';

class AnnounceController {
  getAnnouncesdetails(String category) async {
    var url = Uri.parse(baseUrl + 'api/announce/' + category);
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        // print('failed to load rent category');
      }
    } catch (e) {
      // print(e);
    }
  }

  static getall() async {
    var url = Uri.parse(baseUrl + 'api/announce/all');
    http.Response response = await http.get(url);
    return response;
  }

  getAnnounce(id) async {
    var url = Uri.parse(baseUrl + 'api/announce/show?id=' + id.toString());
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        // print('failed to load announce');
      }
    } catch (e) {
      // print(e);
    }
    // print(response.body);
  }

  static Future<http.StreamedResponse> addannounce(
      List<XFile>? imageFileList, Map<String, String> details) async {
    var url = Uri.parse(baseUrl + 'api/announce/create');
    String? token = await AuthController.checklogin();
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', url)..fields.addAll(details);
    for (var image in imageFileList!) {
      request.files
          .add(await http.MultipartFile.fromPath('images[]', image.path));
    }

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // if (response.statusCode == 200) {
    //   // print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
    return response;
  }

  static Future filterAnnounce(Map<String, String> parametres) async {
    var url = Uri.parse(baseUrl + 'api/announce/filter');
    var body = json.encode(parametres);
    http.Response response = await http.post(url, headers: headers, body: body);
    return response;
  }

  static Future deleteannounce(id) async {
    var url = Uri.parse(baseUrl + 'api/announce/delete?id=$id');
    String? token = await AuthController.checklogin();
    var headers = {'Authorization': 'Bearer $token'};
    http.Response response = await http.delete(url, headers: headers);
    return response;
  }

  static Future<http.StreamedResponse> modifyannounce(
      Map<String, String> changes,
      List<String>? todeleteimages,
      List<XFile>? uploaded_images) async {
    String? token = await AuthController.checklogin();
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Charset': 'utf-8'
    };
    var url = Uri.parse(baseUrl + 'api/announce/modify');
    var request = http.MultipartRequest('POST', url)..fields.addAll(changes);
    print('fileds' + request.fields.toString());
    // print('changes'+changes.toString());
    if (todeleteimages != null) {
      for (var image in todeleteimages) {
        changes.addAll({'todeleteimages[]': image});
        print(changes);
        request.fields.addAll(changes);
      }
    }
    if (uploaded_images != null) {
      for (var image in uploaded_images) {
        request.files.add(
            await http.MultipartFile.fromPath('uploaded_images[]', image.path));
      }
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response;
  }
  // static Future modifyannounce(Map changes)async{
  //   String?token =await AuthController.checklogin();
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json;charset=UTF-8',
  //     'Authorization': 'Bearer $token',
  //     'Charset': 'utf-8'
  //   };
  //   var url = Uri.parse(baseUrl + 'api/announce/modify');
  //   var body = json.encode(changes);
  //   print(body);
  //   http.Response response = await http.post(url,body: body, headers: headers);
  //   return response;
  // }
}
