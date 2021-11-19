// class Category {
//   int? id;
//   String? img;
//   String? userId;
//   String? price;
//   String? details;
//   String? name;
//   String? type;
//   bool? checked;
//
//   Category(
//       {this.id,
//       this.img,
//       this.userId,
//       this.price,
//       this.details,
//       this.name,
//       this.type,
//       this.checked = false});
//
//   Category.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     img = json['img'];
//     userId = json['user_id'];
//     price = json['price'];
//     details = json['details'];
//     name = json['name'];
//     type = json['type'];
//     checked = false;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['img'] = this.img;
//     data['user_id'] = this.userId;
//     data['price'] = this.price;
//     data['details'] = this.details;
//     data['name'] = this.name;
//     data['type'] = this.type;
//     data['checked'] = this.checked;
//     return data;
//   }
// }
class Category {
  int? id;
  String? img;
  String? img2;
  String? img3;
  String? img4;
  String? userId;
  String? category_id;
  String? price;
  String? details;
  String? name;
  String? type;
  String? address;
  String? lat;
  String? lng;
  bool? checked;

  Category(
      {this.id,
      this.img,
      this.img2,
      this.img3,
      this.img4,
      this.userId,
      this.category_id,
      this.price,
      this.details,
      this.name,
      this.type,
      this.lng,
      this.address,
      this.lat,
      this.checked});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    img2 = json['img2'];
    img3 = json['img3'];
    img4 = json['img4'];
    userId = json['user_id'];
    category_id = json['category_id'];
    price = json['price'];
    details = json['details'];
    name = json['name'];
    type = json['type'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];

    checked = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['img2'] = this.img2;
    data['img3'] = this.img3;
    data['img4'] = this.img4;
    data['user_id'] = this.userId;
    data['category_id'] = this.category_id;
    data['price'] = this.price;
    data['details'] = this.details;
    data['name'] = this.name;
    data['type'] = this.type;
    data['checked'] = this.checked;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
