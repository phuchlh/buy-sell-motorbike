class SampleCriteria {
  double? askingPrice;
  int? customerId;
  int? showroomId;

  SampleCriteria({this.askingPrice, this.customerId, this.showroomId});

  SampleCriteria.fromJson(Map<String, dynamic> json) {
    askingPrice = json['askingPrice'];
    customerId = json['customerId'];
    showroomId = json['showroomId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['askingPrice'] = this.askingPrice;
    data['customerId'] = this.customerId;
    data['showroomId'] = this.showroomId;
    return data;
  }
}
