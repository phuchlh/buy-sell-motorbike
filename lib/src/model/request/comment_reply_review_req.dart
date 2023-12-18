class CriteriaCommentReply {
  String? commentatorId;
  String? commentatorName;
  String? commentatorType;
  String? avatarUrl;
  String? commentContent;
  int? customerReviewsId;

  CriteriaCommentReply(
      {this.commentatorId,
      this.commentatorName,
      this.commentatorType,
      this.avatarUrl,
      this.commentContent,
      this.customerReviewsId});

  CriteriaCommentReply.fromJson(Map<String, dynamic> json) {
    commentatorId = json['commentatorId'];
    commentatorName = json['commentatorName'];
    commentatorType = json['commentatorType'];
    avatarUrl = json['avatarUrl'];
    commentContent = json['commentContent'];
    customerReviewsId = json['customerReviewsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentatorId'] = this.commentatorId;
    data['commentatorName'] = this.commentatorName;
    data['commentatorType'] = this.commentatorType;
    data['avatarUrl'] = this.avatarUrl;
    data['commentContent'] = this.commentContent;
    data['customerReviewsId'] = this.customerReviewsId;
    return data;
  }
}
