class ChangePasswordRequest {
  CriteriaChangePassword? criteria;
  String? oldPassword;
  String? newPassword;
  String? confirmNewPassword;

  ChangePasswordRequest(
      {this.criteria, this.oldPassword, this.newPassword, this.confirmNewPassword});

  ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    criteria =
        json['criteria'] != null ? new CriteriaChangePassword.fromJson(json['criteria']) : null;
    oldPassword = json['oldPassword'];
    newPassword = json['newPassword'];
    confirmNewPassword = json['confirmNewPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.criteria != null) {
      data['criteria'] = this.criteria!.toJson();
    }
    data['oldPassword'] = this.oldPassword;
    data['newPassword'] = this.newPassword;
    data['confirmNewPassword'] = this.confirmNewPassword;
    return data;
  }
}

class CriteriaChangePassword {
  int? id;

  CriteriaChangePassword({this.id});

  CriteriaChangePassword.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
