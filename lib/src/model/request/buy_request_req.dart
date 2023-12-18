class BuyRequest {
  int? customerId;
  int? showroomId;
  int? motorbikeId;
  int? postId;

  BuyRequest({this.customerId, this.showroomId, this.motorbikeId, this.postId});

  BuyRequest.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    showroomId = json['showroomId'];
    motorbikeId = json['motorbikeId'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['showroomId'] = this.showroomId;
    data['motorbikeId'] = this.motorbikeId;
    data['postId'] = this.postId;
    return data;
  }
}
