// To parse this JSON data, do
//
//     final latLngModel = latLngModelFromJson(jsonString);

import 'dart:convert';

LatLngModel latLngModelFromJson(String str) => LatLngModel.fromJson(json.decode(str));

String latLngModelToJson(LatLngModel data) => json.encode(data.toJson());

class LatLngModel {
  LatLngModel({
    this.address,
    this.rootLocation,
  });

  String? address;
  String? rootLocation;

  factory LatLngModel.fromJson(Map<String, dynamic> json) => LatLngModel(
    address: json["address"],
    rootLocation: json["rootLocation"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "rootLocation": rootLocation,
  };
}