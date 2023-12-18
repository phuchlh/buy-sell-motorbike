import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_sell_motorbike/src/model/response/motor_brand_response.dart';
import 'package:buy_sell_motorbike/src/resources/remote/motorbrand_services.dart';

part 'motorbrand_state.dart';

class MotorBrandCubit extends Cubit<MotorBrandState> {
  MotorBrandCubit() : super(MotorBrandState());

  init() async {
    emit(state.copyWith(status: MotorBrandStatus.loading, isEdit: false));
  }

  Future<void> getBrands() async {
    try {
      emit(state.copyWith(status: MotorBrandStatus.loading));
      final brands = await MotorBrandServices().getBrands();
      if (brands != null) {
        emit(state.copyWith(status: MotorBrandStatus.loaded, motorBrands: brands));
      } else {
        emit(state.copyWith(status: MotorBrandStatus.error));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: MotorBrandStatus.error));
    }
  }
}
