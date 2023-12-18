import 'package:json_annotation/json_annotation.dart';

part 'response_customerdto.g.dart';

@JsonSerializable()
class CustomerDto {
  final int id;
  final String fullName;
  final String dob;
  final String address;
  final int userId;
  final String avatarUrl;

  CustomerDto(
      {required this.id,
      required this.fullName,
      required this.dob,
      required this.address,
      required this.avatarUrl,
      required this.userId});

  factory CustomerDto.fromJson(Map<String, dynamic> json) => _$CustomerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDtoToJson(this);
}
