class NewslettersModel {
  bool? success;
  List<Newsletter>? data;
  String? message;

  NewslettersModel({this.success, this.data, this.message});

  NewslettersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Newsletter>[];
      json['data'].forEach((v) {
        data!.add(Newsletter.fromJson(v));
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

class Newsletter {
  int? id;
  String? category;
  String? title;
  String? description;
  String? image;
  String? createdAt;
  int? totalComments;
  int? totalLikes;
  int? totalShares;
  int? viewsCount;
  String? authorName;
  String? authorImage;
  String? slug;
  bool? isLiked;

  Newsletter(
      {this.id,
      this.category,
      this.title,
      this.description,
      this.image,
      this.createdAt,
      this.totalComments,
      this.totalLikes,
      this.totalShares,
      this.viewsCount,
      this.authorName,
      this.authorImage,
      this.slug,
      this.isLiked});

  Newsletter.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('title')) {
      print("Newsletter JSON data: ${json.keys}");
    }
    id = json['id'];
    category = json['category'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'] ?? json['createdAt'];
    totalComments = json['total_comments'] ?? json['totalComments'];
    totalLikes = json['total_likes'] ?? json['totalLikes'];
    totalShares = json['total_shares'] ?? json['totalShares'];
    viewsCount = json['views_count'] ?? json['viewsCount'];
    authorName = json['author_name'] ?? json['authorName'];
    authorImage = json['author_image'] ?? json['authorImage'];
    slug = json['slug'];
    isLiked = json['is_liked'] ?? json['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['total_comments'] = totalComments;
    data['total_likes'] = totalLikes;
    data['total_shares'] = totalShares;
    data['views_count'] = viewsCount;
    data['author_name'] = authorName;
    data['author_image'] = authorImage;
    data['slug'] = slug;
    data['is_liked'] = isLiked;
    return data;
  }
}
