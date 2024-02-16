import '../motorbikedtos.dart';
import 'customer_response_replaced.dart';
import 'motorbike_dto_buy_history.dart';
import 'post_dto_buy_request.dart';

class BuyRequestHistoryDTO {
  int? id;
  String? createdDate;
  String? status;
  int? customerId;
  int? showroomId;
  int? motorbikeId;
  int? postId;
  CustomerDtoReplaced? customerVo;
  MotorbikeDToBuyRequest? motorbikeDto;
  List<MotorbikeImageDto>? motorbikeImageDto;
  PostDTOBuyRequest? postDto;

  BuyRequestHistoryDTO(
      {this.id,
      this.createdDate,
      this.status,
      this.customerId,
      this.showroomId,
      this.motorbikeId,
      this.postId,
      this.customerVo,
      this.motorbikeDto,
      this.motorbikeImageDto,
      this.postDto});

  BuyRequestHistoryDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['createdDate'];
    status = json['status'];
    customerId = json['customerId'];
    showroomId = json['showroomId'];
    motorbikeId = json['motorbikeId'];
    postId = json['postId'];
    customerVo = json['customerVo'] != null
        ? new CustomerDtoReplaced.fromJson(json['customerVo'])
        : null;
    motorbikeDto = json['motorbikeDto'] != null
        ? new MotorbikeDToBuyRequest.fromJson(json['motorbikeDto'])
        : null;
    if (json['motorbikeImageDto'] != null) {
      motorbikeImageDto = <MotorbikeImageDto>[];
      json['motorbikeImageDto'].forEach((v) {
        motorbikeImageDto!.add(new MotorbikeImageDto.fromJson(v));
      });
    }
    postDto = json['postDto'] != null
        ? new PostDTOBuyRequest.fromJson(json['postDto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdDate'] = this.createdDate;
    data['status'] = this.status;
    data['customerId'] = this.customerId;
    data['showroomId'] = this.showroomId;
    data['motorbikeId'] = this.motorbikeId;
    data['postId'] = this.postId;
    if (this.customerVo != null) {
      data['customerVo'] = this.customerVo!.toJson();
    }
    if (this.motorbikeDto != null) {
      data['motorbikeDto'] = this.motorbikeDto!.toJson();
    }
    if (this.motorbikeImageDto != null) {
      data['motorbikeImageDto'] =
          this.motorbikeImageDto!.map((v) => v.toJson()).toList();
    }
    if (this.postDto != null) {
      data['postDto'] = this.postDto!.toJson();
    }
    return data;
  }
}
