class DetailSellRequest {
  int? id;
  String? code;
  String? createdDate;
  String? approvedDate;
  String? status;
  double? askingPrice;
  int? motorbikeId;
  int? customerId;
  int? showroomId;
  CustomerVoDetailSellRequest? customerVo;
  List<MotorbikeImageDtoDetailSellRequest>? motorbikeImageDto;
  ShowroomDtoDetailSellRequest? showroomDto;
  UserDtoDetailSellRequest? userDto;
  PostDtoDetailSellRequest? postDto;

  DetailSellRequest({
    this.id,
    this.code,
    this.createdDate,
    this.approvedDate,
    this.status,
    this.askingPrice,
    this.motorbikeId,
    this.customerId,
    this.showroomId,
    this.customerVo,
    this.motorbikeImageDto,
    this.showroomDto,
    this.userDto,
    this.postDto,
  });

  DetailSellRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    createdDate = json['createdDate'];
    approvedDate = json['approvedDate'];
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

    postDto =
        json['postDto'] != null ? new PostDtoDetailSellRequest.fromJson(json['userDto']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['createdDate'] = this.createdDate;
    data['approvedDate'] = this.approvedDate;
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
    if (this.postDto != null) {
      data['postDto'] = this.postDto!.toJson();
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

class PostDtoDetailSellRequest {
  int? id;
  String? createdDate;
  String? expiredDate;
  int? price;
  String? title;
  String? content;
  bool? status;
  int? motorbikeId;
  int? showroomId;
  int? sellRequestId;

  PostDtoDetailSellRequest(
      {this.id,
      this.createdDate,
      this.expiredDate,
      this.price,
      this.title,
      this.content,
      this.status,
      this.motorbikeId,
      this.showroomId,
      this.sellRequestId});

  PostDtoDetailSellRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['createdDate'];
    expiredDate = json['expiredDate'];
    price = json['price'];
    title = json['title'];
    content = json['content'];
    status = json['status'];
    motorbikeId = json['motorbikeId'];
    showroomId = json['showroomId'];
    sellRequestId = json['sellRequestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdDate'] = this.createdDate;
    data['expiredDate'] = this.expiredDate;
    data['price'] = this.price;
    data['title'] = this.title;
    data['content'] = this.content;
    data['status'] = this.status;
    data['motorbikeId'] = this.motorbikeId;
    data['showroomId'] = this.showroomId;
    data['sellRequestId'] = this.sellRequestId;
    return data;
  }
}
