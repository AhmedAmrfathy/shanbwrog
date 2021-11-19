// class Offer {
//   late int id;
//   late String img;
//   late String details;
//   late String price;
//   late String oldPrice;
//   late String title;
//   late String userId;
//   late String categoryId;
//   late String createdAt;
//   late String updatedAt;
//   late String img2;
//   late String img3;
//   late String img4;
//
//   Offer(
//       {required this.id,
//       required this.img,
//       required this.details,
//       required this.price,
//       required this.oldPrice,
//       required this.title,
//       required this.userId,
//       required this.categoryId,
//       required this.createdAt,
//       required this.updatedAt,
//       required this.img2,
//       required this.img3,
//       required this.img4});
//
//   Offer.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     img = json['img'];
//     details = json['details'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     title = json['title'];
//     userId = json['user_id'];
//     categoryId = json['category_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     img2 = json['img2'];
//     img3 = json['img3'];
//     img4 = json['img4'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['img'] = this.img;
//     data['details'] = this.details;
//     data['price'] = this.price;
//     data['old_price'] = this.oldPrice;
//     data['title'] = this.title;
//     data['user_id'] = this.userId;
//     data['category_id'] = this.categoryId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['img2'] = this.img2;
//     data['img3'] = this.img3;
//     data['img4'] = this.img4;
//     return data;
//   }
// }
import 'package:shanbwrog/models/category.dart';

class Offer {
  int? id;
  String? img;
  String? details;
  String? price;
  String? oldPrice;
  String? title;
  String? userId;

  String? address;
  String? lat;
  String? lng;

  String? categoryId;
  String? img2;
  String? img3;
  String? img4;
  Category? category;

  Offer(
      {this.id,
      this.img,
      this.details,
      this.price,
      this.oldPrice,
      this.title,
      this.userId,
      this.categoryId,
      this.address,
      this.lat,
      this.lng,
      this.img2,
      this.img3,
      this.img4,
      this.category});

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    details = json['details'];
    price = json['price'];
    oldPrice = json['old_price'];
    title = json['title'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    img2 = json['img2'];
    img3 = json['img3'];
    img4 = json['img4'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['details'] = this.details;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['title'] = this.title;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['img2'] = this.img2;
    data['img3'] = this.img3;
    data['img4'] = this.img4;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}
