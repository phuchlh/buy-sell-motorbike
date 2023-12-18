import 'package:json_annotation/json_annotation.dart';

part 'response_roledto.g.dart';

@JsonSerializable()
class roleDto {
  final int id;
  final String name;

  roleDto({required this.id, required this.name});

  factory roleDto.fromJson(Map<String, dynamic> json) => _$roleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$roleDtoToJson(this);
}
