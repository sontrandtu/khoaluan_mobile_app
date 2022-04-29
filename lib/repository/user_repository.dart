import 'package:khoaluan_mobile_app/api/api_response.dart';
import 'package:khoaluan_mobile_app/api/response_model/login_response.dart';
import 'package:khoaluan_mobile_app/model/user_model.dart';
import 'package:khoaluan_mobile_app/repository/repository.dart';

class UserRepository extends Repository {
  Future<ApiResponse<LoginResponse>> login({required LoginResponse loginResponse}) async {
    return await apiClient!.login(loginResponse: loginResponse).wrap();
  }
}

class LoginModel{
  String userName;
  String password;

  LoginModel({required this.userName,required this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    userName: json["userName"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "password": password,
  };
}
