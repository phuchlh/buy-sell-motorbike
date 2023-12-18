// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_showroomemployeedto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeShowroomDto _$EmployeeShowroomDtoFromJson(Map<String, dynamic> json) =>
    EmployeeShowroomDto(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      dob: json['dob'] as String,
      address: json['address'] as String,
      userId: json['userId'] as int,
      showroomId: json['showroomId'] as int,
    );

Map<String, dynamic> _$EmployeeShowroomDtoToJson(
        EmployeeShowroomDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'dob': instance.dob,
      'address': instance.address,
      'userId': instance.userId,
      'showroomId': instance.showroomId,
    };
