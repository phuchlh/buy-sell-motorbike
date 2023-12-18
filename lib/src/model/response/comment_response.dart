import 'package:buy_sell_motorbike/src/model/response/comment_review_response_dto.dart';
import 'package:buy_sell_motorbike/src/model/response/customer_response_replaced.dart';
import 'package:buy_sell_motorbike/src/model/response/response_customerdto.dart';

class CommentResponse {
  int? id;
  int? customerId;
  int? showroomId;
  String? reviewDate;
  String? reviewContent;
  double? reviewRating;
  CustomerDtoReplaced? customerDto;

  List<CommentReviewResponse>? commentReviewsDtos;

  CommentResponse({
    this.id,
    this.customerId,
    this.showroomId,
    this.reviewDate,
    this.reviewContent,
    this.reviewRating,
    this.customerDto,
    this.commentReviewsDtos,
  });

  CommentResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    showroomId = json['showroomId'];
    reviewDate = json['reviewDate'];
    reviewContent = json['reviewContent'];
    reviewRating = json['reviewRating'];
    customerDto =
        json['customerDto'] != null ? new CustomerDtoReplaced.fromJson(json['customerDto']) : null;
    if (json['commentReviewsDtos'] != null) {
      commentReviewsDtos = <CommentReviewResponse>[];
      json['commentReviewsDtos'].forEach((v) {
        commentReviewsDtos!.add(new CommentReviewResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.customerId;
    data['showroomId'] = this.showroomId;
    data['reviewDate'] = this.reviewDate;
    data['reviewContent'] = this.reviewContent;
    data['reviewRating'] = this.reviewRating;
    if (this.customerDto != null) {
      data['customerDto'] = this.customerDto!.toJson();
    }
    if (this.commentReviewsDtos != null) {
      data['commentReviewsDtos'] = this.commentReviewsDtos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
