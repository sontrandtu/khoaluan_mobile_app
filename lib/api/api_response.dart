import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:khoaluan_mobile_app/api/server_error.dart';
import 'package:retrofit/retrofit.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  T? data;
  String? messages;
  int? code;
  dynamic error;

  ApiResponse({this.data, this.code, this.messages, this.error}) {
    if (error is DioError) {
      if (messages == null || (messages?.isEmpty ?? true)) {
        messages = ServerError.withDioError(error: error).errorMessage;
      }
      return;
    } else {
      messages = error.toString();
    }
  }

  bool get isOk => code == 200;
  // bool get isOnWebsite => code == 302;
}

extension FutureExtensions<T> on Future<HttpResponse<T>> {
  Future<ApiResponse<T>> wrap() async {
    try {
      final httpResponse = await this;
      return Future.value(ApiResponse<T>(data: httpResponse.data, code: httpResponse.response.statusCode));
    } catch (error) {
      log('FutureExtensions ===================================${error.toString()}');
      if (error is DioError) {
        if(error.response == null){
          return Future.value(ApiResponse(code: error.response?.statusCode ?? 0, error: error));
        }else{
          final String? message = error.response?.data['messages'];
          return Future.value(ApiResponse(code: error.response?.statusCode ?? 0, error: error,messages: message));
        }

      } else {
        return Future.value(ApiResponse(error: error));
      }
    }
  }
}
