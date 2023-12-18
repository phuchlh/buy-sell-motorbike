class ShowroomDTO {
  int? id;
  String? name;
  String? address;
  String? province;
  String? email;
  String? phone;

  ShowroomDTO({this.id, this.name, this.address, this.province, this.email, this.phone});

  ShowroomDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    province = json['province'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['province'] = this.province;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
