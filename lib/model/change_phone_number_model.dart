// To parse this JSON data, do
//
//     final changePhoneNumberModel = changePhoneNumberModelFromJson(jsonString);

import 'dart:convert';

ChangePhoneNumberModel changePhoneNumberModelFromJson(String str) => ChangePhoneNumberModel.fromJson(json.decode(str));

String changePhoneNumberModelToJson(ChangePhoneNumberModel data) => json.encode(data.toJson());

class ChangePhoneNumberModel {
  ChangePhoneNumberModel({
    this.phoneNumber,
    this.id,
  });

  String? phoneNumber;
  String? id;

  factory ChangePhoneNumberModel.fromJson(Map<String, dynamic> json) => ChangePhoneNumberModel(
    phoneNumber: json["phoneNumber"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
    "id": id,
  };
}
