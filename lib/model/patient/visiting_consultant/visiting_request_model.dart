import 'visiting_consultant_model.dart';
import 'visiting_bill_model.dart';

class VisitingRequestListModel {
  bool? success;
  String? message;
  List<VisitingRequestItem>? data;

  VisitingRequestListModel({
    this.success,
    this.message,
    this.data,
  });

  factory VisitingRequestListModel.fromJson(Map<String, dynamic> json) {
    var rawData = json['data'];
    List<VisitingRequestItem>? list;
    if (rawData is List) {
      list = rawData.map((e) => VisitingRequestItem.fromJson(e as Map<String, dynamic>)).toList();
    } else if (rawData is Map<String, dynamic> && rawData['data'] is List) {
      list = (rawData['data'] as List)
          .map((e) => VisitingRequestItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return VisitingRequestListModel(
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

class VisitingRequestDetailModel {
  bool? success;
  String? message;
  VisitingRequestItem? data;

  VisitingRequestDetailModel({
    this.success,
    this.message,
    this.data,
  });

  factory VisitingRequestDetailModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'] is Map<String, dynamic> ? json['data'] : json;
    return VisitingRequestDetailModel(
      success: json['success'] as bool? ?? true,
      message: json['message']?.toString(),
      data: rawData != null ? VisitingRequestItem.fromJson(rawData as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}

class VisitingRequestItem {
  int? id;
  String? visitType; // "OPD" or "IPD"
  int? visitingConsultantId;
  String? preferredDate; // YYYY-MM-DD
  String? preferredTimeSlot; // e.g. "10:00 AM - 11:00 AM"
  String? assignedDate; // YYYY-MM-DD (Hospital scheduled)
  String? assignedTimeSlot; // e.g. "02:00 PM - 03:00 PM" (Hospital scheduled)
  String? priority; // "Routine", "Urgent", "Critical"
  String? reason;
  String? status; // "Requested", "Assigned", "Confirmed", "Completed", "Cancelled"
  String? cancellationReason;
  String? createdAt;
  String? updatedAt;
  VisitingConsultantData? consultant;
  VisitingBillData? bill;

  VisitingRequestItem({
    this.id,
    this.visitType,
    this.visitingConsultantId,
    this.preferredDate,
    this.preferredTimeSlot,
    this.assignedDate,
    this.assignedTimeSlot,
    this.priority,
    this.reason,
    this.status,
    this.cancellationReason,
    this.createdAt,
    this.updatedAt,
    this.consultant,
    this.bill,
  });

  bool get canBeCancelled =>
      status?.toLowerCase() == 'requested' ||
      status?.toLowerCase() == 'assigned';

  bool get isCompleted => status?.toLowerCase() == 'completed';

  bool get hasAssignedSchedule =>
      (assignedDate != null && assignedDate!.isNotEmpty) ||
      (assignedTimeSlot != null && assignedTimeSlot!.isNotEmpty);

  bool get isAssigned =>
      status?.toLowerCase() == 'assigned' ||
      status?.toLowerCase() == 'confirmed' ||
      status?.toLowerCase() == 'completed' ||
      hasAssignedSchedule;

  String? get displayDate =>
      (assignedDate != null && assignedDate!.isNotEmpty) ? assignedDate : preferredDate;

  String? get displayTimeSlot =>
      (assignedTimeSlot != null && assignedTimeSlot!.isNotEmpty) ? assignedTimeSlot : null;

  factory VisitingRequestItem.fromJson(Map<String, dynamic> json) {
    VisitingConsultantData? consultantObj;
    if (json['consultant'] is Map<String, dynamic>) {
      consultantObj = VisitingConsultantData.fromJson(json['consultant'] as Map<String, dynamic>);
    } else if (json['visiting_consultant'] is Map<String, dynamic>) {
      consultantObj = VisitingConsultantData.fromJson(json['visiting_consultant'] as Map<String, dynamic>);
    }

    VisitingBillData? billObj;
    if (json['bill'] is Map<String, dynamic>) {
      billObj = VisitingBillData.fromJson(json['bill'] as Map<String, dynamic>);
    }

    final assignedDateVal = json['assigned_date']?.toString() ??
        json['scheduled_date']?.toString() ??
        json['visit_date']?.toString() ??
        json['appointment_date']?.toString() ??
        json['confirmed_date']?.toString() ??
        json['consultation_date']?.toString();

    final assignedTimeVal = json['assigned_time_slot']?.toString() ??
        json['assigned_time']?.toString() ??
        json['scheduled_time_slot']?.toString() ??
        json['scheduled_time']?.toString() ??
        json['visit_time']?.toString() ??
        json['confirmed_time']?.toString() ??
        json['appointment_time']?.toString() ??
        json['time_slot']?.toString();

    return VisitingRequestItem(
      id: int.tryParse(json['id']?.toString() ?? ''),
      visitType: json['visit_type']?.toString() ?? "OPD",
      visitingConsultantId: int.tryParse(json['visiting_consultant_id']?.toString() ?? ''),
      preferredDate: json['preferred_date']?.toString(),
      preferredTimeSlot: json['preferred_time_slot']?.toString(),
      assignedDate: assignedDateVal,
      assignedTimeSlot: assignedTimeVal,
      priority: json['priority']?.toString() ?? "Routine",
      reason: json['reason']?.toString(),
      status: json['status']?.toString() ?? "Requested",
      cancellationReason: json['cancellation_reason']?.toString() ?? json['cancel_reason']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      consultant: consultantObj,
      bill: billObj,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'visit_type': visitType,
    'visiting_consultant_id': visitingConsultantId,
    'preferred_date': preferredDate,
    'preferred_time_slot': preferredTimeSlot,
    'assigned_date': assignedDate,
    'assigned_time_slot': assignedTimeSlot,
    'priority': priority,
    'reason': reason,
    'status': status,
    'cancellation_reason': cancellationReason,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'consultant': consultant?.toJson(),
    'bill': bill?.toJson(),
  };
}

/// Request Payload for creating a new visit request
class CreateVisitingRequestPayload {
  final String visitType; // "OPD" or "IPD" (Required)
  final int? visitingConsultantId; // Optional: preferred consultant ID
  final String? preferredDate; // Optional: YYYY-MM-DD
  final String? preferredTimeSlot; // Optional
  final String priority; // "Routine", "Urgent", "Critical" (Default: "Routine")
  final String? reason; // Optional

  CreateVisitingRequestPayload({
    required this.visitType,
    this.visitingConsultantId,
    this.preferredDate,
    this.preferredTimeSlot,
    this.priority = "Routine",
    this.reason,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'visit_type': visitType,
      'priority': priority,
    };
    if (visitingConsultantId != null) {
      data['visiting_consultant_id'] = visitingConsultantId;
    }
    if (preferredDate != null && preferredDate!.isNotEmpty) {
      data['preferred_date'] = preferredDate;
    }
    if (preferredTimeSlot != null && preferredTimeSlot!.isNotEmpty) {
      data['preferred_time_slot'] = preferredTimeSlot;
    }
    if (reason != null && reason!.isNotEmpty) {
      data['reason'] = reason;
    }
    return data;
  }
}
