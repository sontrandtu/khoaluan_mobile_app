import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class UserModel {
  final String? id;
  final String? userName;
  final String? name;
  final String? address;
  final String? email;
  final String? phoneNumber;
  final String? image;
  final bool? isLock;
  final double? money;



  UserModel({this.email, this.id, this.userName, this.name, this.address, this.phoneNumber, this.image, this.isLock, this.money});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static UserModel demo = UserModel(
    id: "1234",
    userName: "sontran",
    name: "Sơn Trần",
    address: "Nghệ An",
    email: "sontran2k37@gmail.com",
    phoneNumber: "0367759794",
    image: "https://drive.google.com/file/d/1nrFr7B5pfqvK-oGJxWiAmK1-1MmYkplQ/view?usp=sharing",
    isLock: false,
    money: 20000
  );

}