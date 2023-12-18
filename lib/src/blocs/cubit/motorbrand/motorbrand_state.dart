part of 'motorbrand_cubit.dart';

enum MotorBrandStatus { initial, loading, loaded, error }

class MotorBrandState extends Equatable {
  final bool isEdit;
  final MotorBrandStatus status;
  final List<MotorBrand> motorBrands;
  final MotorBrand? selectedMotorBrand;
  final String? msg;

  const MotorBrandState({
    this.isEdit = false,
    this.status = MotorBrandStatus.initial,
    this.motorBrands = const [],
    this.selectedMotorBrand,
    this.msg,
  });
  MotorBrandState copyWith({
    bool? isEdit,
    MotorBrandStatus? status,
    List<MotorBrand>? motorBrands,
    MotorBrand? selectedMotorBrand,
    String? msg,
  }) {
    return MotorBrandState(
      isEdit: isEdit ?? this.isEdit,
      status: status ?? this.status,
      motorBrands: motorBrands ?? this.motorBrands,
      selectedMotorBrand: selectedMotorBrand ?? this.selectedMotorBrand,
      msg: msg ?? this.msg,
    );
  }

  @override
  List<Object?> get props => [isEdit, status, motorBrands, selectedMotorBrand, msg];
}
