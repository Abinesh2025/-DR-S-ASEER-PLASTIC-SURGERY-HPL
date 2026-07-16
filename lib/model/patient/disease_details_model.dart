import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_list_model.dart';

class DiseaseDetailsModel {
  bool? success;
  DiseaseDetailsData? data;
  String? message;

  DiseaseDetailsModel({this.success, this.data, this.message});

  DiseaseDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? DiseaseDetailsData.fromJson(json['data']) : null;
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

class DiseaseDetailsData {
  int? id;
  String? name;
  String? description;
  List<SymptomData>? symptoms;
  List<DiseaseDoctorData>? doctors;

  DiseaseDetailsData(
      {this.id, this.name, this.description, this.symptoms, this.doctors});

  DiseaseDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    if (json['symptoms'] != null) {
      symptoms = <SymptomData>[];
      json['symptoms'].forEach((v) {
        symptoms!.add(SymptomData.fromJson(v));
      });
    }
    if (json['doctors'] != null) {
      doctors = <DiseaseDoctorData>[];
      json['doctors'].forEach((v) {
        doctors!.add(DiseaseDoctorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    if (symptoms != null) {
      data['symptoms'] = symptoms!.map((v) => v.toJson()).toList();
    }
    if (doctors != null) {
      data['doctors'] = doctors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SymptomData {
  int? id;
  String? name;
  List<TreatmentData>? treatments;

  SymptomData({this.id, this.name, this.treatments});

  SymptomData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['treatments'] != null) {
      treatments = <TreatmentData>[];
      json['treatments'].forEach((v) {
        treatments!.add(TreatmentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (treatments != null) {
      data['treatments'] = treatments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TreatmentData {
  int? id;
  String? name;
  int? symptomId;

  TreatmentData({this.id, this.name, this.symptomId});

  TreatmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symptomId = json['symptom_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['symptom_id'] = symptomId;
    return data;
  }
}

class DiseaseDoctorData {
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

  DiseaseDoctorData({
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

  DiseaseDoctorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    specialist = json['specialist'];
    // Handle double/int mapping safely for appointment_charge
    if (json['appointment_charge'] != null) {
      appointmentCharge = (json['appointment_charge'] as num).toInt();
    }
    description = json['description'];
    appointmentsCount = json['appointments_count'];

    // Map details from nested 'user' object
    if (json['user'] != null) {
      final user = json['user'];
      name = user['full_name'];
      email = user['email'];
      phone = user['phone'];
      imageUrl = user['profile_image'];
      // Gender typically in user object too if needed, but not critical for card
      gender = user['gender'];
    } else {
      // Fallback if user object is missing (less likely but safe)
      name = json['name'];
      email = json['email'];
      phone = json['phone'];
      imageUrl = json['image_url'];
      gender = json['gender'];
    }

    // Additional fields mapping if they exist in root
    department = json['department'];
    departmentId = json['department_id'] ?? json['doctor_department_id'];
    genderString = json['gender_string'];
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

  // Helper to convert to DoctorListData for reuse of widgets
  DoctorListData toDoctorListData() {
    return DoctorListData(
      id: id,
      name: name,
      email: email,
      phone: phone,
      gender: gender,
      genderString: genderString,
      department: department,
      departmentId: departmentId,
      specialist: specialist,
      appointmentCharge: appointmentCharge,
      description: description,
      imageUrl: imageUrl,
      appointmentsCount: appointmentsCount,
    );
  }
}
