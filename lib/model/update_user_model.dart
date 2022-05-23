// To parse this JSON data, do
//
//     final updateUserModel = updateUserModelFromJson(jsonString);

import 'dart:convert';

UpdateUserModel updateUserModelFromJson(String str) => UpdateUserModel.fromJson(json.decode(str));

String updateUserModelToJson(UpdateUserModel data) => json.encode(data.toJson());

class UpdateUserModel {
  UpdateUserModel({
    this.name,
    this.email,
    this.phoneNumber,
    this.imageUrl,
    this.userName,
  });

  String? name;
  String? email;
  String? phoneNumber;
  String? imageUrl;
  String? userName;

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) => UpdateUserModel(
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    imageUrl: json["imageUrl"],
    userName: json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
    "imageUrl": imageUrl,
    "userName": userName,
  };
}
