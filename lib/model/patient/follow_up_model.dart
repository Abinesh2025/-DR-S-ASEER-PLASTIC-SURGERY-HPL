class FollowUpModel {
  bool? success;
  List<FollowUpData>? data;
  String? message;

  FollowUpModel({this.success, this.data, this.message});

  FollowUpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <FollowUpData>[];
      json['data'].forEach((v) {
        data!.add(FollowUpData.fromJson(v));
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

class FollowUpDetailModel {
  bool? success;
  FollowUpData? data;
  String? message;

  FollowUpDetailModel({this.success, this.data, this.message});

  FollowUpDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? FollowUpData.fromJson(json['data']) : null;
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

class FollowUpData {
  int? id;
  int? appointmentId;
  int? opdNumber;
  String? appointmentType;
  int? patientId;
  String? patientUniqueId;
  String? patientName;
  int? doctorId;
  String? doctorName;
  String? followUpDate;
  String? reason;
  String? createdAt;

  FollowUpData(
      {this.id,
      this.appointmentId,
      this.opdNumber,
      this.appointmentType,
      this.patientId,
      this.patientUniqueId,
      this.patientName,
      this.doctorId,
      this.doctorName,
      this.followUpDate,
      this.reason,
      this.createdAt});

  FollowUpData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentId = json['appointment_id'];
    opdNumber = json['opd_number'];
    appointmentType = json['appointment_type'];
    patientId = json['patient_id'];
    patientUniqueId = json['patient_unique_id'];
    patientName = json['patient_name'];
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    followUpDate = json['follow_up_date'];
    reason = json['reason'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['appointment_id'] = appointmentId;
    data['opd_number'] = opdNumber;
    data['appointment_type'] = appointmentType;
    data['patient_id'] = patientId;
    data['patient_unique_id'] = patientUniqueId;
    data['patient_name'] = patientName;
    data['doctor_id'] = doctorId;
    data['doctor_name'] = doctorName;
    data['follow_up_date'] = followUpDate;
    data['reason'] = reason;
    data['created_at'] = createdAt;
    return data;
  }
}
