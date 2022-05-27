import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZThiNDA1MGRlM2UxYTk5N2UzNmIyZTc0ZTU1MWVlZDgyZDIxMzZlZDg1NDRlZjdiNGYwNzUwMjQ2Yzg5OGVmYzlkZDc5OGYxNmViMmI5ZmYiLCJpYXQiOjE2NTAwMzE2OTEuMjcxNDYyLCJuYmYiOjE2NTAwMzE2OTEuMjcxNDY3LCJleHAiOjE2ODE1Njc2OTEuMjMwMzUxLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.fFuMSXZG2FevfYGeGLboqjMAS0K4iAqex_yocKM-MC2nfJfwOEyCv1N75gGDHZaVc7-taVKyZqWCTBV_O4dHLwgTIKczJJw6VsWO92zTbd1F29G8piTv_pe_tl8vBCjtWMOmOon7LIWVrT46PATtSv2RnQ4S1ge6WCF7TdcTTI_k92oaGsRpn-xiAbUBd9MciFvrGKZ1uNsg6RPtJ5jlXdFz8CXlU3VnjeIJPcqPF2sOUdmK5C-NCRE4xg5Hk3YOgND_-oxdttOoKdJuu_fJATjNSLI7YLbJv203BUQjfkaejozOI8xQqRqd5auxBB6KDM5qq33-ESPhpFMJJrxDDFUUTtBSvizXr9MTwKRUXN1zPnjdpUAq_sfuCDFOOzFeJUgLHxihYB-ALKSQQLZX23UX9WRw-OmJIIWWKCoMGp126DpStml20bQzxd0xw666r_rFNmfFgTjYZ8VRra8FPHIcJwkPkcugVSLfwTDi6denOQmNobrkxO_LW8-LFbuDGpj8udFqnDzDHKgfkcAanhtWHppHBBcVY-R3pPa1xHQG0HlzBoZGgWpPw8TilVkTiGcBDIQStCRAEHrpmeQ_DbwmE_zo5eU4NK6IBxp5SZQRJo0KNWD1uNBklI6dtIgaCDfoRId3L0Bvj8Qv4w5JX8HcItn2x5zIIIkgNSYNo_8'
    };
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
}
