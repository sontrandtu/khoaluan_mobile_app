class LoginResponse {
  String? userName;
  String? password;
  LoginResponse({this.userName, this.password});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    userName: json["userName"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "password": password,
  };

  // factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
