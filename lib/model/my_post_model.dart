// To parse this JSON data, do
//
//     final myPostModel = myPostModelFromJson(jsonString);

import 'dart:convert';

import 'relatived_image_model.dart';

MyPostModel myPostModelFromJson(String str) => MyPostModel.fromJson(json.decode(str));

String myPostModelToJson(MyPostModel data) => json.encode(data.toJson());

class MyPostModel {
  MyPostModel({
    this.postData,
    this.totalData,
  });

  List<PostDatum>? postData;
  int? totalData;

  factory MyPostModel.fromJson(Map<String, dynamic> json) => MyPostModel(
    postData: List<PostDatum>.from(json["postData"].map((x) => PostDatum.fromJson(x))),
    totalData: json["totalData"],
  );

  Map<String, dynamic> toJson() => {
    "postData": List<dynamic>.from((postData ?? []).map((x) => x.toJson())),
    "totalData": totalData,
  };
}

class PostDatum {
  PostDatum({
    this.id,
    this.cityId,
    this.districtId,
    this.street,
    this.address,
    this.title,
    this.description,
    this.infoConnect,
    this.price,
    this.countDay,
    this.objectId,
    this.imagePost,
    this.status,
    this.rootLocation,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.userId,
    this.relatedImagesLists,
  });

  String? id;
  String? cityId;
  String? districtId;
  String? street;
  String? address;
  String? title;
  String? description;
  String? infoConnect;
  int? price;
  dynamic? countDay;
  String? objectId;
  String? imagePost;
  bool? status;
  String? rootLocation;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? categoryId;
  String? userId;
  List<RelatedImagesList>? relatedImagesLists;

  factory PostDatum.fromJson(Map<String, dynamic> json) => PostDatum(
    id: json["id"],
    cityId: json["cityId"],
    districtId: json["districtId"],
    street: json["street"],
    address: json["address"],
    title: json["title"],
    description: json["description"],
    infoConnect: json["infoConnect"],
    price: json["price"],
    countDay: json["countDay"],
    objectId: json["objectId"],
    imagePost: json["imagePost"],
    status: json["status"],
    rootLocation: json["rootLocation"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    categoryId: json["categoryId"],
    userId: json["userId"],
    relatedImagesLists: List<RelatedImagesList>.from(json["relatedImagesLists"].map((x) => RelatedImagesList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cityId": cityId,
    "districtId": districtId,
    "street": street,
    "address": address,
    "title": title,
    "description": description,
    "infoConnect": infoConnect,
    "price": price,
    "countDay": countDay,
    "objectId": objectId,
    "imagePost": imagePost,
    "status": status,
    "rootLocation": rootLocation,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "categoryId": categoryId,
    "userId": userId,
    "relatedImagesLists": List<dynamic>.from((relatedImagesLists ?? []).map((x) => x.toJson())),
  };
}
