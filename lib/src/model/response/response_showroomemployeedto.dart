import 'package:json_annotation/json_annotation.dart';

part 'response_showroomemployeedto.g.dart';

@JsonSerializable()
class EmployeeShowroomDto {
  final int id;
  final String fullName;
  final String dob;
  final String address;
  final int userId;
  final int showroomId;

  EmployeeShowroomDto(
      {required this.id,
      required this.fullName,
      required this.dob,
      required this.address,
      required this.userId,
      required this.showroomId});

  factory EmployeeShowroomDto.fromJson(Map<String, dynamic> json) => _$EmployeeShowroomDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeShowroomDtoToJson(this);
}
