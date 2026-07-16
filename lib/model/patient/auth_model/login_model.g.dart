// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
  success: json['success'] as bool?,
  data: json['data'] == null
      ? null
      : LoginData.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.toJson(),
      'message': instance.message,
    };

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
  token: json['token'] as String?,
  role: json['role'] as String?,
  user: json['user'] == null
      ? null
      : UserData.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
  'token': instance.token,
  'role': instance.role,
  'user': instance.user?.toJson(),
};

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
  id: (json['id'] as num?)?.toInt(),
  first_name: json['first_name'] as String?,
  last_name: json['last_name'] as String?,
  email: json['email'] as String?,
  phone_number: json['phone_number'] as String?,
  image_url: json['image_url'] as String?,
);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.first_name,
  'last_name': instance.last_name,
  'email': instance.email,
  'phone_number': instance.phone_number,
  'image_url': instance.image_url,
};
