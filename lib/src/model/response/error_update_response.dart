class ErrorUpdate {
  int? ts;
  int? status;
  bool? success;
  String? message;

  ErrorUpdate({this.ts, this.status, this.success, this.message});

  ErrorUpdate.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    status = json['status'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ts'] = this.ts;
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}
