class VisitingConsultantListModel {
  bool? success;
  String? message;
  List<VisitingConsultantData>? data;

  VisitingConsultantListModel({
    this.success,
    this.message,
    this.data,
  });

  factory VisitingConsultantListModel.fromJson(Map<String, dynamic> json) {
    var rawData = json['data'];
    List<VisitingConsultantData>? list;
    if (rawData is List) {
      list = rawData.map((e) => VisitingConsultantData.fromJson(e as Map<String, dynamic>)).toList();
    } else if (rawData is Map<String, dynamic> && rawData['data'] is List) {
      list = (rawData['data'] as List)
          .map((e) => VisitingConsultantData.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return VisitingConsultantListModel(
      success: json['success'] as bool? ?? (json['status'] == true || json['status'] == 200),
      message: json['message']?.toString(),
      data: list ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}

class VisitingConsultantDetailModel {
  bool? success;
  String? message;
  VisitingConsultantData? data;

  VisitingConsultantDetailModel({
    this.success,
    this.message,
    this.data,
  });

  factory VisitingConsultantDetailModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'] is Map<String, dynamic> ? json['data'] : json;
    return VisitingConsultantDetailModel(
      success: json['success'] as bool? ?? true,
      message: json['message']?.toString(),
      data: rawData != null ? VisitingConsultantData.fromJson(rawData as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}

class VisitingConsultantData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? qualification;
  String? department;
  int? departmentId;
  String? specialty;
  int? specialtyId;
  String? designation;
  String? experience;
  String? visitingDays;
  String? visitingHours;
  String? consultationFee;
  bool? opdAvailable;
  bool? ipdAvailable;
  String? avatar;
  String? bio;
  String? status;

  VisitingConsultantData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.qualification,
    this.department,
    this.departmentId,
    this.specialty,
    this.specialtyId,
    this.designation,
    this.experience,
    this.visitingDays,
    this.visitingHours,
    this.consultationFee,
    this.opdAvailable,
    this.ipdAvailable,
    this.avatar,
    this.bio,
    this.status,
  });

  factory VisitingConsultantData.fromJson(Map<String, dynamic> json) {
    // Handle nested department/specialty if returned as objects or strings
    String? deptName;
    int? deptId;
    if (json['department'] is Map) {
      deptName = json['department']['name']?.toString() ?? json['department']['title']?.toString();
      deptId = int.tryParse(json['department']['id']?.toString() ?? '');
    } else if (json['department'] is String && json['department'].toString().trim().isNotEmpty) {
      deptName = json['department'].toString().trim();
      deptId = int.tryParse(json['department_id']?.toString() ?? '');
    } else {
      deptName = json['department_name']?.toString() ??
          json['doctor_department']?.toString() ??
          json['department_title']?.toString();
      deptId = int.tryParse(json['department_id']?.toString() ?? '');
    }

    if ((deptName == null || deptName.isEmpty) && json['doctor'] is Map) {
      final docMap = json['doctor'] as Map;
      if (docMap['department'] is Map) {
        deptName = docMap['department']['name']?.toString() ?? docMap['department']['title']?.toString();
      } else {
        deptName = docMap['department']?.toString() ??
            docMap['department_name']?.toString() ??
            docMap['doctor_department']?.toString();
      }
    }

    String? specName;
    int? specId;
    if (json['specialty'] is Map) {
      specName = json['specialty']['name']?.toString() ?? json['specialty']['title']?.toString();
      specId = int.tryParse(json['specialty']['id']?.toString() ?? '');
    } else if (json['specialty'] is String && json['specialty'].toString().trim().isNotEmpty) {
      specName = json['specialty'].toString().trim();
      specId = int.tryParse(json['specialty_id']?.toString() ?? '');
    } else {
      specName = json['specialization']?.toString() ??
          json['specialist']?.toString() ??
          json['specialty_name']?.toString();
      specId = int.tryParse(json['specialty_id']?.toString() ?? '');
    }

    if ((specName == null || specName.isEmpty) && json['doctor'] is Map) {
      final docMap = json['doctor'] as Map;
      specName = docMap['specialist']?.toString() ??
          docMap['specialty']?.toString() ??
          docMap['specialization']?.toString();
    }

    // Name formatting (e.g. first_name + last_name or full_name)
    String? fullName = json['name']?.toString();
    if (fullName == null || fullName.isEmpty) {
      final first = json['first_name']?.toString() ?? '';
      final last = json['last_name']?.toString() ?? '';
      fullName = "$first $last".trim();
      if (fullName.isEmpty && json['doctor'] is Map) {
        fullName = json['doctor']['name']?.toString() ??
            "${json['doctor']['first_name'] ?? ''} ${json['doctor']['last_name'] ?? ''}".trim();
      }
    }

    // Avatar resolution
    String? image = json['avatar']?.toString() ??
        json['image']?.toString() ??
        json['profile_image']?.toString() ??
        json['image_url']?.toString();

    final cleanDept = (deptName != null && deptName.trim().isNotEmpty) ? deptName.trim() : null;
    final cleanSpec = (specName != null && specName.trim().isNotEmpty) ? specName.trim() : null;

    return VisitingConsultantData(
      id: int.tryParse(json['id']?.toString() ?? ''),
      name: fullName.isNotEmpty ? fullName : "Specialist Consultant",
      email: json['email']?.toString(),
      phone: json['phone']?.toString() ?? json['contact_no']?.toString(),
      qualification: json['qualification']?.toString() ?? json['education']?.toString(),
      department: cleanDept ?? cleanSpec,
      departmentId: deptId,
      specialty: cleanSpec ?? cleanDept,
      specialtyId: specId,
      designation: json['designation']?.toString() ?? "Visiting Consultant",
      experience: json['experience']?.toString(),
      visitingDays: json['visiting_days']?.toString() ?? json['days']?.toString() ?? "On Demand & Scheduled",
      visitingHours: json['visiting_hours']?.toString() ?? json['hours']?.toString(),
      consultationFee: json['consultation_fee']?.toString() ?? json['fee']?.toString(),
      opdAvailable: json['opd_available'] == true || json['opd_available'] == 1 || json['opd_available'] == null,
      ipdAvailable: json['ipd_available'] == true || json['ipd_available'] == 1 || json['ipd_available'] == null,
      avatar: image,
      bio: json['bio']?.toString() ?? json['description']?.toString() ?? json['notes']?.toString(),
      status: json['status']?.toString() ?? "Active",
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'qualification': qualification,
    'department': department,
    'department_id': departmentId,
    'specialty': specialty,
    'specialty_id': specialtyId,
    'designation': designation,
    'experience': experience,
    'visiting_days': visitingDays,
    'visiting_hours': visitingHours,
    'consultation_fee': consultationFee,
    'opd_available': opdAvailable,
    'ipd_available': ipdAvailable,
    'avatar': avatar,
    'bio': bio,
    'status': status,
  };
}
