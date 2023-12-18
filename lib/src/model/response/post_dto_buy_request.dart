class PostDTOBuyRequest {
  int? id;
  String? createdDate;
  String? expiredDate;
  double? price;
  String? title;
  String? content;
  int? motorbikeId;
  int? showroomId;
  int? sellRequestId;

  PostDTOBuyRequest(
      {this.id,
      this.createdDate,
      this.expiredDate,
      this.price,
      this.title,
      this.content,
      this.motorbikeId,
      this.showroomId,
      this.sellRequestId});

  PostDTOBuyRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['createdDate'];
    expiredDate = json['expiredDate'];
    price = json['price'];
    title = json['title'];
    content = json['content'];
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
    data['motorbikeId'] = this.motorbikeId;
    data['showroomId'] = this.showroomId;
    data['sellRequestId'] = this.sellRequestId;
    return data;
  }
}
