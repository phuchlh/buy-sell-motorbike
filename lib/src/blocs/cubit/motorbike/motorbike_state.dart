part of 'motorbike_cubit.dart';

enum MotorbikeStatus {
  initial,
  loading,
  success,
  error,
  loadMore,
}

class MotorbikeState extends Equatable {
  const MotorbikeState({
    this.motorbike,
    this.status = MotorbikeStatus.initial,
    this.motorbikes = const <Motorbike>[],
    this.hasReachedMax = false,
    this.error,
    this.isEdit = false,
  });

  final MotorbikeStatus status;
  final bool isEdit;
  final Motorbike? motorbike;
  final List<Motorbike> motorbikes;
  final bool hasReachedMax;
  final DioError? error;

  MotorbikeState copyWith({
    Motorbike? motorbike,
    bool? isEdit,
    MotorbikeStatus? status,
    List<Motorbike>? motorbikes,
    bool? hasReachedMax,
    DioError? error,
  }) {
    return MotorbikeState(
      motorbike: motorbike ?? this.motorbike,
      isEdit: isEdit ?? this.isEdit,
      status: status ?? this.status,
      motorbikes: motorbikes ?? this.motorbikes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, motorbikes, hasReachedMax, error, isEdit, motorbike];

  @override
  bool? get stringify => true;
}
