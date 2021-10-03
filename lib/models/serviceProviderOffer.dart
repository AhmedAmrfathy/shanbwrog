class ServiceProviderOffer {
  int? id;
  String? img;
  String? details;
  String? price;
  String? oldPrice;
  String? title;
  String? userId;
  String? categoryId;
  String? createdAt;
  String? updatedAt;

  ServiceProviderOffer(
      {this.id,
      this.img,
      this.details,
      this.price,
      this.oldPrice,
      this.title,
      this.userId,
      this.categoryId,
      this.createdAt,
      this.updatedAt});

  ServiceProviderOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    details = json['details'];
    price = json['price'];
    oldPrice = json['old_price'];
    title = json['title'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
