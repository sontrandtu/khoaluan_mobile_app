// To parse this JSON data, do
//
//     final resultModel = resultModelFromJson(jsonString);

import 'dart:convert';

ResultModel resultModelFromJson(String str) => ResultModel.fromJson(json.decode(str));

String resultModelToJson(ResultModel data) => json.encode(data.toJson());

class ResultModel {
  ResultModel({
    this.token,
  });

  String? token;

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
