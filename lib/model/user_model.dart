import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class UserModel {
  final String? email;
  final String? password;

  UserModel({this.email, this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}