class NotificationDTO {
  int? id;
  String? requestType;
  String? notificationContent;
  String? notificationDate;
  bool? isNotified;
  bool? isSeen;
  int? customerId;
  int? requestId;

  NotificationDTO(
      {this.id,
      this.requestType,
      this.notificationContent,
      this.notificationDate,
      this.isNotified,
      this.isSeen,
      this.customerId,
      this.requestId});

  NotificationDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestType = json['requestType'];
    notificationContent = json['notificationContent'];
    notificationDate = json['notificationDate'];
    isNotified = json['isNotified'];
    isSeen = json['isSeen'];
    customerId = json['customerId'];
    requestId = json['requestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['requestType'] = this.requestType;
    data['notificationContent'] = this.notificationContent;
    data['notificationDate'] = this.notificationDate;
    data['isNotified'] = this.isNotified;
    data['isSeen'] = this.isSeen;
    data['customerId'] = this.customerId;
    data['requestId'] = this.requestId;
    return data;
  }
}
