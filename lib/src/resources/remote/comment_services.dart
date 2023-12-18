import 'package:dio/dio.dart';
import 'package:buy_sell_motorbike/logger.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/comment/comment_cubit.dart';
import 'package:buy_sell_motorbike/src/common/configurations.dart';
import 'package:buy_sell_motorbike/src/common/dio_client.dart';
import 'package:buy_sell_motorbike/src/model/request/comment_reply_review_req.dart';
import 'package:buy_sell_motorbike/src/model/request/customer_review_post_req.dart';
import 'package:buy_sell_motorbike/src/model/response/comment_response.dart';

String COMMENTS = '/customer-reviews';
String COMMENT_REVIEW = '/comment-reviews';

class CommentServices {
  Future<List<CommentResponse>?> getComments(int id) async {
    try {
      final response = await DioClient.get(
        '$COMMENTS/showroom/$id',
      );
      final comments =
          (response.data as List).map((comment) => CommentResponse.fromJson(comment)).toList();
      return comments;
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<CommentStatus> postReview(CustomerReviewPost customerReview) async {
    try {
      final response = await DioClient.post(
        '$COMMENTS',
        {
          "criteria": customerReview.toJson(),
        },
      );
      if (response.statusCode == 200) {
        return CommentStatus.success;
      } else {
        throw Exception('Failed to post review');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<CommentStatus> postReplyReview(CriteriaCommentReply commentReply) async {
    try {
      Logger.log('commentReply: ${commentReply.toJson()}');
      final response = await DioClient.post(COMMENT_REVIEW, {
        'criteria': commentReply.toJson(),
      });
      if (response.statusCode == 200) {
        return CommentStatus.successComment;
      } else {
        return CommentStatus.failComment;
      }
    } on DioError catch (e) {
      // Handle DioError
      Logger.error('DioError: ${e.message}');
      Logger.error('Response status code: ${e.response?.statusCode}');
      return CommentStatus.failComment;
    } catch (e) {
      // Handle other types of errors
      Logger.error('Error: $e');
      return CommentStatus.failComment;
    }
  }
}
