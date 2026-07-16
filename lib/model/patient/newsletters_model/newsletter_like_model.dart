class NewsletterLikeResponse {
  bool? success;
  NewsletterLikeData? data;
  String? message;

  NewsletterLikeResponse({this.success, this.data, this.message});

  NewsletterLikeResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? NewsletterLikeData.fromJson(json['data']) : null;
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

class NewsletterLikeData {
  bool? isLiked;

  NewsletterLikeData({this.isLiked});

  NewsletterLikeData.fromJson(Map<String, dynamic> json) {
    isLiked = json['is_liked'] ?? json['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_liked'] = isLiked;
    return data;
  }
}
