class NewsletterDetailsModel {
  bool? success;
  NewsletterDetails? data;
  String? message;

  NewsletterDetailsModel({this.success, this.data, this.message});

  NewsletterDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? NewsletterDetails.fromJson(json['data']) : null;
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

class NewsletterDetails {
  int? id;
  String? title;
  String? description;
  String? content;
  String? image;
  String? category;
  String? authorName;
  String? authorImage;
  String? createdAt;
  int? totalComments;
  int? totalLikes;
  int? totalShares;
  int? viewsCount;
  String? slug;
  bool? isLiked;

  NewsletterDetails(
      {this.id,
      this.title,
      this.description,
      this.content,
      this.image,
      this.category,
      this.authorName,
      this.authorImage,
      this.createdAt,
      this.totalComments,
      this.totalLikes,
      this.totalShares,
      this.viewsCount,
      this.slug,
      this.isLiked});

  NewsletterDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    content = json['content'];
    image = json['image'];
    category = json['category'];
    authorName = json['author_name'] ?? json['authorName'];
    authorImage = json['author_image'] ?? json['authorImage'];
    createdAt = json['created_at'] ?? json['createdAt'];
    totalComments = json['total_comments'] ?? json['totalComments'];
    totalLikes = json['total_likes'] ?? json['totalLikes'];
    totalShares = json['total_shares'] ?? json['totalShares'];
    viewsCount = json['views_count'] ?? json['viewsCount'];
    slug = json['slug'];
    isLiked = json['is_liked'] ?? json['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['content'] = content;
    data['image'] = image;
    data['category'] = category;
    data['author_name'] = authorName;
    data['author_image'] = authorImage;
    data['created_at'] = createdAt;
    data['total_comments'] = totalComments;
    data['total_likes'] = totalLikes;
    data['total_shares'] = totalShares;
    data['views_count'] = viewsCount;
    data['slug'] = slug;
    data['is_liked'] = isLiked;
    return data;
  }
}
