// To parse this JSON data, do
//
//     final messagesModel = messagesModelFromJson(jsonString);

import 'dart:convert';

MessagesModel messagesModelFromJson(String str) => MessagesModel.fromJson(json.decode(str));

String messagesModelToJson(MessagesModel data) => json.encode(data.toJson());

class MessagesModel {
  MessagesModel({
    this.messages,
  });

  String? messages;

  factory MessagesModel.fromJson(Map<String, dynamic> json) => MessagesModel(
    messages: json["messages"],
  );

  Map<String, dynamic> toJson() => {
    "messages": messages,
  };
}
