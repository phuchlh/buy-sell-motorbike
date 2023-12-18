class MotorbikeDtos {
  List<MotorbikeImageDto>? motorbikeImageDto;

  MotorbikeDtos({this.motorbikeImageDto});

  MotorbikeDtos.fromJson(Map<String, dynamic> json) {
    if (json['motorbikeImageDtos'] != null) {
      motorbikeImageDto = <MotorbikeImageDto>[];
      json['motorbikeImageDtos'].forEach((v) {
        motorbikeImageDto!.add(new MotorbikeImageDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.motorbikeImageDto != null) {
      data['motorbikeImageDtos'] =
          this.motorbikeImageDto!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MotorbikeImageDto {
  int? id;
  String? url;
  String? name;
  bool? isThumbnail;
  int? motorbikeId;

  MotorbikeImageDto(
      {this.id, this.url, this.name, this.isThumbnail, this.motorbikeId});

  MotorbikeImageDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    isThumbnail = json['isThumbnail'];
    motorbikeId = json['motorbikeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    data['isThumbnail'] = this.isThumbnail;
    data['motorbikeId'] = this.motorbikeId;
    return data;
  }
}
