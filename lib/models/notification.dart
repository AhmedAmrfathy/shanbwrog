class Notification {
  late int id;
  late String content;
  late int isRead;
  late String userId;
  late Null orderId;
  late String fromUserId;
  late String type;
  late String notifyType;
  late String isActive;
  late String createdAt;
  late String updatedAt;
  late String reservationId;
  late String contentAr;
  late String fromUserName;
  late String fromUserAvatar;
  late String time;
  late String date;
  late String ago;
  late String title;

  Notification(
      {required this.id,
      required this.content,
      required this.isRead,
      required this.userId,
      required this.orderId,
      required this.fromUserId,
      required this.type,
      required this.notifyType,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt,
      required this.reservationId,
      required this.contentAr,
      required this.fromUserName,
      required this.fromUserAvatar,
      required this.time,
      required this.date,
      required this.ago,
      required this.title});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    isRead = json['is_read'];
    userId = json['user_id'];
    orderId = json['order_id'];
    fromUserId = json['from_user_id'];
    type = json['type'];
    notifyType = json['notify_type'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reservationId = json['reservation_id'];
    contentAr = json['content_ar'];
    fromUserName = json['from_user_name'];
    fromUserAvatar = json['from_user_avatar'];
    time = json['time'];
    date = json['date'];
    ago = json['ago'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['is_read'] = this.isRead;
    data['user_id'] = this.userId;
    data['order_id'] = this.orderId;
    data['from_user_id'] = this.fromUserId;
    data['type'] = this.type;
    data['notify_type'] = this.notifyType;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['reservation_id'] = this.reservationId;
    data['content_ar'] = this.contentAr;
    data['from_user_name'] = this.fromUserName;
    data['from_user_avatar'] = this.fromUserAvatar;
    data['time'] = this.time;
    data['date'] = this.date;
    data['ago'] = this.ago;
    data['title'] = this.title;
    return data;
  }
}
