part of 'comment_cubit.dart';

enum CommentStatus {
  initial,
  loading,
  success,
  error,
  loadMore,
  notLoginYet,
  successComment,
  failComment,
}

class CommentState extends Equatable {
  final String replyReview;
  final int stars;
  final String userReview;
  // final CustomerReviewPost customerReviewPost = CustomerReviewPost();
  final CommentStatus status;
  final String err;
  final List<CommentResponse> comments;
  final bool hasReachedMax;
  final CommentResponse? comment;

  const CommentState({
    this.replyReview = '',
    this.stars = 0,
    this.userReview = '',
    this.status = CommentStatus.initial,
    this.err = '',
    this.comments = const <CommentResponse>[],
    this.hasReachedMax = false,
    this.comment,
  });
  CommentState copyWith({
    String? replyReview,
    int? stars,
    String? userReview,
    CommentStatus? status,
    String? err,
    List<CommentResponse>? comments,
    bool? hasReachedMax,
    CommentResponse? comment,
  }) {
    return CommentState(
      replyReview: replyReview ?? this.replyReview,
      stars: stars ?? this.stars,
      userReview: userReview ?? this.userReview,
      status: status ?? this.status,
      err: err ?? this.err,
      comments: comments ?? this.comments,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        replyReview,
        stars,
        userReview,
        status,
        err,
        comments,
        hasReachedMax,
      ];
}
