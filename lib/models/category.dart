class Category {
  int? id;
  String? img;
  String? userId;
  String? price;
  String? details;
  String? name;
  String? type;
  bool? checked;

  Category(
      {this.id,
      this.img,
      this.userId,
      this.price,
      this.details,
      this.name,
      this.type,
      this.checked = false});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    userId = json['user_id'];
    price = json['price'];
    details = json['details'];
    name = json['name'];
    type = json['type'];
    checked = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['user_id'] = this.userId;
    data['price'] = this.price;
    data['details'] = this.details;
    data['name'] = this.name;
    data['type'] = this.type;
    data['checked'] = this.checked;
    return data;
  }
}
