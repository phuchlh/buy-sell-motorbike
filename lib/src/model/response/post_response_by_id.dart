import 'motorbike_dto_data_response.dart';
import 'motorbike_image_dto_response.dart';
import 'sell_request_dto_response.dart';
import 'showroomdto_response.dart';

class PostById {
  int? id;
  String? createdDate;
  String? expiredDate;
  double? price;
  String? title;
  String? content;
  int? motorbikeId;
  int? showroomId;
  int? sellRequestId;
  MotorbikeDTOResponse? motorbikeDto;
  ShowroomDTO? showroomDto;
  SellRequestDTO? sellRequestDto;
  List<MotorbikeDTOsResponse>? motorbikeImageDtos;

  PostById(
      {this.id,
      this.createdDate,
      this.expiredDate,
      this.price,
      this.title,
      this.content,
      this.motorbikeId,
      this.showroomId,
      this.sellRequestId,
      this.motorbikeDto,
      this.showroomDto,
      this.sellRequestDto,
      this.motorbikeImageDtos});

  PostById.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['createdDate'];
    expiredDate = json['expiredDate'];
    price = json['price'];
    title = json['title'];
    content = json['content'];
    motorbikeId = json['motorbikeId'];
    showroomId = json['showroomId'];
    sellRequestId = json['sellRequestId'];
    motorbikeDto = json['motorbikeDto'] != null
        ? new MotorbikeDTOResponse.fromJson(json['motorbikeDto'])
        : null;
    showroomDto = json['showroomDto'] != null
        ? new ShowroomDTO.fromJson(json['showroomDto'])
        : null;
    sellRequestDto = json['sellRequestDto'] != null
        ? new SellRequestDTO.fromJson(json['sellRequestDto'])
        : null;
    if (json['motorbikeImageDtos'] != null) {
      motorbikeImageDtos = <MotorbikeDTOsResponse>[];
      json['motorbikeImageDtos'].forEach((v) {
        motorbikeImageDtos!.add(new MotorbikeDTOsResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdDate'] = this.createdDate;
    data['expiredDate'] = this.expiredDate;
    data['price'] = this.price;
    data['title'] = this.title;
    data['content'] = this.content;
    data['motorbikeId'] = this.motorbikeId;
    data['showroomId'] = this.showroomId;
    data['sellRequestId'] = this.sellRequestId;
    if (this.motorbikeDto != null) {
      data['motorbikeDto'] = this.motorbikeDto!.toJson();
    }
    if (this.showroomDto != null) {
      data['showroomDto'] = this.showroomDto!.toJson();
    }
    if (this.sellRequestDto != null) {
      data['sellRequestDto'] = this.sellRequestDto!.toJson();
    }
    if (this.motorbikeImageDtos != null) {
      data['motorbikeImageDtos'] =
          this.motorbikeImageDtos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
