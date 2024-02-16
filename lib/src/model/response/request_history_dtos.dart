class RequestHistoryDtos {
  int? id;
  String? requestType;
  String? content;
  String? createdDate;
  int? requestId;

  RequestHistoryDtos({this.id, this.requestType, this.content, this.createdDate, this.requestId});

  RequestHistoryDtos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestType = json['requestType'];
    content = json['content'];
    createdDate = json['createdDate'];
    requestId = json['requestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['requestType'] = this.requestType;
    data['content'] = this.content;
    data['createdDate'] = this.createdDate;
    data['requestId'] = this.requestId;
    return data;
  }
}