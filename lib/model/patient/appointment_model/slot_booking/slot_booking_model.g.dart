// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlotBookingModel _$SlotBookingModelFromJson(Map<String, dynamic> json) =>
    SlotBookingModel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : SlotBookingData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SlotBookingModelToJson(SlotBookingModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
      'message': instance.message,
    };

SlotBookingData _$SlotBookingDataFromJson(Map<String, dynamic> json) =>
    SlotBookingData(
      bookingSlotArr: json['bookingSlotArr'] as List<dynamic>?,
      schedule_type: json['schedule_type'] as String?,
      appointment_charge: (json['appointment_charge'] as num?)?.toInt(),
      max_tokens_per_day: (json['max_tokens_per_day'] as num?)?.toInt(),
      booked_tokens: (json['booked_tokens'] as num?)?.toInt(),
      next_token_number: (json['next_token_number'] as num?)?.toInt(),
      use_slots: json['use_slots'] as bool?,
      morning_tokens: (json['morning_tokens'] as num?)?.toInt(),
      afternoon_tokens: (json['afternoon_tokens'] as num?)?.toInt(),
      night_tokens: (json['night_tokens'] as num?)?.toInt(),
      is_holiday: json['is_holiday'] as bool?,
      is_half_day_holiday: json['is_half_day_holiday'] as bool?,
      holiday_message: json['holiday_message'] as String?,
      holiday_sessions: json['holiday_sessions'] as List<dynamic>?,
      booked_times: json['booked_times'] as List<dynamic>?,
    );

Map<String, dynamic> _$SlotBookingDataToJson(SlotBookingData instance) =>
    <String, dynamic>{
      'bookingSlotArr': instance.bookingSlotArr,
      'schedule_type': instance.schedule_type,
      'appointment_charge': instance.appointment_charge,
      'max_tokens_per_day': instance.max_tokens_per_day,
      'booked_tokens': instance.booked_tokens,
      'next_token_number': instance.next_token_number,
      'use_slots': instance.use_slots,
      'morning_tokens': instance.morning_tokens,
      'afternoon_tokens': instance.afternoon_tokens,
      'night_tokens': instance.night_tokens,
      'is_holiday': instance.is_holiday,
      'is_half_day_holiday': instance.is_half_day_holiday,
      'holiday_message': instance.holiday_message,
      'holiday_sessions': instance.holiday_sessions,
      'booked_times': instance.booked_times,
    };
