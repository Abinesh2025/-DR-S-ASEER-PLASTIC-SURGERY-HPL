// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminDashboardModel _$AdminDashboardModelFromJson(Map<String, dynamic> json) =>
    AdminDashboardModel(
      success: json['success'] as bool?,
      message: json['message'] == null
          ? null
          : AdminDashboardData.fromJson(
              json['message'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AdminDashboardModelToJson(
  AdminDashboardModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message?.toJson(),
};

AdminDashboardData _$AdminDashboardDataFromJson(Map<String, dynamic> json) =>
    AdminDashboardData(
      invoiceAmount: (json['invoiceAmount'] as num?)?.toDouble(),
      billAmount: (json['billAmount'] as num?)?.toDouble(),
      paymentAmount: (json['paymentAmount'] as num?)?.toDouble(),
      advancePaymentAmount: (json['advancePaymentAmount'] as num?)?.toDouble(),
      doctor: (json['doctor'] as num?)?.toInt(),
      patients: (json['patients'] as num?)?.toInt(),
      nurses: (json['nurses'] as num?)?.toInt(),
      availableBeds: (json['availableBeds'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      currency_symbol: json['currency_symbol'] as String?,
      upcomingAppointments: (json['upcomingAppointments'] as List<dynamic>?)
          ?.map((e) => UpcomingAppointment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdminDashboardDataToJson(AdminDashboardData instance) =>
    <String, dynamic>{
      'invoiceAmount': instance.invoiceAmount,
      'billAmount': instance.billAmount,
      'paymentAmount': instance.paymentAmount,
      'advancePaymentAmount': instance.advancePaymentAmount,
      'doctor': instance.doctor,
      'patients': instance.patients,
      'nurses': instance.nurses,
      'availableBeds': instance.availableBeds,
      'currency': instance.currency,
      'currency_symbol': instance.currency_symbol,
      'upcomingAppointments': instance.upcomingAppointments
          ?.map((e) => e.toJson())
          .toList(),
    };

UpcomingAppointment _$UpcomingAppointmentFromJson(Map<String, dynamic> json) =>
    UpcomingAppointment(
      id: (json['id'] as num?)?.toInt(),
      patient_id: (json['patient_id'] as num?)?.toInt(),
      patient_name: json['patient_name'] as String?,
      patine_image: json['patine_image'] as String?,
      appointment_date: json['appointment_date'] as String?,
      appointment_time: json['appointment_time'] as String?,
      doctor_id: (json['doctor_id'] as num?)?.toInt(),
      doctor_name: json['doctor_name'] as String?,
      doctor_department_id: (json['doctor_department_id'] as num?)?.toInt(),
      doctor_department: json['doctor_department'] as String?,
    );

Map<String, dynamic> _$UpcomingAppointmentToJson(
  UpcomingAppointment instance,
) => <String, dynamic>{
  'id': instance.id,
  'patient_id': instance.patient_id,
  'patient_name': instance.patient_name,
  'patine_image': instance.patine_image,
  'appointment_date': instance.appointment_date,
  'appointment_time': instance.appointment_time,
  'doctor_id': instance.doctor_id,
  'doctor_name': instance.doctor_name,
  'doctor_department_id': instance.doctor_department_id,
  'doctor_department': instance.doctor_department,
};
