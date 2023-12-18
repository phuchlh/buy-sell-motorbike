class CriteriaPostUser {
  String? userName;
  String? phone;
  String? email;
  String? password;

  CriteriaPostUser({this.userName, this.phone, this.email, this.password});

  CriteriaPostUser.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
