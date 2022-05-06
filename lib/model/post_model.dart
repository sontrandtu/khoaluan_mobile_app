class PostModel {
  String? address;
  String? id;
  String? infoConnect;
  int? price;
  String? rootLocation;
  String? title;
  String? createdAt;
  String? imagePost;

  PostModel(
      {this.address,
        this.id,
        this.infoConnect,
        this.price,
        this.rootLocation,
        this.title,
        this.createdAt,
        this.imagePost});

  PostModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    id = json['id'];
    infoConnect = json['infoConnect'];
    price = json['price'];
    rootLocation = json['rootLocation'];
    title = json['title'];
    createdAt = json['createdAt'];
    imagePost = json['imagePost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['id'] = id;
    data['infoConnect'] = infoConnect;
    data['price'] = price;
    data['rootLocation'] = rootLocation;
    data['title'] = title;
    data['createdAt'] = createdAt;
    data['imagePost'] = imagePost;
    return data;
  }
}