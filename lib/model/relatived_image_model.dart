import 'dart:convert';

class RelatedImagesList {
  RelatedImagesList({
    this.id,
    this.url,
  });

  String? id;
  String? url;

  factory RelatedImagesList.fromJson(Map<String, dynamic> json) => RelatedImagesList(
    id: json["id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
  };
}