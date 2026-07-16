import 'package:json_annotation/json_annotation.dart';

part 'slot_booking_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SlotBookingModel {
  bool? success;
  SlotBookingData? data;
  String? message;

  SlotBookingModel({
    this.success,
    this.data,
    this.message,
  });

  factory SlotBookingModel.fromJson(Map<String, dynamic> json) =>
      _$SlotBookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$SlotBookingModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SlotBookingData {
  List<dynamic>? bookingSlotArr;

  String? schedule_type;
  int? appointment_charge;
  int? max_tokens_per_day;
  int? booked_tokens;
  int? next_token_number;

  bool? use_slots;

  int? morning_tokens;
  int? afternoon_tokens;
  int? night_tokens;

  bool? is_holiday;

  bool? is_half_day_holiday;
  String? holiday_message;

  List<dynamic>? holiday_sessions;
  List<dynamic>? booked_times;

  SlotBookingData({
    this.bookingSlotArr,
    this.schedule_type,
    this.appointment_charge,
    this.max_tokens_per_day,
    this.booked_tokens,
    this.next_token_number,
    this.use_slots,
    this.morning_tokens,
    this.afternoon_tokens,
    this.night_tokens,
    this.is_holiday,
    this.is_half_day_holiday,
    this.holiday_message,
    this.holiday_sessions,
    this.booked_times,
  });

  factory SlotBookingData.fromJson(Map<String, dynamic> json) =>
      _$SlotBookingDataFromJson(json);

  Map<String, dynamic> toJson() => _$SlotBookingDataToJson(this);
}

class BookingToken {
  int? token;
  bool? isBooked;
  bool? disabled;
  String? status;
  String? category;
  String? label;

  BookingToken({
    this.token,
    this.isBooked,
    this.disabled,
    this.status,
    this.category,
    this.label,
  });

  factory BookingToken.fromJson(Map<String, dynamic> json) {
    return BookingToken(
      token: json['token'] as int?,
      isBooked: json['isBooked'] == true || json['isBooked'] == 1,
      disabled: json['disabled'] == true || json['disabled'] == 1,
      status: json['status']?.toString(),
      category: json['category']?.toString(),
      label: json['label']?.toString(),
    );
  }
}