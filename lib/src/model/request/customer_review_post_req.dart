class CustomerReviewPost {
  int? customerId;
  int? showroomId;
  String? reviewContent;
  int? reviewRating;

  CustomerReviewPost({this.customerId, this.showroomId, this.reviewContent, this.reviewRating});

  CustomerReviewPost.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    showroomId = json['showroomId'];
    reviewContent = json['reviewContent'];
    reviewRating = json['reviewRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['showroomId'] = this.showroomId;
    data['reviewContent'] = this.reviewContent;
    data['reviewRating'] = this.reviewRating;
    return data;
  }
}
