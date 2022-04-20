// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension UserModelCopyWith on UserModel {
  UserModel copyWith({
    String? email,
    String? password,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map json) {
  return UserModel(
    email: json['email'] as String?,
    password: json['password'] as String?,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  writeNotNull('password', instance.password);
  return val;
}
