// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'today_appointment_model.dart';
//
// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************
//
// TodayAppointmentResponseModel _$TodayAppointmentResponseModelFromJson(
//         Map<String, dynamic> json) =>
//     TodayAppointmentResponseModel(
//       success: json['success'] as bool?,
//       message: json['message'] as String?,
//       data: json['data'] == null
//           ? null
//           : TodayAppointmentData.fromJson(json['data'] as Map<String, dynamic>),
//     );
//
// Map<String, dynamic> _$TodayAppointmentResponseModelToJson(
//         TodayAppointmentResponseModel instance) =>
//     <String, dynamic>{
//       'success': instance.success,
//       'message': instance.message,
//       'data': instance.data?.toJson(),
//     };
//
// TodayAppointmentData _$TodayAppointmentDataFromJson(
//         Map<String, dynamic> json) =>json
//     TodayAppointmentData(
//       appointment: json['appointment'] == null
//           ? null
//           : AppointmentInfo.fromJson(
//               json['appointment'] as Map<String, dynamic>),
//       type: json['type'] as String?,
//       sessionType: json['session_type'] as String?,
//       tokens: json['tokens'] == null
//           ? null
//           : TodayTokenInfo.fromJson(json['tokens'] as Map<String, dynamic>),
//     );
//
// Map<String, dynamic> _$TodayAppointmentDataToJson(
//         TodayAppointmentData instance) =>
//     <String, dynamic>{
//       'appointment': instance.appointment?.toJson(),
//       'type': instance.type,
//       'session_type': instance.sessionType,
//       'tokens': instance.tokens?.toJson(),
//     };
//
// AppointmentInfo _$AppointmentInfoFromJson(Map<String, dynamic> json) =>
//     AppointmentInfo(
//       id: (json['id'] as num?)?.toInt(),
//       originalId: (json['original_id'] as num?)?.toInt(),
//       patientId: (json['patient_id'] as num?)?.toInt(),
//       doctorId: (json['doctor_id'] as num?)?.toInt(),
//       departmentId: json['department_id'] as String?,
//       appointmentType: (json['appointment_type'] as num?)?.toInt(),
//       opdDate: json['opd_date'] as String?,
//       tokenNumber: (json['token_number'] as num?)?.toInt(),
//       tokenLabel: json['token_label'] as String?,
//       patientName: json['patient_name'] as String?,
//       relation: json['relation'] as String?,
//       bookedBy: (json['booked_by'] as num?)?.toInt(),
//       problem: json['problem'] as String?,
//       isCompleted: (json['is_completed'] as num?)?.toInt(),
//       paymentStatus: (json['payment_status'] as num?)?.toInt(),
//       paymentType: json['payment_type'] as String?,
//       tenantId: json['tenant_id'] as String?,
//       createdAt: json['created_at'] as String?,
//       updatedAt: json['updated_at'] as String?,
//       sourceTable: json['source_table'] as String?,
//     );
//
// Map<String, dynamic> _$AppointmentInfoToJson(AppointmentInfo instance) =>
//     <String, dynamic>{
//       'id': instance.id,
//       'original_id': instance.originalId,
//       'patient_id': instance.patientId,
//       'doctor_id': instance.doctorId,
//       'department_id': instance.departmentId,
//       'appointment_type': instance.appointmentType,
//       'opd_date': instance.opdDate,
//       'token_number': instance.tokenNumber,
//       'token_label': instance.tokenLabel,
//       'patient_name': instance.patientName,
//       'relation': instance.relation,
//       'booked_by': instance.bookedBy,
//       'problem': instance.problem,
//       'is_completed': instance.isCompleted,
//       'payment_status': instance.paymentStatus,
//       'payment_type': instance.paymentType,
//       'tenant_id': instance.tenantId,
//       'created_at': instance.createdAt,
//       'updated_at': instance.updatedAt,
//       'source_table': instance.sourceTable,
//     };
//
// TodayTokenInfo _$TodayTokenInfoFromJson(Map<String, dynamic> json) =>
//     TodayTokenInfo(
//       bookingSlotArr: json['bookingSlotArr'] as List<dynamic>?,
//       doctorState: json['doctor_state'] == null
//           ? null
//           : DoctorState.fromJson(json['doctor_state'] as Map<String, dynamic>),
//     );
//
// Map<String, dynamic> _$TodayTokenInfoToJson(TodayTokenInfo instance) =>
//     <String, dynamic>{
//       'bookingSlotArr': instance.bookingSlotArr,
//       'doctor_state': instance.doctorState?.toJson(),
//     };
//
// DoctorState _$DoctorStateFromJson(Map<String, dynamic> json) => DoctorState(
//       status: json['status'] as String?,
//       reason: json['reason'] as String?,
//     );
//
// Map<String, dynamic> _$DoctorStateToJson(DoctorState instance) =>
//     <String, dynamic>{
//       'status': instance.status,
//       'reason': instance.reason,
//     };
