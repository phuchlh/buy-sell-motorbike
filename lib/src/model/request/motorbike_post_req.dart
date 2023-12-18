class MotorbikeRequestPost {
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

  MotorbikeRequestPost(
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
      this.showroomId});

  MotorbikeRequestPost.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
