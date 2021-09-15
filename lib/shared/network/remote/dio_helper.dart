import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
        ));
  }

  static Future<Response> postData({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> queryParameters,
    String lang = "er",
    String token,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
       "Authorization": token};
    return await dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }

  static Future<Response> getData(
      {@required String url,
       Map<String, dynamic> queryParameters,
       String lang="en",
       String token
       }) async {
        dio.options.headers={
          "Content-Type": "application/json",
          "lang":lang,
          "Authorization":token};
    return await dio.get(url, queryParameters: queryParameters);
  }
}
