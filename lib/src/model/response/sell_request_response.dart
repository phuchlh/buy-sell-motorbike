import 'customer_response_replaced.dart';
import 'motorbike_dto_data_response.dart';
import 'motorbike_image_dto_response.dart';

class SellRequestHistoryDTO {
  int? id;
  String? code;
  String? createdDate;
  String? status;
  double? askingPrice;
  int? motorbikeId;
  int? customerId;
  int? showroomId;
  CustomerDtoReplaced? customerDto;
  MotorbikeDTOResponse? motorbikeDto;
  List<MotorbikeDTOsResponse>? motorbikeImageDto;

  SellRequestHistoryDTO(
      {this.id,
      this.code,
      this.createdDate,
      this.status,
      this.askingPrice,
      this.motorbikeId,
      this.customerId,
      this.showroomId,
      this.customerDto,
      this.motorbikeDto,
      this.motorbikeImageDto});

  SellRequestHistoryDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    createdDate = json['createdDate'];
    status = json['status'];
    askingPrice = json['askingPrice'];
    motorbikeId = json['motorbikeId'];
    customerId = json['customerId'];
    showroomId = json['showroomId'];
    customerDto = json['customerDto'] != null
        ? new CustomerDtoReplaced.fromJson(json['customerDto'])
        : null;
    motorbikeDto = json['motorbikeDto'] != null
        ? new MotorbikeDTOResponse.fromJson(json['motorbikeDto'])
        : null;
    if (json['motorbikeImageDto'] != null) {
      motorbikeImageDto = <MotorbikeDTOsResponse>[];
      json['motorbikeImageDto'].forEach((v) {
        motorbikeImageDto!.add(new MotorbikeDTOsResponse.fromJson(v));
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
    if (this.customerDto != null) {
      data['customerDto'] = this.customerDto!.toJson();
    }
    if (this.motorbikeDto != null) {
      data['motorbikeDto'] = this.motorbikeDto!.toJson();
    }
    if (this.motorbikeImageDto != null) {
      data['motorbikeImageDto'] =
          this.motorbikeImageDto!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
