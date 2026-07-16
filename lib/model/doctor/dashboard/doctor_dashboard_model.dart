class DoctorDashboardModel {
  bool? success;
  DashboardData? data;
  String? message;

  DoctorDashboardModel({this.success, this.data, this.message});

  DoctorDashboardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DashboardData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class DashboardData {
  String? totalAppointments;
  String? totalPatients;
  String? activeIpd;

  DashboardData({
    this.totalAppointments,
    this.totalPatients,
    this.activeIpd,
  });

  DashboardData.fromJson(Map<String, dynamic> json) {
    // We use .toString() here just in case the API returns an int instead of a string
    totalAppointments = json['total_appointments']?.toString() ?? "0";
    totalPatients = json['total_patients']?.toString() ?? "0";
    activeIpd = json['active_ipd']?.toString() ?? "0";
  }
}
class DoctorTodayScheduleModel {
  bool? success;
  List<ScheduleData>? data;
  String? message;

  DoctorTodayScheduleModel({this.success, this.data, this.message});

  DoctorTodayScheduleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ScheduleData>[];
      json['data'].forEach((v) {
        data!.add(ScheduleData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class ScheduleData {
  int? id;
  String? patientName;
  String? patientImage;
  String? time;
  String? type;
  String? status;

  ScheduleData({
    this.id,
    this.patientName,
    this.patientImage,
    this.time,
    this.type,
    this.status,
  });

  ScheduleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientName = json['patient_name'];
    patientImage = json['patient_image'];
    time = json['time'];
    type = json['type'];
    status = json['status'];
  }
}
class DoctorRecentPatientsModel {
  bool? success;
  List<RecentPatientData>? data;
  String? message;

  DoctorRecentPatientsModel({this.success, this.data, this.message});

  DoctorRecentPatientsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <RecentPatientData>[];
      json['data'].forEach((v) {
        data!.add(RecentPatientData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class RecentPatientData {
  int? id;
  String? name;
  String? image;
  String? status;
  String? lastVisit;

  RecentPatientData({
    this.id,
    this.name,
    this.image,
    this.status,
    this.lastVisit,
  });

  RecentPatientData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    lastVisit = json['last_visit'];
  }
}