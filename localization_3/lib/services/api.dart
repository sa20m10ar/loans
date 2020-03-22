import 'package:dio/dio.dart';

class Api {

  Dio dio;
  String baseUrl = "http://loans.neoxero.com/api/";

  Api() {
    dio = Dio()
    ..interceptors.add(LogInterceptor(
    responseBody: true,
    requestBody: true,
    requestHeader: true,
    request: true,
    responseHeader: true));
  }

  Future<Response> posts (String lang) {
    Map<String, dynamic> header = {
      "lang": lang,
    };
    return dio.get(baseUrl + "help", options: Options(headers: header));

  }

  Future<Response> home (String currentlang) {

    Map<String, dynamic> query = {
      "lang": currentlang,
    };
    return dio.get(baseUrl + "data/products",
        queryParameters: query);
  }

}