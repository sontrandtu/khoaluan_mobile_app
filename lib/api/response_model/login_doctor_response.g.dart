// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_doctor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDoctorResponse _$LoginDoctorResponseFromJson(Map json) {
  return LoginDoctorResponse(
    json['id'] as int?,
    json['sequence'] as int?,
    json['name'] as String?,
    json['image'] as String?,
    json['physician_id'] as int?,
    json['write_date'] as String?,
  );
}

Map<String, dynamic> _$LoginDoctorResponseToJson(LoginDoctorResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('sequence', instance.sequence);
  writeNotNull('name', instance.name);
  writeNotNull('image', instance.image);
  writeNotNull('physician_id', instance.physicianId);
  writeNotNull('write_date', instance.writeDate);
  return val;
}
