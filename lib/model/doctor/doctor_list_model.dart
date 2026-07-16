class DoctorListModel {
  bool? success;
  List<DoctorListData>? data;
  String? message;

  DoctorListModel({this.success, this.data, this.message});

  DoctorListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DoctorListData>[];
      json['data'].forEach((v) {
        data!.add(DoctorListData.fromJson(v));
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

class DoctorListData {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? gender;
  String? genderString;
  String? department;
  int? departmentId;
  String? specialist;
  int? appointmentCharge;
  String? description;
  String? imageUrl;
  int? appointmentsCount;

  DoctorListData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.genderString,
    this.department,
    this.departmentId,
    this.specialist,
    this.appointmentCharge,
    this.description,
    this.imageUrl,
    this.appointmentsCount,
  });

  DoctorListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    genderString = json['gender_string'];
    department = json['department'];
    departmentId = json['department_id'];
    specialist = json['specialist'];
    // Handle double/int mapping safely
    if (json['appointment_charge'] != null) {
      appointmentCharge = (json['appointment_charge'] as num).toInt();
    }
    description = json['description'];
    imageUrl = json['image_url'];
    appointmentsCount = json['appointments_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['gender'] = gender;
    data['gender_string'] = genderString;
    data['department'] = department;
    data['department_id'] = departmentId;
    data['specialist'] = specialist;
    data['appointment_charge'] = appointmentCharge;
    data['description'] = description;
    data['image_url'] = imageUrl;
    data['appointments_count'] = appointmentsCount;
    return data;
  }
}
