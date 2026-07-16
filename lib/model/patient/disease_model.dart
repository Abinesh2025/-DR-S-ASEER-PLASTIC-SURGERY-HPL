class DiseaseModel {
  bool? success;
  List<DiseaseData>? data;
  String? message;

  DiseaseModel({this.success, this.data, this.message});

  DiseaseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DiseaseData>[];
      json['data'].forEach((v) {
        data!.add(DiseaseData.fromJson(v));
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

class DiseaseData {
  int? id;
  String? name;

  DiseaseData({this.id, this.name});

  DiseaseData.fromJson(Map<String, dynamic> json) {
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
