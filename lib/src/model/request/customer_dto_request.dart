class CustomerDTORequest {
  String? fullName;
  String? dob;
  String? address;
  String? avatarUrl;

  CustomerDTORequest({this.fullName, this.dob, this.address, this.avatarUrl});

  CustomerDTORequest.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    dob = json['dob'];
    address = json['address'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}
