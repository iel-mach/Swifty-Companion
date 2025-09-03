import 'package:dio/dio.dart';
import 'package:swif/helper/function.dart';
import 'package:swif/services/http_service.dart';

class DataService {
  final http = HttpService();

  Future <dynamic> getUsers(String? login) async {
    String? accessToken = await getaccessToken();
    String path = "/v2/users/$login";
    try {
      http.setup(bearerToken: accessToken);
      final Response? res = await http.get(path);
      if(res?.statusCode == 200 || res?.data != null){
        return res?.data;
      }
    } catch (e) {
      print("error : $e");
      return null;
    }
  }

  Future <dynamic> getCoalition (String? login) async {
    String? accessToken = await getaccessToken();
     String path = "/v2/users/$login/coalitions";
    try {
      http.setup(bearerToken: accessToken);
      final Response? res = await http.get(path);
      if(res?.statusCode == 200 || res?.data != null){
        return res?.data;
      }
    } catch (e) {
      print("error : $e");
      return null;
    }
  }
}