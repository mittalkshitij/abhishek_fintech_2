import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:abhishek_fintech/networking/api_constant.dart';

class DioClient {
  final Dio _dio = Dio();
  final List<Interceptor>? interceptors;

 DioClient(this.interceptors) {
  _dio.options.baseUrl = ApiEndpoints.currencyAPIUrl;
  _dio.options.connectTimeout = const Duration(seconds: 30);
  _dio.options.receiveTimeout = const Duration(seconds: 30);
  _dio.options.headers = {'accept': 'application/json'};
  _dio.options.validateStatus = (status) {
    return status !=null &&  status < 500 ;
  };

  if (interceptors !=null && interceptors!.isNotEmpty) {
    _dio.interceptors.addAll(interceptors!);
  }
  if(kDebugMode) {
    _dio.interceptors.add(LogInterceptor(
    requestBody: true,
    requestHeader: true,
    error: true,
    responseBody: true,
    responseHeader: false
    ));
  }
 }

 Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    try{
      final response = await _dio.get(path, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
      return response;
    } on SocketException catch(e) {
      throw SocketException(e.message.toString());
    } on DioException catch(e){
      throw _handleDioError(e);
    }
  }

  Future<Response> post(String path, {Map<String, dynamic>? queryParameters, dynamic body, Options? options, CancelToken? cancleToken} ) async{
    try {
    final response = _dio.post(path, queryParameters: queryParameters, data: body, options: options, cancelToken: cancleToken );
    return response;
    }  on SocketException catch (e)  {
      throw SocketException(e.toString());
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

   // ignore: non_constant_identifier_names
   Future<Response> put(String path, {Map<String, dynamic>? queryParameters, dynamic body, Options? options, CancelToken? CancelToken} ) async{
    try {
    final response = _dio.put(path, queryParameters: queryParameters, data: body, options: options, cancelToken: CancelToken );
    return response;
    }  on SocketException catch (e)  {
      throw SocketException(e.toString());
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> delete(String path, {Map<String, dynamic>? queryParameters, dynamic body, Options? options, CancelToken? cancleToken} ) async{
    try {
    final response = _dio.delete(path,queryParameters: queryParameters, data: body, options: options, cancelToken: cancleToken );
    return response;
    }  on SocketException catch (e)  {
      throw SocketException(e.toString());
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

String _handleDioError(DioException error) {
    switch  (error.type) {
      case DioException.connectionTimeout:
      case DioException.sendTimeout:
      case DioException.receiveTimeout:
      return 'Timeout Error';
      case DioException.badResponse:
       final responseCode = error.response!.statusCode;
       if (responseCode != null) {
        switch (responseCode) {
          case 300:
          return 'Error';
           case 400:
          return 'Bad Request';
           case 404:
          return 'Not found';
           case 500:
          return 'Internal Server Error';
        }
       }
       break;
       case DioExceptionType.cancel:
       return 'Cancle by User';
          case DioExceptionType.unknown:
       return 'No internet connection';
          case DioExceptionType.badCertificate:
       return 'Certificate Error';
        case DioExceptionType.connectionError:
       return 'Conection Error';
       default :
       return 'Unknown error';

    }
       return 'Unknown error';
  }

}

final dioClientprovider = Provider((ref) => DioClient([]));