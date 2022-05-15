// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationModel locationModelFromJson(String str) => LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  LocationModel({
    this.city,
    this.districts,
  });

  List<City>? city;
  List<District>? districts;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    city: List<City>.from(json["city"].map((x) => City.fromJson(x))),
    districts: List<District>.from(json["districts"].map((x) => District.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "city": List<dynamic>.from(city!.map((x) => x.toJson())),
    "districts": List<dynamic>.from(districts!.map((x) => x.toJson())),
  };
}

class City {
  City({
    this.name,
    this.code,
  });

  String? name;
  int? code;

  factory City.fromJson(Map<String, dynamic> json) => City(
    name: json["name"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
  };
}

class District {
  District({
    this.name,
    this.code,
    this.divisionType,
    this.codename,
    this.provinceCode,
    this.wards,
  });

  String? name;
  int? code;
  String? divisionType;
  String? codename;
  int? provinceCode;
  List<dynamic>? wards;

  factory District.fromJson(Map<String, dynamic> json) => District(
    name: json["name"],
    code: json["code"],
    divisionType: json["division_type"],
    codename: json["codename"],
    provinceCode: json["province_code"],
    wards: List<dynamic>.from(json["wards"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "division_type": divisionType,
    "codename": codename,
    "province_code": provinceCode,
    "wards": List<dynamic>.from(wards!.map((x) => x)),
  };
}
