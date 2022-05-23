// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    this.name,
    this.phoneNumber,
    this.email,
    this.password,
    this.userName,
  });

  String? name;
  String? phoneNumber;
  String? email;
  String? password;
  String? userName;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    password: json["password"],
    userName: json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phoneNumber": phoneNumber,
    "email": email,
    "password": password,
    "userName": userName,
  };
}
