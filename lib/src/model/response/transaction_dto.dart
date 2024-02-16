class TransactionDtos {
  int? id;
  int? showroomStaffId;
  String? showroomStaffName;
  String? originBankName;
  String? originAccountNumber;
  String? originAccountHolder;
  String? targetBankName;
  String? targetAccountNumber;
  String? targetAccountHolder;
  double? amount;
  String? description;
  String? recordedDate;
  String? type;
  int? buyRequestId;
  int? sellRequestId;
  int? showroomId;

  TransactionDtos(
      {this.id,
      this.showroomStaffId,
      this.showroomStaffName,
      this.originBankName,
      this.originAccountNumber,
      this.originAccountHolder,
      this.targetBankName,
      this.targetAccountNumber,
      this.targetAccountHolder,
      this.amount,
      this.description,
      this.recordedDate,
      this.type,
      this.buyRequestId,
      this.sellRequestId,
      this.showroomId});

  TransactionDtos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    showroomStaffId = json['showroomStaffId'];
    showroomStaffName = json['showroomStaffName'];
    originBankName = json['originBankName'];
    originAccountNumber = json['originAccountNumber'];
    originAccountHolder = json['originAccountHolder'];
    targetBankName = json['targetBankName'];
    targetAccountNumber = json['targetAccountNumber'];
    targetAccountHolder = json['targetAccountHolder'];
    amount = json['amount'];
    description = json['description'];
    recordedDate = json['recordedDate'];
    type = json['type'];
    buyRequestId = json['buyRequestId'];
    sellRequestId = json['sellRequestId'];
    showroomId = json['showroomId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['showroomStaffId'] = this.showroomStaffId;
    data['showroomStaffName'] = this.showroomStaffName;
    data['originBankName'] = this.originBankName;
    data['originAccountNumber'] = this.originAccountNumber;
    data['originAccountHolder'] = this.originAccountHolder;
    data['targetBankName'] = this.targetBankName;
    data['targetAccountNumber'] = this.targetAccountNumber;
    data['targetAccountHolder'] = this.targetAccountHolder;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['recordedDate'] = this.recordedDate;
    data['type'] = this.type;
    data['buyRequestId'] = this.buyRequestId;
    data['sellRequestId'] = this.sellRequestId;
    data['showroomId'] = this.showroomId;
    return data;
  }
}
