class VisitingConsultantSummaryModel {
  bool? success;
  String? message;
  VisitingSummaryData? data;

  VisitingConsultantSummaryModel({
    this.success,
    this.message,
    this.data,
  });

  factory VisitingConsultantSummaryModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'] is Map<String, dynamic> ? json['data'] : json;
    return VisitingConsultantSummaryModel(
      success: json['success'] as bool? ?? true,
      message: json['message']?.toString(),
      data: rawData != null ? VisitingSummaryData.fromJson(rawData as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}

class VisitingSummaryData {
  int? id;
  int? requestId;
  String? consultantName;
  String? consultationDate;
  String? chiefComplaints;
  String? clinicalFindings;
  String? physicalExamination;
  String? diagnosis;
  String? advice;
  String? prescriptionNotes;
  String? followUpAdvice;
  String? followUpDate;
  List<String>? attachments;

  VisitingSummaryData({
    this.id,
    this.requestId,
    this.consultantName,
    this.consultationDate,
    this.chiefComplaints,
    this.clinicalFindings,
    this.physicalExamination,
    this.diagnosis,
    this.advice,
    this.prescriptionNotes,
    this.followUpAdvice,
    this.followUpDate,
    this.attachments,
  });

  factory VisitingSummaryData.fromJson(Map<String, dynamic> json) {
    List<String>? attachmentList;
    if (json['attachments'] is List) {
      attachmentList = (json['attachments'] as List).map((e) => e.toString()).toList();
    }

    return VisitingSummaryData(
      id: int.tryParse(json['id']?.toString() ?? ''),
      requestId: int.tryParse(json['visiting_consultant_request_id']?.toString() ?? json['request_id']?.toString() ?? ''),
      consultantName: json['consultant_name']?.toString() ?? json['doctor_name']?.toString(),
      consultationDate: json['consultation_date']?.toString() ?? json['date']?.toString(),
      chiefComplaints: json['chief_complaints']?.toString() ?? json['complaints']?.toString(),
      clinicalFindings: json['clinical_findings']?.toString() ?? json['findings']?.toString() ?? json['notes']?.toString(),
      physicalExamination: json['physical_examination']?.toString() ?? json['examination']?.toString(),
      diagnosis: json['diagnosis']?.toString(),
      advice: json['advice']?.toString() ?? json['treatment_plan']?.toString(),
      prescriptionNotes: json['prescription_notes']?.toString() ?? json['prescriptions']?.toString(),
      followUpAdvice: json['follow_up_advice']?.toString(),
      followUpDate: json['follow_up_date']?.toString(),
      attachments: attachmentList ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'request_id': requestId,
    'consultant_name': consultantName,
    'consultation_date': consultationDate,
    'chief_complaints': chiefComplaints,
    'clinical_findings': clinicalFindings,
    'physical_examination': physicalExamination,
    'diagnosis': diagnosis,
    'advice': advice,
    'prescription_notes': prescriptionNotes,
    'follow_up_advice': followUpAdvice,
    'follow_up_date': followUpDate,
    'attachments': attachments,
  };
}
