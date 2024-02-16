import 'detail_sell_request.dart';
import 'request_history_dtos.dart';
import 'transaction_dto.dart';

class DetailBuyRequest {
  int? id;
  String? createdDate;
  String? status;
  int? customerId;
  int? showroomId;
  int? motorbikeId;
  int? postId;
  CustomerVo? customerVo;
  MotorbikeDto? motorbikeDto;
  UserDtoDetail? userDto;
  List<MotorbikeImageDto>? motorbikeImageDto;
  ShowroomDto? showroomDto;
  PostDto? postDto;
  List<TransactionDtos>? transactionDtos;
  CheckingAppointmentDto? checkingAppointmentDto;
  PurchaseAppointmentDto? purchaseAppointmentDto;
  List<RequestHistoryDtos>? requestHistoryDtos;

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
      this.userDto,
      this.motorbikeImageDto,
      this.showroomDto,
      this.postDto,
      this.transactionDtos,
      this.checkingAppointmentDto,
      this.purchaseAppointmentDto,
      this.requestHistoryDtos});

  DetailBuyRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['createdDate'];
    status = json['status'];
    customerId = json['customerId'];
    showroomId = json['showroomId'];
    motorbikeId = json['motorbikeId'];
    postId = json['postId'];
    customerVo = json['customerVo'] != null
        ? new CustomerVo.fromJson(json['customerVo'])
        : null;
    motorbikeDto = json['motorbikeDto'] != null
        ? new MotorbikeDto.fromJson(json['motorbikeDto'])
        : null;
    userDto = json['userDto'] != null
        ? new UserDtoDetail.fromJson(json['userDto'])
        : null;
    if (json['motorbikeImageDto'] != null) {
      motorbikeImageDto = <MotorbikeImageDto>[];
      json['motorbikeImageDto'].forEach((v) {
        motorbikeImageDto!.add(new MotorbikeImageDto.fromJson(v));
      });
    }
    showroomDto = json['showroomDto'] != null
        ? new ShowroomDto.fromJson(json['showroomDto'])
        : null;
    postDto =
        json['postDto'] != null ? new PostDto.fromJson(json['postDto']) : null;
    if (json['transactionDtos'] != null) {
      transactionDtos = <TransactionDtos>[];
      json['transactionDtos'].forEach((v) {
        transactionDtos!.add(new TransactionDtos.fromJson(v));
      });
    }
    checkingAppointmentDto = json['checkingAppointmentDto'] != null
        ? new CheckingAppointmentDto.fromJson(json['checkingAppointmentDto'])
        : null;
    purchaseAppointmentDto = json['purchaseAppointmentDto'] != null
        ? new PurchaseAppointmentDto.fromJson(json['purchaseAppointmentDto'])
        : null;
    if (json['requestHistoryDtos'] != null) {
      requestHistoryDtos = <RequestHistoryDtos>[];
      json['requestHistoryDtos'].forEach((v) {
        requestHistoryDtos!.add(new RequestHistoryDtos.fromJson(v));
      });
    }
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
    if (this.userDto != null) {
      data['userDto'] = this.userDto!.toJson();
    }
    if (this.motorbikeImageDto != null) {
      data['motorbikeImageDto'] =
          this.motorbikeImageDto!.map((v) => v.toJson()).toList();
    }
    if (this.showroomDto != null) {
      data['showroomDto'] = this.showroomDto!.toJson();
    }
    if (this.postDto != null) {
      data['postDto'] = this.postDto!.toJson();
    }
    if (this.transactionDtos != null) {
      data['transactionDtos'] =
          this.transactionDtos!.map((v) => v.toJson()).toList();
    }
    if (this.checkingAppointmentDto != null) {
      data['checkingAppointmentDto'] = this.checkingAppointmentDto!.toJson();
    }
    if (this.purchaseAppointmentDto != null) {
      data['purchaseAppointmentDto'] = this.purchaseAppointmentDto!.toJson();
    }
    if (this.requestHistoryDtos != null) {
      data['requestHistoryDtos'] =
          this.requestHistoryDtos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerVo {
  int? id;
  String? fullName;
  String? dob;
  String? address;
  String? avatarUrl;
  bool? isSell;
  bool? isBuy;
  int? userId;
  String? phone;

  CustomerVo(
      {this.id,
      this.fullName,
      this.dob,
      this.address,
      this.avatarUrl,
      this.isSell,
      this.isBuy,
      this.userId,
      this.phone});

  CustomerVo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    dob = json['dob'];
    address = json['address'];
    avatarUrl = json['avatarUrl'];
    isSell = json['isSell'];
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
    data['isSell'] = this.isSell;
    data['isBuy'] = this.isBuy;
    data['userId'] = this.userId;
    data['phone'] = this.phone;
    return data;
  }
}

class MotorbikeDto {
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

  MotorbikeDto(
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

  MotorbikeDto.fromJson(Map<String, dynamic> json) {
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

class UserDtoDetail {
  int? id;
  String? userName;
  String? phone;
  String? email;
  String? password;
  bool? status;
  int? roleId;

  UserDtoDetail(
      {this.id,
      this.userName,
      this.phone,
      this.email,
      this.password,
      this.status,
      this.roleId});

  UserDtoDetail.fromJson(Map<String, dynamic> json) {
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

class MotorbikeImageDto {
  int? id;
  String? url;
  String? name;
  bool? isThumbnail;
  int? motorbikeId;

  MotorbikeImageDto(
      {this.id, this.url, this.name, this.isThumbnail, this.motorbikeId});

  MotorbikeImageDto.fromJson(Map<String, dynamic> json) {
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

class ShowroomDto {
  int? id;
  String? name;
  String? address;
  String? province;
  String? email;
  String? phone;
  String? bankName;
  String? accountNumber;
  String? accountHolder;

  ShowroomDto(
      {this.id,
      this.name,
      this.address,
      this.province,
      this.email,
      this.phone,
      this.bankName,
      this.accountNumber,
      this.accountHolder});

  ShowroomDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    province = json['province'];
    email = json['email'];
    phone = json['phone'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    accountHolder = json['accountHolder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['province'] = this.province;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    data['accountHolder'] = this.accountHolder;
    return data;
  }
}

class PostDto {
  int? id;
  String? createdDate;
  String? expiredDate;
  double? price;
  String? title;
  String? content;
  String? status;
  int? motorbikeId;
  int? showroomId;
  int? sellRequestId;

  PostDto(
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

  PostDto.fromJson(Map<String, dynamic> json) {
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

class CheckingAppointmentDto {
  int? id;
  String? appointmentDate;
  String? status;
  String? scheduledBy;
  int? customerId;
  int? showroomId;
  int? buyRequestId;

  CheckingAppointmentDto(
      {this.id,
      this.appointmentDate,
      this.status,
      this.scheduledBy,
      this.customerId,
      this.showroomId,
      this.buyRequestId});

  CheckingAppointmentDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentDate = json['appointmentDate'];
    status = json['status'];
    scheduledBy = json['scheduledBy'];
    customerId = json['customerId'];
    showroomId = json['showroomId'];
    buyRequestId = json['buyRequestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appointmentDate'] = this.appointmentDate;
    data['status'] = this.status;
    data['scheduledBy'] = this.scheduledBy;
    data['customerId'] = this.customerId;
    data['showroomId'] = this.showroomId;
    data['buyRequestId'] = this.buyRequestId;
    return data;
  }
}

class PurchaseAppointmentDto {
  int? id;
  String? status;
  String? appointmentDate;
  int? buyerId;
  int? sellerId;
  int? showroomId;
  int? motorbikeId;

  PurchaseAppointmentDto(
      {this.id,
      this.status,
      this.appointmentDate,
      this.buyerId,
      this.sellerId,
      this.showroomId,
      this.motorbikeId});

  PurchaseAppointmentDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    appointmentDate = json['appointmentDate'];
    buyerId = json['buyerId'];
    sellerId = json['sellerId'];
    showroomId = json['showroomId'];
    motorbikeId = json['motorbikeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['appointmentDate'] = this.appointmentDate;
    data['buyerId'] = this.buyerId;
    data['sellerId'] = this.sellerId;
    data['showroomId'] = this.showroomId;
    data['motorbikeId'] = this.motorbikeId;
    return data;
  }
}
