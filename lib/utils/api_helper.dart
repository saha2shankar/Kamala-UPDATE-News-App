import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kamala_update/utils/constants.dart';

class ApiHelper {
  late Dio _dio;
  ApiHelper() {
    _dio = Dio(BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'}));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Do something before request is sent
        debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
        debugPrint('Headers: ${options.headers}');
        debugPrint('Body: ${options.data}');
        return handler.next(options); // continue
      },
      onResponse: (response, handler) {
        // Do something with response data
        // debugPrint(
        //     'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        // debugPrint('Headers: ${response.headers}');
        // debugPrint('Body: ${response.data}');
        return handler.next(response); // continue
      },
      onError: (DioException error, handler) {
        return handler.next(error);
      },
    ));
  }

  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      Response response =
          await _dio.get(endpoint, queryParameters: queryParams);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> post(String endpoint, {dynamic data}) async {
    try {
      Response response = await _dio.post(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> put(String endpoint, {dynamic data}) async {
    try {
      Response response = await _dio.put(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      Response response = await _dio.delete(endpoint);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Exception(
              'Connection Timeout, Please check your internet connection.');
        case DioExceptionType.sendTimeout:
          return Exception(
              'Send Timeout , Please check your internet connection.');
        case DioExceptionType.receiveTimeout:
          return Exception(
              'Receive Timeout, Please check your internet connection.');
        case DioExceptionType.badResponse:
          return Exception('Bad Response, Please try again.');
        case DioExceptionType.cancel:
          return Exception('Request to server was cancelled.');
        case DioExceptionType.unknown:
          return Exception('Something went wrong, Please try again.');
        default:
          return Exception(
              'Unexpected error occurred, Please try again later.');
      }
    } else {
      return Exception(
          'Server Error: ${error.toString()}, Please try again later.');
    }
  }
}
