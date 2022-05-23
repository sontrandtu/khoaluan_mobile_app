// To parse this JSON data, do
//
//     final postAddressModel = postAddressModelFromJson(jsonString);

import 'dart:convert';

PostAddressModel postAddressModelFromJson(String str) => PostAddressModel.fromJson(json.decode(str));

String postAddressModelToJson(PostAddressModel data) => json.encode(data.toJson());

class PostAddressModel {
  PostAddressModel({
    this.address,
  });

  String? address;

  factory PostAddressModel.fromJson(Map<String, dynamic> json) => PostAddressModel(
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
  };
}
