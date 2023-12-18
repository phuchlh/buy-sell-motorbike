import 'package:buy_sell_motorbike/src/model/motorbikedtos.dart';

class SellRequestDTO {
  int? id;
  String? code;
  String? createdDate;
  String? status;
  double? askingPrice;
  int? motorbikeId;
  int? customerId;
  int? showroomId;
  List<MotorbikeImageDto>? motorbikeImageDto;

  SellRequestDTO(
      {this.id,
      this.code,
      this.createdDate,
      this.status,
      this.askingPrice,
      this.motorbikeId,
      this.customerId,
      this.showroomId,
      this.motorbikeImageDto});

  SellRequestDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    createdDate = json['createdDate'];
    status = json['status'];
    askingPrice = json['askingPrice'];
    motorbikeId = json['motorbikeId'];
    customerId = json['customerId'];
    showroomId = json['showroomId'];
    if (json['motorbikeImageDto'] != null) {
      motorbikeImageDto = <MotorbikeImageDto>[];
      json['motorbikeImageDto'].forEach((v) {
        motorbikeImageDto!.add(new MotorbikeImageDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['createdDate'] = this.createdDate;
    data['status'] = this.status;
    data['askingPrice'] = this.askingPrice;
    data['motorbikeId'] = this.motorbikeId;
    data['customerId'] = this.customerId;
    data['showroomId'] = this.showroomId;
    if (this.motorbikeImageDto != null) {
      data['motorbikeImageDto'] = this.motorbikeImageDto!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
