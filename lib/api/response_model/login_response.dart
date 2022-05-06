class LoginResponse {
  String? messages;
  String? token;
  LoginResponse({this.messages, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    messages: json["messages"],
    // token: json["password"],
    token: json["token"],
  );

  // Map<String, dynamic> toJson() => {
  //   "userName": userName,
  //   "password": password,
  //   "token": token,
  // };
}
