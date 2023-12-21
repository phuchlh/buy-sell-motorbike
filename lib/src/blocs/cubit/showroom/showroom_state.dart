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
    this.location,
    this.searchString,
    this.status = ShowroomStatus.initial,
    this.showrooms = const <Showroom>[],
    this.hasReachedMax = false,
    this.error,
    this.isEdit = false,
    this.showroom,
  });
  final String? location;
  final String? searchString;
  final ShowroomStatus status;
  final bool isEdit;
  final List<Showroom> showrooms;
  final Showroom? showroom;
  final bool hasReachedMax;
  final DioError? error;

  ShowroomState copyWith({
    String? location,
    String? searchString,
    Showroom? showroom,
    bool? isEdit,
    ShowroomStatus? status,
    List<Showroom>? showrooms,
    bool? hasReachedMax,
    DioError? error,
  }) {
    return ShowroomState(
      location: location ?? this.location,
      searchString: searchString ?? this.searchString,
      showroom: showroom ?? this.showroom,
      isEdit: isEdit ?? this.isEdit,
      status: status ?? this.status,
      showrooms: showrooms ?? this.showrooms,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [location, searchString, showroom, status, showrooms, hasReachedMax, error, isEdit];

  @override
  bool? get stringify => true;
}
