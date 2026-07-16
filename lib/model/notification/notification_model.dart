class NotificationModel {
  bool? success;
  List<NotificationItem>? data;
  String? message;

  NotificationModel({this.success, this.data, this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <NotificationItem>[];
      json['data'].forEach((v) {
        data!.add(NotificationItem.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class NotificationItem {
  int? id;
  int? type;
  String? typeLabel;
  String? title;
  String? text;
  String? body;
  String? meta;
  String? image;
  String? readAt;
  String? createdAt;

  NotificationItem(
      {this.id,
      this.type,
      this.typeLabel,
      this.title,
      this.text,
      this.body,
      this.meta,
      this.image,
      this.readAt,
      this.createdAt});

  NotificationItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    typeLabel = json['type_label'];
    title = json['title'];
    text = json['text'];
    body = json['body'];
    meta = json['meta'];
    image = json['image'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['type_label'] = typeLabel;
    data['title'] = title;
    data['text'] = text;
    data['body'] = body;
    data['meta'] = meta;
    data['image'] = image;
    data['read_at'] = readAt;
    data['created_at'] = createdAt;
    return data;
  }
}

