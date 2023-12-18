// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_customerdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerDto _$CustomerDtoFromJson(Map<String, dynamic> json) => CustomerDto(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      dob: json['dob'] as String,
      address: json['address'] as String,
      userId: json['userId'] as int,
      avatarUrl: json['avatarUrl'] as String,
    );

Map<String, dynamic> _$CustomerDtoToJson(CustomerDto instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'dob': instance.dob,
      'address': instance.address,
      'userId': instance.userId,
      'avatarUrl': instance.avatarUrl,
    };
