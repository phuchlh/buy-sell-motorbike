import 'showroom_image_dtos.dart';

class Showroom {
  int? id;
  String? name;
  String? address;
  String? province;
  String? email;
  String? phone;
  List<ShowroomImageDtos>? showroomImageDtos;

  Showroom({
    this.id,
    this.name,
    this.address,
    this.province,
    this.email,
    this.phone,
    this.showroomImageDtos,
  });

  Showroom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    province = json['province'];
    email = json['email'];
    phone = json['phone'];
    if (json['showroomImageDtos'] != null && (json['showroomImageDtos'] as List).isNotEmpty) {
      showroomImageDtos = <ShowroomImageDtos>[];
      json['showroomImageDtos'].forEach((v) {
        showroomImageDtos!.add(new ShowroomImageDtos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['province'] = this.province;
    data['email'] = this.email;
    data['phone'] = this.phone;
    if (this.showroomImageDtos != null) {
      data['showroomImageDtos'] = this.showroomImageDtos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
