import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable(anyMap: true, includeIfNull: false)
class LoginResponse {
  String? otp;
  String? message;
  LoginResponse(this.otp, this.message);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
