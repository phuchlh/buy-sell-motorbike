import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../logger.dart';
import '../../../common/configurations.dart';
import '../../../model/request/comment_reply_review_req.dart';
import '../../../model/request/customer_review_post_req.dart';
import '../../../model/response/comment_response.dart';
import '../../../resources/remote/comment_services.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentState());

  Future<void> getComments(int id) async {
    try {
      emit(state.copyWith(status: CommentStatus.loading));
      final response = await CommentServices().getComments(id);
      if (response != null) {
        emit(state.copyWith(status: CommentStatus.success, comments: response));
      } else {
        throw Exception('Failed to load comments');
      }
    } on DioError catch (e) {
      EasyLoading.showError('Xảy ra lỗi khi load bình luận');
    }
  }

  onChangeStars(double stars) {
    final intStars = stars.toInt();
    emit(state.copyWith(stars: intStars));
    print('stars: ${stars}');
  }

  onChangeUserReview(String userReview) {
    emit(state.copyWith(userReview: userReview));
    print('userReview: ${userReview}');
  }

  Future<CommentStatus> postReview(String showroomID) async {
    try {
      emit(state.copyWith(status: CommentStatus.loading));
      final customerID = await SharedInstances.secureRead('customerID');

      if (customerID == null) {
        emit(state.copyWith(status: CommentStatus.notLoginYet));
      } else {
        emit(state.copyWith(status: CommentStatus.loading));
        int stars = state.stars == 0 ? 1 : state.stars;
        final userReview = state.userReview;
        final customerReview = CustomerReviewPost(
          customerId: int.parse(customerID),
          showroomId: int.parse(showroomID),
          reviewRating: int.parse(stars.toString()),
          reviewContent: userReview,
        );
        final response = await CommentServices().postReview(customerReview);
        if (response == CommentStatus.success) {
          emit(state.copyWith(status: CommentStatus.success));
          return CommentStatus.success;
        } else {
          emit(state.copyWith(status: CommentStatus.error));
          throw Exception('Failed to post review');
        }
      }
      return CommentStatus.error;
    } on DioError catch (e) {
      EasyLoading.showError('Xảy ra lỗi khi đăng bình luận');
      return CommentStatus.error;
    }
  }

  onChangeReplyReview(String replyReview) {
    emit(state.copyWith(replyReview: replyReview));
    print('replyReview: ${replyReview}');
  }

  Future<CommentStatus> postReplyReview(
      String customerName, String avatarUrl, int customerReviewID) async {
    try {
      emit(state.copyWith(status: CommentStatus.loading));
      final customerID = await SharedInstances.secureRead('customerID');

      if (customerID == null) {
        emit(state.copyWith(status: CommentStatus.notLoginYet));
      } else {
        emit(state.copyWith(status: CommentStatus.loading));
        final replyReview = state.replyReview;
        final customerReview = CriteriaCommentReply(
          commentatorId: customerID,
          commentatorName: customerName,
          commentatorType: 'CUSTOMER',
          avatarUrl: avatarUrl,
          commentContent: replyReview,
          customerReviewsId: customerReviewID,
        );
        final response =
            await CommentServices().postReplyReview(customerReview);
        if (response == CommentStatus.successComment) {
          emit(state.copyWith(status: CommentStatus.successComment));
          return CommentStatus.successComment;
        } else {
          emit(state.copyWith(status: CommentStatus.failComment));
          throw Exception('Failed to post review');
        }
      }
      return CommentStatus.error;
    } on DioError catch (e) {
      // Handle DioError
      Logger.error('DioError: ${e.message}');
      Logger.error('Response status code: ${e.response?.statusCode}');
      EasyLoading.showError('thất bại, vui lòng kiểm tra lại ');
      emit(state.copyWith(status: CommentStatus.failComment));
      return CommentStatus.failComment;
    } catch (e) {
      // Handle other types of errors
      Logger.error('Error: $e');
      EasyLoading.showError('Thất bại');
      emit(state.copyWith(status: CommentStatus.successComment));
      return CommentStatus.successComment;
    }
  }
}
