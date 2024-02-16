import 'customer_response_replaced.dart';
import 'response_customerdto.dart';

class UserDTO {
  int? id;
  String? userName;
  String? phone;
  String? email;
  String? password;
  bool? status;
  int? roleId;
  String? roleName;
  CustomerDtoReplaced? customerDto;

  UserDTO(
      {this.id,
      this.userName,
      this.phone,
      this.email,
      this.password,
      this.status,
      this.roleId,
      this.roleName,
      this.customerDto});

  UserDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    roleId = json['roleId'];
    roleName = json['roleName'];
    customerDto = json['customerDto'] != null
        ? new CustomerDtoReplaced.fromJson(json['customerDto'])
        : null;
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
