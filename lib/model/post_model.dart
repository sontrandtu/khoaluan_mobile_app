// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {

  String? address;
  String? id;
  String? infoConnect;
  int? price;
  String? rootLocation;
  String? title;
  DateTime? createdAt;
  String? imagePost;

  PostModel({
    this.address,
    this.id,
    this.infoConnect,
    this.price,
    this.rootLocation,
    this.title,
    this.createdAt,
    this.imagePost,
  });

  String get imageUrl => imagePost?.replaceAll("localhost", "10.0.2.2") ?? "";

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    address: json["address"],
    id: json["id"],
    infoConnect: json["infoConnect"],
    price: json["price"],
    rootLocation: json["rootLocation"],
    title: json["title"],
    createdAt: DateTime.parse(json["createdAt"]),
    imagePost: json["imagePost"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "id": id,
    "infoConnect": infoConnect,
    "price": price,
    "rootLocation": rootLocation,
    "title": title,
    "createdAt": createdAt?.toIso8601String(),
    "imagePost": imagePost,
  };
}
