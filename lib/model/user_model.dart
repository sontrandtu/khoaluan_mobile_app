import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class UserModel {
  String? id;
  String? userName;
  String? password;
  String? token;
  String? name;
  String? address;
  String? email;
  String? phoneNumber;
  String? image;
  bool? isLock;
  double? money;

  UserModel(
      {this.email,
      this.id,
      this.userName,
      this.password,
      this.token,
      this.name,
      this.address,
      this.phoneNumber,
      this.image,
      this.isLock,
      this.money});


  String get imageUrl => image?.replaceAll("localhost", "10.0.2.2") ?? "";

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static UserModel demo = UserModel(
      id: "1234",
      userName: "sontran",
      name: "Sơn Trần",
      address: "Nghệ An",
      email: "sontran2k37@gmail.com",
      phoneNumber: "0367759794",
      image:
          "http://10.0.2.2:3000/api/images/1651069355697.jpg",
      isLock: false,
      money: 20000);
}
