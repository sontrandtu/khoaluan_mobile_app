class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.address,
    this.phoneNumber,
    this.imageUrl,
    this.isLock,
    this.money,
    this.userName,
    this.password,
  });

  String? id;
  String? name;
  String? email;
  String? address;
  String? phoneNumber;
  String? imageUrl;
  bool? isLock;
  int? money;
  String? userName;
  String? password;

    String get avatarUrl => imageUrl?.replaceAll("localhost", "10.0.2.2") ?? "";

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    address: json["address"],
    phoneNumber: json["phoneNumber"],
    imageUrl: json["imageUrl"],
    isLock: json["isLock"],
    money: json["money"],
    userName: json["userName"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "address": address,
    "phoneNumber": phoneNumber,
    "imageUrl": imageUrl,
    "isLock": isLock,
    "money": money,
    "userName": userName,
    "password": password,
  };
}
