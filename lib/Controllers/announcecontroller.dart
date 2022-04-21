import 'package:http/http.dart' as http;
import 'connection.dart';
class AnnounceController {
  
  getAnnouncesdetails(String category)async{
    var url = Uri.parse(baseUrl + 'api/announce/'+category);
    http.Response response = await http.get(url);
    try {
      if(response.statusCode==200){
        return response;
      }else{
        print('failed to load rent category');
      }
    }catch(e){
      print(e);
    }
  }
}