import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_sell_motorbike/src/model/response/response_motorbike.dart';

import 'package:equatable/equatable.dart';
import 'package:buy_sell_motorbike/src/resources/remote/motorbike_services.dart';
part "motorbike_state.dart";

class MotorbikeCubit extends Cubit<MotorbikeState> {
  MotorbikeCubit() : super(MotorbikeState());

  init() async {
    emit(state.copyWith(status: MotorbikeStatus.loading, isEdit: false));
  }

  Future<void> getMotorbikes() async {
    try {
      emit(state.copyWith(status: MotorbikeStatus.loading));
      final motors = await MotorbikeServices().getMotorbikes();
      if (motors != null) {
        emit(state.copyWith(status: MotorbikeStatus.success, motorbikes: motors));
      } else {
        emit(state.copyWith(status: MotorbikeStatus.error));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: MotorbikeStatus.error));
    }
  }

  Future<void> getMotorbikeByShowroomID(int id) async {
    try {
      emit(state.copyWith(status: MotorbikeStatus.loading));
      final motor = await MotorbikeServices().getMotorbikeByShowroomID(id);
      if (motor != null) {
        emit(state.copyWith(status: MotorbikeStatus.success, motorbikes: motor));
      } else {
        emit(state.copyWith(status: MotorbikeStatus.error));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: MotorbikeStatus.error));
    }
  }

  Future<void> getMotorbikeByID(int id) async {
    try {
      emit(state.copyWith(status: MotorbikeStatus.loading));
      final motor = await MotorbikeServices().getMotorbikeByID(id);
      if (motor != null) {
        emit(state.copyWith(status: MotorbikeStatus.success, motorbike: motor));
      } else {
        emit(state.copyWith(status: MotorbikeStatus.error));
      }
    } on DioError catch (e) {
      emit(state.copyWith(status: MotorbikeStatus.error));
    }
  }
}
