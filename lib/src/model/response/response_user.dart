import 'package:json_annotation/json_annotation.dart';
import 'response_customerdto.dart';

part 'response_user.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "userName")
  final String username;

  @JsonKey(name: "phone")
  final String phone;

  final String email;
  final String password;
  final bool status;
  final int roleId;
  final dynamic roleDto;
  final CustomerDto customerDto;
  final dynamic employeeShowroomDto;

  UserResponse(
      {required this.id,
      required this.username,
      required this.phone,
      required this.email,
      required this.password,
      required this.status,
      required this.roleId,
      required this.roleDto,
      required this.customerDto,
      required this.employeeShowroomDto});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
