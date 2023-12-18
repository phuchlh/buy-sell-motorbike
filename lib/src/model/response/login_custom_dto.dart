class LoginCustomerDTO {
  int? id;
  String? userName;
  String? phone;
  String? email;
  String? password;
  bool? status;
  int? roleId;
  String? roleName;
  CustomerDto? customerDto;

  LoginCustomerDTO(
      {this.id,
      this.userName,
      this.phone,
      this.email,
      this.password,
      this.status,
      this.roleId,
      this.roleName,
      this.customerDto});

  LoginCustomerDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    roleId = json['roleId'];
    roleName = json['roleName'];
    customerDto =
        json['customerDto'] != null ? new CustomerDto.fromJson(json['customerDto']) : null;
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
    data['roleName'] = this.roleName;
    if (this.customerDto != null) {
      data['customerDto'] = this.customerDto!.toJson();
    }
    return data;
  }
}

class CustomerDto {
  int? id;
  String? fullName;
  String? dob;
  String? address;
  String? avatarUrl;
  int? userId;

  CustomerDto({this.id, this.fullName, this.dob, this.address, this.avatarUrl, this.userId});

  CustomerDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    dob = json['dob'];
    address = json['address'];
    avatarUrl = json['avatarUrl'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['avatarUrl'] = this.avatarUrl;
    data['userId'] = this.userId;
    return data;
  }
}
