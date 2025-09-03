import 'package:dio/dio.dart';

class HttpService {
  final dio = Dio();
  HttpService(){
    setup();
  }

  Future setup({String? bearerToken}) async{
    final header = {
      "Content-Type": "application/json",
    };
    if (bearerToken != null){
      header['Authorization'] = "Bearer $bearerToken";
    }
    final option = BaseOptions(
      headers: header,
      baseUrl: "https://api.intra.42.fr",
      validateStatus: (status) {
        if(status == null) return false;
        return status < 500;
      },
    );
    dio.options = option;
  }

  Future<Response?> get(String path) async{
    try {
      final response = await dio.get(path);
      return response;
    } catch (e) {
      return null;
    }
  }
}