class DetailSellRequest {
  int? id;
  String? code;
  String? createdDate;
  String? status;
  double? askingPrice;
  int? motorbikeId;
  int? customerId;
  int? showroomId;
  CustomerVoDetailSellRequest? customerVo;
  List<MotorbikeImageDtoDetailSellRequest>? motorbikeImageDto;
  ShowroomDtoDetailSellRequest? showroomDto;
  UserDtoDetailSellRequest? userDto;

  DetailSellRequest(
      {this.id,
      this.code,
      this.createdDate,
      this.status,
      this.askingPrice,
      this.motorbikeId,
      this.customerId,
      this.showroomId,
      this.customerVo,
      this.motorbikeImageDto,
      this.showroomDto,
      this.userDto});

  DetailSellRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    createdDate = json['createdDate'];
    status = json['status'];
    askingPrice = json['askingPrice'];
    motorbikeId = json['motorbikeId'];
    customerId = json['customerId'];
    showroomId = json['showroomId'];
    customerVo = json['customerVo'] != null
        ? new CustomerVoDetailSellRequest.fromJson(json['customerVo'])
        : null;
    if (json['motorbikeImageDto'] != null) {
      motorbikeImageDto = <MotorbikeImageDtoDetailSellRequest>[];
      json['motorbikeImageDto'].forEach((v) {
        motorbikeImageDto!.add(new MotorbikeImageDtoDetailSellRequest.fromJson(v));
      });
    }
    showroomDto = json['showroomDto'] != null
        ? new ShowroomDtoDetailSellRequest.fromJson(json['showroomDto'])
        : null;
    userDto =
        json['userDto'] != null ? new UserDtoDetailSellRequest.fromJson(json['userDto']) : null;
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
    if (this.customerVo != null) {
      data['customerVo'] = this.customerVo!.toJson();
    }
    if (this.motorbikeImageDto != null) {
      data['motorbikeImageDto'] = this.motorbikeImageDto!.map((v) => v.toJson()).toList();
    }
    if (this.showroomDto != null) {
      data['showroomDto'] = this.showroomDto!.toJson();
    }
    if (this.userDto != null) {
      data['userDto'] = this.userDto!.toJson();
    }
    return data;
  }
}

class CustomerVoDetailSellRequest {
  int? id;
  String? fullName;
  String? dob;
  String? address;
  String? avatarUrl;
  bool? isBuy;
  int? userId;
  String? phone;

  CustomerVoDetailSellRequest(
      {this.id,
      this.fullName,
      this.dob,
      this.address,
      this.avatarUrl,
      this.isBuy,
      this.userId,
      this.phone});

  CustomerVoDetailSellRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    dob = json['dob'];
    address = json['address'];
    avatarUrl = json['avatarUrl'];
    isBuy = json['isBuy'];
    userId = json['userId'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['avatarUrl'] = this.avatarUrl;
    data['isBuy'] = this.isBuy;
    data['userId'] = this.userId;
    data['phone'] = this.phone;
    return data;
  }
}

class MotorbikeImageDtoDetailSellRequest {
  int? id;
  String? url;
  String? name;
  bool? isThumbnail;
  int? motorbikeId;

  MotorbikeImageDtoDetailSellRequest(
      {this.id, this.url, this.name, this.isThumbnail, this.motorbikeId});

  MotorbikeImageDtoDetailSellRequest.fromJson(Map<String, dynamic> json) {
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

class ShowroomDtoDetailSellRequest {
  int? id;
  String? name;
  String? address;
  String? province;
  String? email;
  String? phone;

  ShowroomDtoDetailSellRequest(
      {this.id, this.name, this.address, this.province, this.email, this.phone});

  ShowroomDtoDetailSellRequest.fromJson(Map<String, dynamic> json) {
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

class UserDtoDetailSellRequest {
  int? id;
  String? userName;
  String? phone;
  String? email;
  String? password;
  bool? status;
  int? roleId;

  UserDtoDetailSellRequest(
      {this.id, this.userName, this.phone, this.email, this.password, this.status, this.roleId});

  UserDtoDetailSellRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    roleId = json['roleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['status'] = this.status;
    data['roleId'] = this.roleId;
    return data;
  }
}
