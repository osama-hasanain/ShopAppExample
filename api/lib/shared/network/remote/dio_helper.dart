import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class DioHelper{
  static late Dio dio  ;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError:true,
        headers: {
          'Content-Type':'application/json',
        }
      ),
    );
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  static Future<Response<Map<String,dynamic>>> postDate({
    required String url,
    Map<String,dynamic>? query,
    Map<String,dynamic>? data,
    String lang = 'en',
    String? auth,
  }) async{
    dio.options.headers ={
      'lang':lang,
      'Authorization':auth
    };
    return dio.post(
        url,
        queryParameters: query,
        data: data
    );
  }

  static Future<Response<Map<String,dynamic>>> putDate({
    required String url,
    Map<String,dynamic>? query,
    Map<String,dynamic>? data,
    String lang = 'en',
    String? auth,
  }) async{
    dio.options.headers ={
      'lang':lang,
      'Authorization':auth
    };
    return dio.put(
        url,
        queryParameters: query,
        data: data
    );
  }

  static  Future<Response> getDate({
    required String url,
    Map<String,dynamic>? query,
    String? auth,
    String lang = 'en',
  }) async{
    dio.options.headers ={
      'lang':lang,
      'Authorization':auth
    };
    return await dio.get(url,queryParameters: query);
  }

}