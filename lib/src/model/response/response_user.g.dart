// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      id: json['id'] as int,
      username: json['userName'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      status: json['status'] as bool,
      roleId: json['roleId'] as int,
      roleDto: json['roleDto'],
      customerDto: json['customerDto'],
      employeeShowroomDto: json['employeeShowroomDto'],
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.username,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
      'status': instance.status,
      'roleId': instance.roleId,
      'roleDto': instance.roleDto,
      'customerDto': instance.customerDto,
      'employeeShowroomDto': instance.employeeShowroomDto,
    };
