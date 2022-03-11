import 'package:json_annotation/json_annotation.dart';

import '../../app_config.dart';


part 'login_doctor_response.g.dart';

@JsonSerializable(anyMap: true, includeIfNull: false)
class LoginDoctorResponse {
  int? id;
  int? sequence;
  String? name;
  String? image;
  @JsonKey(name: 'physician_id')
  int? physicianId;
  @JsonKey(name: 'write_date')
  String? writeDate;

  String get imageUrl {
    return AppConfig.prefixUrl + image!;
  }

  LoginDoctorResponse(this.id, this.sequence, this.name, this.image,this.physicianId,this.writeDate);

  factory LoginDoctorResponse.fromJson(Map<String, dynamic> json) => _$LoginDoctorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDoctorResponseToJson(this);
}
