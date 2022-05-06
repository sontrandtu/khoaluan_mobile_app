// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension UserModelCopyWith on UserModel {
  UserModel copyWith({
    String? address,
    String? email,
    String? id,
    String? image,
    bool? isLock,
    double? money,
    String? name,
    String? password,
    String? phoneNumber,
    String? token,
    String? userName,
  }) {
    return UserModel(
      address: address ?? this.address,
      email: email ?? this.email,
      id: id ?? this.id,
      image: image ?? this.image,
      isLock: isLock ?? this.isLock,
      money: money ?? this.money,
      name: name ?? this.name,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      token: token ?? this.token,
      userName: userName ?? this.userName,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map json) {
  return UserModel(
    email: json['email'] as String?,
    id: json['id'] as String?,
    userName: json['userName'] as String?,
    password: json['password'] as String?,
    token: json['token'] as String?,
    name: json['name'] as String?,
    address: json['address'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    image: json['image'] as String?,
    isLock: json['isLock'] as bool?,
    money: (json['money'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userName', instance.userName);
  writeNotNull('password', instance.password);
  writeNotNull('token', instance.token);
  writeNotNull('name', instance.name);
  writeNotNull('address', instance.address);
  writeNotNull('email', instance.email);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('image', instance.image);
  writeNotNull('isLock', instance.isLock);
  writeNotNull('money', instance.money);
  return val;
}
