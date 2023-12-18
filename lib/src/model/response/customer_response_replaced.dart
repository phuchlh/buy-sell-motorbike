class CustomerDtoReplaced {
  int? id;
  String? fullName;
  String? dob;
  String? address;
  String? avatarUrl;
  int? userId;
  bool? isBuy;

  CustomerDtoReplaced({
    this.id,
    this.fullName,
    this.dob,
    this.address,
    this.avatarUrl,
    this.userId,
    this.isBuy,
  });

  factory CustomerDtoReplaced.fromJson(Map<String, dynamic> json) {
    return CustomerDtoReplaced(
      id: json['id'],
      fullName: json['fullName'],
      dob: json['dob'],
      address: json['address'],
      avatarUrl: json.containsKey('avatarUrl') ? json['avatarUrl'] : null,
      userId: json['userId'],
      isBuy: json['isBuy'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'fullName': fullName,
      'dob': dob,
      'address': address,
      'userId': userId,
      'isBuy': isBuy,
    };

    if (avatarUrl != null) {
      data['avatarUrl'] = avatarUrl;
    }

    return data;
  }
}
