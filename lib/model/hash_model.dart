// To parse this JSON data, do
//
//     final hashModel = hashModelFromJson(jsonString);

import 'dart:convert';

HashModel hashModelFromJson(String str) => HashModel.fromJson(json.decode(str));

String hashModelToJson(HashModel data) => json.encode(data.toJson());

class HashModel {
  HashModel({
    this.messages,
  });

  String? messages;

  factory HashModel.fromJson(Map<String, dynamic> json) => HashModel(
    messages: json["messages"],
  );

  Map<String, dynamic> toJson() => {
    "messages": messages,
  };
}
