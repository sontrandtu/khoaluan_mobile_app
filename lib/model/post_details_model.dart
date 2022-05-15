// To parse this JSON data, do
//
//     final detailsPostModel = detailsPostModelFromJson(jsonString);

import 'dart:convert';

import 'relatived_image_model.dart';

PostDetailsModel detailsPostModelFromJson(String str) => PostDetailsModel.fromJson(json.decode(str));

String detailsPostModelToJson(PostDetailsModel data) => json.encode(data.toJson());

class PostDetailsModel {
  PostDetailsModel({
    this.infoPost,
    this.infoAuthPost,
    this.latestPost,
    this.relatedPost,
  });

  InfoPost? infoPost;
  InfoAuthPost? infoAuthPost;
  List<OtherPost>? latestPost;
  List<OtherPost>? relatedPost;

  factory PostDetailsModel.fromJson(Map<String, dynamic> json) => PostDetailsModel(
    infoPost: InfoPost.fromJson(json["infoPost"]),
    infoAuthPost: InfoAuthPost.fromJson(json["infoAuthPost"]),
    latestPost: List<OtherPost>.from(json["lastestPost"].map((x) => OtherPost.fromJson(x))),
    relatedPost: List<OtherPost>.from(json["relatedPost"].map((x) => OtherPost.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "infoPost": infoPost?.toJson(),
    "infoAuthPost": infoAuthPost?.toJson(),
    "lastestPost": List<dynamic>.from((latestPost ?? []).map((x) => x.toJson())),
    "relatedPost": List<dynamic>.from((relatedPost ?? []).map((x) => x.toJson())),
  };
}

class InfoAuthPost {
  InfoAuthPost({
    this.name,
    this.phoneNumber,
    this.imageUrl,
  });

  String? name;
  String? phoneNumber;
  String? imageUrl;

  factory InfoAuthPost.fromJson(Map<String, dynamic> json) => InfoAuthPost(
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phoneNumber": phoneNumber,
    "imageUrl": imageUrl,
  };
}

class InfoPost {
  InfoPost({
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
  dynamic countDay;
  String? objectId;
  String? imagePost;
  bool? status;
  String? rootLocation;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? categoryId;
  String? userId;
  List<RelatedImagesList>? relatedImagesLists;

  factory InfoPost.fromJson(Map<String, dynamic> json) => InfoPost(
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

List<OtherPost> otherPostFromJson(String str) => List<OtherPost>.from(json.decode(str).map((x) => OtherPost.fromJson(x)));

String otherPostToJson(List<OtherPost> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OtherPost {
  OtherPost({
    this.title,
    this.price,
    this.createdAt,
    this.imagePost,
    this.id,
  });

  String? title;
  int? price;
  DateTime? createdAt;
  String? imagePost;
  String? id;

  factory OtherPost.fromJson(Map<String, dynamic> json) => OtherPost(
    title: json["title"],
    price: json["price"],
    createdAt: DateTime.parse(json["createdAt"]),
    imagePost: json["imagePost"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "price": price,
    "createdAt": createdAt?.toIso8601String(),
    "imagePost": imagePost,
    "id": id,
  };
}