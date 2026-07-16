class NewsletterCommentsModel {
  bool? success;
  List<NewsletterComment>? data;
  String? message;

  NewsletterCommentsModel({this.success, this.data, this.message});

  NewsletterCommentsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <NewsletterComment>[];
      json['data'].forEach((v) {
        data!.add(NewsletterComment.fromJson(v));
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

class NewsletterComment {
  int? id;
  String? patientName;
  String? patientImage;
  String? comment;
  String? createdAt;

  NewsletterComment(
      {this.id,
      this.patientName,
      this.patientImage,
      this.comment,
      this.createdAt});

  NewsletterComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientName = json['patient_name'];
    patientImage = json['patient_image'];
    comment = json['comment'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['patient_name'] = patientName;
    data['patient_image'] = patientImage;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    return data;
  }
}
