import 'package:shanbwrog/models/category.dart';
import 'package:shanbwrog/models/offer.dart';

class Reservation {
  int? id;
  String? reservationDate;
  String? reservationTime;
  String? name;
  String? address;
  String? lat;
  String? lng;
  String? phone;
  String? statusText;
  String? status;
  String? paymentMethod;
  String? categoryId;
  Category? category;
  Offer? offer;
  String? userId;
  String? providerId;

  Reservation(
      {this.id,
      this.reservationDate,
      this.reservationTime,
      this.name,
      this.address,
      this.lat,
      this.lng,
      this.phone,
      this.statusText,
      this.status,
      this.paymentMethod,
      this.categoryId,
      this.category,
      this.offer,
      this.userId,
      this.providerId});

  Reservation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reservationDate = json['reservation_date'];
    reservationTime = json['reservation_time'];
    name = json['name'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    phone = json['phone'];
    statusText = json['status_text'];
    status = json['status'];
    paymentMethod = json['payment_method'];
    categoryId = json['category_id'];
    category = (json['category'] != null
        ? new Category.fromJson(json['category'])
        : null);
    offer =
        (json['offer'] != null ? new Offer.fromJson(json['offer']) : null);
    userId = json['user_id'];
    providerId = json['provider_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reservation_date'] = this.reservationDate;
    data['reservation_time'] = this.reservationTime;
    data['name'] = this.name;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['phone'] = this.phone;
    data['status_text'] = this.statusText;
    data['status'] = this.status;
    data['payment_method'] = this.paymentMethod;
    data['category_id'] = this.categoryId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.offer != null) {
      data['offer'] = this.offer!.toJson();
    }

    data['user_id'] = this.userId;
    data['provider_id'] = this.providerId;
    return data;
  }
}
