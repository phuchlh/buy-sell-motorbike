class MotorbikeVoreq {
  MotorbikeVo? motorbikeVo;

  MotorbikeVoreq({this.motorbikeVo});

  MotorbikeVoreq.fromJson(Map<String, dynamic> json) {
    motorbikeVo =
        json['motorbikeVo'] != null ? new MotorbikeVo.fromJson(json['motorbikeVo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.motorbikeVo != null) {
      data['motorbikeVo'] = this.motorbikeVo!.toJson();
    }
    return data;
  }
}

class MotorbikeVo {
  String? name;
  String? licensePlate;
  double? engineSize;
  String? description;
  String? condition;
  double? odo;
  String? yearOfRegistration;
  String? motoType;
  int? motoBrandId;
  int? customerId;
  int? showroomId;
  List<MotorbikeImageDtos>? motorbikeImageDtos;

  MotorbikeVo(
      {this.name,
      this.licensePlate,
      this.engineSize,
      this.description,
      this.condition,
      this.odo,
      this.yearOfRegistration,
      this.motoType,
      this.motoBrandId,
      this.customerId,
      this.showroomId,
      this.motorbikeImageDtos});

  MotorbikeVo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    licensePlate = json['licensePlate'];
    engineSize = json['engineSize'];
    description = json['description'];
    condition = json['condition'];
    odo = json['odo'];
    yearOfRegistration = json['yearOfRegistration'];
    motoType = json['motoType'];
    motoBrandId = json['motoBrandId'];
    customerId = json['customerId'];
    showroomId = json['showroomId'];
    if (json['motorbikeImageDtos'] != null) {
      motorbikeImageDtos = <MotorbikeImageDtos>[];
      json['motorbikeImageDtos'].forEach((v) {
        motorbikeImageDtos!.add(new MotorbikeImageDtos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['licensePlate'] = this.licensePlate;
    data['engineSize'] = this.engineSize;
    data['description'] = this.description;
    data['condition'] = this.condition;
    data['odo'] = this.odo;
    data['yearOfRegistration'] = this.yearOfRegistration;
    data['motoType'] = this.motoType;
    data['motoBrandId'] = this.motoBrandId;
    data['customerId'] = this.customerId;
    data['showroomId'] = this.showroomId;
    if (this.motorbikeImageDtos != null) {
      data['motorbikeImageDtos'] = this.motorbikeImageDtos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MotorbikeImageDtos {
  String? url;
  String? name;
  bool? isThumbnail;

  MotorbikeImageDtos({this.url, this.name, this.isThumbnail});

  MotorbikeImageDtos.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    isThumbnail = json['isThumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['isThumbnail'] = this.isThumbnail;
    return data;
  }
}
