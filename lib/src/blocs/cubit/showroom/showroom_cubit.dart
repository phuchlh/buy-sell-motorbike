import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_sell_motorbike/src/common/dio_client.dart';
import 'package:buy_sell_motorbike/src/model/response/showroom_response.dart';
import 'package:buy_sell_motorbike/src/resources/remote/showroom_services.dart';

part 'showroom_state.dart';

class ShowroomCubit extends Cubit<ShowroomState> {
  ShowroomCubit() : super(ShowroomState());

  Future<List<Showroom>?> getShowrooms() async {
    try {
      emit(state.copyWith(status: ShowroomStatus.loading));
      final response = await ShowroomServices().getShowrooms();
      if (response != null) {
        emit(state.copyWith(status: ShowroomStatus.success, showrooms: response));
      } else {
        throw Exception('Failed to load showrooms');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<Showroom> getShowroomById(String id) async {
    try {
      emit(state.copyWith(status: ShowroomStatus.loading));
      final response = await ShowroomServices().getShowroomById(id);
      if (response != null) {
        emit(state.copyWith(status: ShowroomStatus.success, showroom: response));
        return response;
      } else {
        throw Exception('Failed to load showroom');
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
