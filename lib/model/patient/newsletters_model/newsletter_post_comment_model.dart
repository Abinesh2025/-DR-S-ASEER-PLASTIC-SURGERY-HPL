class NewsletterCommentResponse {
  bool? success;
  NewsletterCommentData? data;
  String? message;

  NewsletterCommentResponse({this.success, this.data, this.message});

  NewsletterCommentResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? NewsletterCommentData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class NewsletterCommentData {
  int? newsletterId;
  int? patientId;
  String? comment;
  String? tenantId;
  String? updatedAt;
  String? createdAt;
  int? id;

  NewsletterCommentData(
      {this.newsletterId,
      this.patientId,
      this.comment,
      this.tenantId,
      this.updatedAt,
      this.createdAt,
      this.id});

  NewsletterCommentData.fromJson(Map<String, dynamic> json) {
    newsletterId = json['newsletter_id'];
    patientId = json['patient_id'];
    comment = json['comment'];
    tenantId = json['tenant_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newsletter_id'] = newsletterId;
    data['patient_id'] = patientId;
    data['comment'] = comment;
    data['tenant_id'] = tenantId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
