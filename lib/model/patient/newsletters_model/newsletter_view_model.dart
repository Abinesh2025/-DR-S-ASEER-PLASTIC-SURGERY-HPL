class NewsletterViewResponse {
  bool? success;
  NewsletterViewData? data;
  String? message;

  NewsletterViewResponse({this.success, this.data, this.message});

  NewsletterViewResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? NewsletterViewData.fromJson(json['data']) : null;
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

class NewsletterViewData {
  int? viewsCount;

  NewsletterViewData({this.viewsCount});

  NewsletterViewData.fromJson(Map<String, dynamic> json) {
    viewsCount = json['views_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['views_count'] = viewsCount;
    return data;
  }
}
