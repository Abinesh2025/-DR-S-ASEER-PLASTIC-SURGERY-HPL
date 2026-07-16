class MedicineCategoryModel {
  int? id;
  String? name;

  MedicineCategoryModel({this.id, this.name});

  MedicineCategoryModel.fromJson(Map<String, dynamic> json) {
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

class MedicineCategoryResponse {
  bool? success;
  String? message;
  List<MedicineCategoryModel>? data;

  MedicineCategoryResponse({this.success, this.message, this.data});

  MedicineCategoryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MedicineCategoryModel>[];
      json['data'].forEach((v) {
        data!.add(MedicineCategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicineCategoryDetailsResponse {
  bool? success;
  String? message;
  MedicineCategoryModel? data;

  MedicineCategoryDetailsResponse({this.success, this.message, this.data});

  MedicineCategoryDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? MedicineCategoryModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
