// To parse this JSON data, do
//
//     final forgotPasswordModel = forgotPasswordModelFromJson(jsonString);

import 'dart:convert';

ForgotPasswordModel forgotPasswordModelFromJson(String str) => ForgotPasswordModel.fromJson(json.decode(str));

String forgotPasswordModelToJson(ForgotPasswordModel data) => json.encode(data.toJson());

class ForgotPasswordModel {
  ForgotPasswordModel({
    this.phoneNumber,
    this.newPassword,
  });

  String? phoneNumber;
  String? newPassword;

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) => ForgotPasswordModel(
    phoneNumber: json["phoneNumber"],
    newPassword: json["newPassword"],
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
    "newPassword": newPassword,
  };
}
