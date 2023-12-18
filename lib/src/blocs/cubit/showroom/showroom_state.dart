part of 'showroom_cubit.dart';

enum ShowroomStatus {
  initial,
  loading,
  success,
  error,
  loadMore,
}

class ShowroomState extends Equatable {
  const ShowroomState({
    this.status = ShowroomStatus.initial,
    this.showrooms = const <Showroom>[],
    this.hasReachedMax = false,
    this.error,
    this.isEdit = false,
    this.showroom,
  });

  final ShowroomStatus status;
  final bool isEdit;
  final List<Showroom> showrooms;
  final Showroom? showroom;
  final bool hasReachedMax;
  final DioError? error;

  ShowroomState copyWith({
    Showroom? showroom,
    bool? isEdit,
    ShowroomStatus? status,
    List<Showroom>? showrooms,
    bool? hasReachedMax,
    DioError? error,
  }) {
    return ShowroomState(
      showroom: showroom ?? this.showroom,
      isEdit: isEdit ?? this.isEdit,
      status: status ?? this.status,
      showrooms: showrooms ?? this.showrooms,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [showroom, status, showrooms, hasReachedMax, error, isEdit];

  @override
  bool? get stringify => true;
}
