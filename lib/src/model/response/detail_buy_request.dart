class DetailBuyRequest {
  int? id;
  String? createdDate;
  String? status;
  int? customerId;
  int? showroomId;
  int? motorbikeId;
  int? postId;
  CustomerVoDetailBuyRequest? customerVo;
  MotorbikeDtoDetailBuyRequest? motorbikeDto;
  List<MotorbikeImageDtoDetailBuyRequest>? motorbikeImageDto;
  ShowroomDtoDetailBuyRequest? showroomDto;
  PostDtoDetailBuyRequest? postDto;

  DetailBuyRequest(
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
      this.showroomDto,
      this.postDto});

  DetailBuyRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['createdDate'];
    status = json['status'];
    customerId = json['customerId'];
    showroomId = json['showroomId'];
    motorbikeId = json['motorbikeId'];
    postId = json['postId'];
    customerVo = json['customerVo'] != null
        ? new CustomerVoDetailBuyRequest.fromJson(json['customerVo'])
        : null;
    motorbikeDto = json['motorbikeDto'] != null
        ? new MotorbikeDtoDetailBuyRequest.fromJson(json['motorbikeDto'])
        : null;
    if (json['motorbikeImageDto'] != null) {
      motorbikeImageDto = <MotorbikeImageDtoDetailBuyRequest>[];
      json['motorbikeImageDto'].forEach((v) {
        motorbikeImageDto!.add(new MotorbikeImageDtoDetailBuyRequest.fromJson(v));
      });
    }
    showroomDto = json['showroomDto'] != null
        ? new ShowroomDtoDetailBuyRequest.fromJson(json['showroomDto'])
        : null;
    postDto =
        json['postDto'] != null ? new PostDtoDetailBuyRequest.fromJson(json['postDto']) : null;
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
      data['motorbikeImageDto'] = this.motorbikeImageDto!.map((v) => v.toJson()).toList();
    }
    if (this.showroomDto != null) {
      data['showroomDto'] = this.showroomDto!.toJson();
    }
    if (this.postDto != null) {
      data['postDto'] = this.postDto!.toJson();
    }
    return data;
  }
}

class CustomerVoDetailBuyRequest {
  int? id;
  String? fullName;
  String? dob;
  String? address;
  String? avatarUrl;
  bool? isBuy;
  int? userId;
  String? phone;

  CustomerVoDetailBuyRequest(
      {this.id,
      this.fullName,
      this.dob,
      this.address,
      this.avatarUrl,
      this.isBuy,
      this.userId,
      this.phone});

  CustomerVoDetailBuyRequest.fromJson(Map<String, dynamic> json) {
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

class MotorbikeDtoDetailBuyRequest {
  int? id;
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

  MotorbikeDtoDetailBuyRequest(
      {this.id,
      this.name,
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

  MotorbikeDtoDetailBuyRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['id'] = this.id;
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

class MotorbikeImageDtoDetailBuyRequest {
  int? id;
  String? url;
  String? name;
  bool? isThumbnail;
  int? motorbikeId;

  MotorbikeImageDtoDetailBuyRequest(
      {this.id, this.url, this.name, this.isThumbnail, this.motorbikeId});

  MotorbikeImageDtoDetailBuyRequest.fromJson(Map<String, dynamic> json) {
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

class ShowroomDtoDetailBuyRequest {
  int? id;
  String? name;
  String? address;
  String? province;
  String? email;
  String? phone;

  ShowroomDtoDetailBuyRequest(
      {this.id, this.name, this.address, this.province, this.email, this.phone});

  ShowroomDtoDetailBuyRequest.fromJson(Map<String, dynamic> json) {
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

class PostDtoDetailBuyRequest {
  int? id;
  String? createdDate;
  String? expiredDate;
  String? postedBy;
  double? price;
  String? title;
  String? content;
  String? status;
  int? motorbikeId;
  int? showroomId;
  int? sellRequestId;

  PostDtoDetailBuyRequest(
      {this.id,
      this.createdDate,
      this.expiredDate,
      this.postedBy,
      this.price,
      this.title,
      this.content,
      this.status,
      this.motorbikeId,
      this.showroomId,
      this.sellRequestId});

  PostDtoDetailBuyRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['createdDate'];
    expiredDate = json['expiredDate'];
    postedBy = json['postedBy'];
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
    data['postedBy'] = this.postedBy;
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
