import 'package:flutter/foundation.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/category.dart' as cat;
import 'package:shanbwrog/server/dionetwork.dart';
import 'package:shanbwrog/server/endpoints.dart';

class UserModel with ChangeNotifier {
  bool isloadingtoggleFavourite = false;
  int? id;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  String? active;
  String? userType;
  String? address;
  String? lat;
  String? lng;
  String? cityId;
  String? countryId;
  String? subscription;
  String? commercialRegister;
  String? fromTime;
  String? toTime;
  String? distance;
  String? token;
  List<Images>? images;
  List<Rate>? rates;
  List<cat.Category>? categories;
  int? rating;
  int? rates_count;
  bool? isLiked;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.avatar,
      this.active,
      this.userType,
      this.address,
      this.lat,
      this.lng,
      this.cityId,
      this.countryId,
      this.subscription,
      this.commercialRegister,
      this.fromTime,
      this.toTime,
      this.distance,
      this.token,
      this.rating,
      this.rates_count,
      this.rates,
      this.categories,
      this.images,
      this.isLiked = false});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    active = json['active'];
    userType = json['user_type'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    cityId = json['city_id'];
    countryId = json['country_id'];
    subscription = json['subscription'];
    commercialRegister = json['commercial_register'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    token = json['token'];
    rating = json['rating'];
    rates_count = json['rates_count'];
    isLiked = json['isLiked'] == 0 ? false : true;
    if (json['rates'] != null) {
      rates = (json['rates'] as List).map((e) => Rate.fromJson(e)).toList();
    }
    if (json['images'] != null) {
      images = (json['images'] as List).map((e) => Images.fromJson(e)).toList();
    }
    if (json['categories'] != null) {
      categories = (json['categories'] as List)
          .map((e) => cat.Category.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['active'] = this.active;
    data['user_type'] = this.userType;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['city_id'] = this.cityId;
    data['country_id'] = this.countryId;
    data['subscription'] = this.subscription;
    data['commercial_register'] = this.commercialRegister;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['token'] = this.token;
    data['rating'] = this.rating;
    data['rates_count'] = this.rates_count;
    data['isLiked'] = this.isLiked == 0 ? false : true;
    if (this.rates != null) {
      data['rates'] = this.rates!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Future<Map<String, dynamic>> toggleFavourite(
      {int? providerId, String? lang, String? token}) async {
    isLiked = !isLiked!;
    notifyListeners();
    Future.delayed(Duration(milliseconds: 1), () {
      isloadingtoggleFavourite = true;
      notifyListeners();
    });
    Map<String, dynamic> headers = {
      "Accept-Language": lang,
      "Authorization": token
    };
    String url = EndPoints.baseurl + '/like';

    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: lang,
        dioHeaders: headers,
        methodType: 'post',
        dioBody: {"provider_id": providerId},
        netWorkWorking: MySettings.netWorkWorking(),
        url: url);
    isloadingtoggleFavourite = false;
    notifyListeners();
    if (response['status'] == false) {
      return {'status': false, 'error': response['msg']};
    } else {
      notifyListeners();
      return {'status': true, 'msg': response['data']['msg']};
    }
  }
}

class Images {
  int? id;
  String? img;
  String? userId;
  String? createdAt;
  String? updatedAt;
  bool? localImage;

  Images(
      {this.id,
      this.img,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.localImage = false});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    localImage = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Rate {
  late int id;
  late String rating;
  late String comment;
  late String userId;
  late String rateableId;
  late String rateableType;
  late String createdAt;
  late String userImg;
  late String userName;

  Rate(
      {required this.id,
      required this.rating,
      required this.comment,
      required this.userId,
      required this.rateableId,
      required this.rateableType,
      required this.createdAt,
      required this.userImg,
      required this.userName});

  Rate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'].toString();
    comment = json['comment'];
    userId = json['user_id'].toString();
    rateableId = json['rateable_id'].toString();
    rateableType = json['rateable_type'];
    createdAt = json['created_at'];
    userImg = json['user_img'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['user_id'] = this.userId;
    data['rateable_id'] = this.rateableId;
    data['rateable_type'] = this.rateableType;
    data['created_at'] = this.createdAt;
    data['user_img'] = this.userImg;
    data['user_name'] = this.userName;
    return data;
  }
}
