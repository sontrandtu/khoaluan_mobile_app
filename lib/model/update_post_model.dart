// To parse this JSON data, do
//
//     final updatePostModel = updatePostModelFromJson(jsonString);

import 'dart:convert';

UpdatePostModel updatePostModelFromJson(String str) => UpdatePostModel.fromJson(json.decode(str));

String updatePostModelToJson(UpdatePostModel data) => json.encode(data.toJson());

class UpdatePostModel {
  UpdatePostModel({
    this.info,
    this.newRelatedImage,
    this.oldRelatedImage,
  });

  Info? info;
  List<NewRelatedImage>? newRelatedImage;
  List<OldRelatedImage>? oldRelatedImage;

  factory UpdatePostModel.fromJson(Map<String, dynamic> json) => UpdatePostModel(
    info: Info.fromJson(json["info"]),
    newRelatedImage: List<NewRelatedImage>.from(json["newRelatedImage"].map((x) => NewRelatedImage.fromJson(x))),
    oldRelatedImage: List<OldRelatedImage>.from(json["oldRelatedImage"].map((x) => OldRelatedImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "info": info?.toJson(),
    "newRelatedImage": List<dynamic>.from((newRelatedImage ?? []).map((x) => x.toJson())),
    "oldRelatedImage": List<dynamic>.from((oldRelatedImage ?? []).map((x) => x.toJson())),
  };
}

class Info {
  Info({
    this.categoryId,
    this.cityId,
    this.countDay,
    this.description,
    this.id,
    this.imagePost,
    this.objectId,
    this.price,
    this.status,
    this.title,
    this.userId,
    this.districtId
  });

  String? categoryId;
  String? cityId;
  dynamic countDay;
  String? description;
  String? id;
  String? imagePost;
  String? objectId;
  int? price;
  bool? status;
  String? title;
  String? userId;
  String? districtId;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
      categoryId: json["categoryId"],
      cityId: json["cityId"],
      countDay: json["countDay"],
      description: json["description"],
      id: json["id"],
      imagePost: json["imagePost"],
      objectId: json["objectId"],
      price: json["price"],
      status: json["status"],
      title: json["title"],
      userId: json["userId"],
      districtId: json["districtId"]
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "cityId": cityId,
    "countDay": countDay,
    "description": description,
    "id": id,
    "imagePost": imagePost,
    "objectId": objectId,
    "price": price,
    "status": status,
    "title": title,
    "userId": userId,
    "districtId": districtId
  };
}

class NewRelatedImage {
  NewRelatedImage({
    this.url,
  });

  String? url;

  factory NewRelatedImage.fromJson(Map<String, dynamic> json) => NewRelatedImage(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}

class OldRelatedImage {
  OldRelatedImage({
    this.id,
    this.url,
  });

  String? id;
  String? url;

  factory OldRelatedImage.fromJson(Map<String, dynamic> json) => OldRelatedImage(
    id: json["id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
  };
}
