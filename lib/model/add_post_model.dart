// To parse this JSON data, do
//
//     final addPostModel = addPostModelFromJson(jsonString);

import 'dart:convert';

AddPostModel addPostModelFromJson(String str) => AddPostModel.fromJson(json.decode(str));

String addPostModelToJson(AddPostModel data) => json.encode(data.toJson());

class AddPostModel {
  AddPostModel({
    this.info,
    this.relatedImages,
  });

  Info? info;
  List<RelatedImage>? relatedImages;

  factory AddPostModel.fromJson(Map<String, dynamic> json) => AddPostModel(
    info: Info.fromJson(json["info"]),
    relatedImages: List<RelatedImage>.from(json["relatedImages"].map((x) => RelatedImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "info": info?.toJson(),
    "relatedImages": List<dynamic>.from(relatedImages!.map((x) => x.toJson())),
  };
}

class Info {
  Info({
    this.title,
    this.description,
    this.infoConnect,
    this.price,
    this.objectId,
    this.imagePost,
    this.categoryId,
    this.userId,
    this.cityId,
    this.districtId,
    this.street,
    this.address,
    this.rootLocation,
  });

  String? title;
  String? description;
  String? infoConnect;
  int? price;
  String? objectId;
  String? imagePost;
  String? categoryId;
  String? userId;
  int? cityId;
  int? districtId;
  String? street;
  String? address;
  String? rootLocation;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    title: json["title"],
    description: json["description"],
    infoConnect: json["infoConnect"],
    price: json["price"],
    objectId: json["objectId"],
    imagePost: json["imagePost"],
    categoryId: json["categoryId"],
    userId: json["userId"],
    cityId: json["cityId"],
    districtId: json["districtId"],
    street: json["street"],
    address: json["address"],
    rootLocation: json["rootLocation"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "infoConnect": infoConnect,
    "price": price,
    "objectId": objectId,
    "imagePost": imagePost,
    "categoryId": categoryId,
    "userId": userId,
    "cityId": cityId,
    "districtId": districtId,
    "street": street,
    "address": address,
    "rootLocation": rootLocation,
  };
}

class RelatedImage {
  RelatedImage({
    this.url,
  });

  String? url;

  factory RelatedImage.fromJson(Map<String, dynamic> json) => RelatedImage(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}

