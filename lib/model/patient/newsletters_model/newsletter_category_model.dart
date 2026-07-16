class NewsletterCategoryModel {
  bool? success;
  List<NewsletterCategory>? data;
  String? message;

  NewsletterCategoryModel({this.success, this.data, this.message});

  NewsletterCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <NewsletterCategory>[];
      json['data'].forEach((v) {
        data!.add(NewsletterCategory.fromJson(v));
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

class NewsletterCategory {
  int? id;
  String? name;

  NewsletterCategory({this.id, this.name});

  NewsletterCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
