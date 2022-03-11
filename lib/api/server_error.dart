import 'package:dio/dio.dart';

class ServerError implements Exception {
  int? _errorCode;
  String _errorMessage = "";

  ServerError.withDioError({required DioError error}) {
    _handleError(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  get errorMessage {
    return _errorMessage;
  }

  _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        _errorMessage = "Connection timeout";
        break;
      case DioErrorType.sendTimeout:
        _errorMessage = "Send timeout";
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = "Receive timeout in connection";
        break;
      case DioErrorType.response:
        if(error.response!.statusCode == 401){
          _errorMessage =  "Token hết hạn";
        }else {
          _errorMessage =  "Received invalid status code: ${error.response?.statusCode}";
        }
        break;
      case DioErrorType.cancel:
        _errorMessage = "Request was cancelled";
        break;
      case DioErrorType.other:
        _errorMessage =  "Connection failed due to internet connection";
        break;
    }
    return _errorMessage;
  }
}