class UserModel {
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
  dynamic? rating;

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
      this.rating});

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
    return data;
  }
}
