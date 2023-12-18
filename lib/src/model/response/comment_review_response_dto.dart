class CommentReviewResponse {
  int? id;
  String? commentatorId;
  String? commentatorName;
  String? commentatorType;
  String? commentContent;
  String? commentDate;
  String? avatarUrl;
  int? customerReviewsId;

  CommentReviewResponse(
      {this.id,
      this.commentatorId,
      this.commentatorName,
      this.commentatorType,
      this.commentContent,
      this.commentDate,
      this.avatarUrl,
      this.customerReviewsId});

  factory CommentReviewResponse.fromJson(Map<String, dynamic> json) {
    return CommentReviewResponse(
      id: json['id'],
      commentatorId: json['commentatorId'],
      commentatorName: json['commentatorName'],
      commentatorType: json['commentatorType'],
      commentContent: json['commentContent'],
      commentDate: json['commentDate'],
      avatarUrl: json.containsKey('avatarUrl') ? json['avatarUrl'] : null,
      customerReviewsId: json['customerReviewsId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['commentatorId'] = this.commentatorId;
    data['commentatorName'] = this.commentatorName;
    data['commentatorType'] = this.commentatorType;
    data['commentContent'] = this.commentContent;
    data['commentDate'] = this.commentDate;
    if (avatarUrl != null) {
      data['avatarUrl'] = avatarUrl;
    }
    data['customerReviewsId'] = this.customerReviewsId;
    return data;
  }
}
