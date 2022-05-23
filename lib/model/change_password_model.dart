// To parse this JSON data, do
//
//     final changePasswordModel = changePasswordModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordModel changePasswordModelFromJson(String str) => ChangePasswordModel.fromJson(json.decode(str));

String changePasswordModelToJson(ChangePasswordModel data) => json.encode(data.toJson());

class ChangePasswordModel {
  ChangePasswordModel({
    this.currentPassword,
    this.newPassword,
  });

  String? currentPassword;
  String? newPassword;

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
    currentPassword: json["currentPassword"],
    newPassword: json["newPassword"],
  );

  Map<String, dynamic> toJson() => {
    "currentPassword": currentPassword,
    "newPassword": newPassword,
  };
}
