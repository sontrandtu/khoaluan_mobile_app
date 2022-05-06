import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../preference/preference.dart';

class DioHelper {
  static Dio? _dio;

  static Dio? get dioObject {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
        connectTimeout: 30000,
        receiveTimeout: 30000,
        sendTimeout: 30000,
      ));
      _dio?.interceptors.add(InterceptorsWrapper(onRequest: (
          RequestOptions options,
          handler,
          ) {
        options.headers['Content-Type'] = 'application/json';
        options.headers["Authorization"] = PreferenceManager.getValue<String>(PreferenceManager.KEY_TOKEN);
        return handler.next(options);
      }, onResponse: (response, handler) {
        return handler.next(response);
      }, onError: (error, handler) {
        if (error.response?.statusCode == 403) {
          // showMessage('Phiên đăng nhập hết hạn, vui lòng đăng nhập lại');
          PreferenceManager.logOut();
          //mainKey.currentState?.pushNamedAndRemoveUntil(PageRoutes.enterPhoneNumber, (route) => false);
        }
        return handler.next(error);
      }));
      if (kDebugMode) {
        _dio?.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, responseHeader: true, error: true, compact: true, maxWidth: 1000));
      } else {
        debugPrint = (String? message, {int? wrapWidth}) {};
      }
      return _dio;
    } else {
      return _dio;
    }
  }

  static bool needToken(String path) {
    return path.contains('/api/user/');
  }
}
