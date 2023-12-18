class UpdateUserInforCriteria {
  CriteriaUpdateInfor? criteria;
  CustomerDtoUpdateInfo? customerDto;

  UpdateUserInforCriteria({this.criteria, this.customerDto});

  UpdateUserInforCriteria.fromJson(Map<String, dynamic> json) {
    criteria = json['criteria'] != null ? new CriteriaUpdateInfor.fromJson(json['criteria']) : null;
    customerDto = json['customerDto'] != null
        ? new CustomerDtoUpdateInfo.fromJson(json['customerDto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.criteria != null) {
      data['criteria'] = this.criteria!.toJson();
    }
    if (this.customerDto != null) {
      data['customerDto'] = this.customerDto!.toJson();
    }
    return data;
  }
}

class CriteriaUpdateInfor {
  int? id;
  String? phone;
  String? email;

  CriteriaUpdateInfor({this.id, this.phone, this.email});

  CriteriaUpdateInfor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}

class CustomerDtoUpdateInfo {
  int? id;
  String? fullName;
  String? dob;
  String? address;
  int? userId;
  String? avatarUrl;

  CustomerDtoUpdateInfo(
      {this.id, this.fullName, this.dob, this.address, this.userId, this.avatarUrl});

  CustomerDtoUpdateInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    dob = json['dob'];
    address = json['address'];
    userId = json['userId'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['userId'] = this.userId;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}
