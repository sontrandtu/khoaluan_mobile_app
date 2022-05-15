// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';

List<ImageModel> imageModelFromJson(String str) => List<ImageModel>.from(json.decode(str).map((x) => ImageModel.fromJson(x)));

String imageModelToJson(List<ImageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageModel {
  ImageModel({
    this.url,
    this.filename,
    this.size,
  });

  String? url;
  String? filename;
  int? size;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    url: json["url"],
    filename: json["filename"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "filename": filename,
    "size": size,
  };
}
