import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logger.dart';
import '../../../common/dio_client.dart';
import '../../../model/response/showroom_response.dart';
import '../../../resources/remote/showroom_services.dart';

part 'showroom_state.dart';

class ShowroomCubit extends Cubit<ShowroomState> {
  ShowroomCubit() : super(ShowroomState());

  Future<List<Showroom>?> getShowrooms() async {
    try {
      emit(state.copyWith(status: ShowroomStatus.loading));
      final response = await ShowroomServices().getShowrooms();
      if (response != null) {
        emit(state.copyWith(
            status: ShowroomStatus.success, showrooms: response));
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
        emit(
            state.copyWith(status: ShowroomStatus.success, showroom: response));
        return response;
      } else {
        throw Exception('Failed to load showroom');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  onChangeSearchString(String searchString) {
    String locationChecked = state.location ?? '';
    if (searchString.isEmpty) {
      emit(state.copyWith(searchString: searchString));
      searchShowrooms("", locationChecked);
    } else {
      emit(state.copyWith(searchString: searchString));
      searchShowrooms(searchString, locationChecked);
    }
  }

  onChangeLocation(String location) {
    String locationChecked = location.endsWith('Toàn quốc') ? '' : location;
    emit(state.copyWith(location: locationChecked));
    String searchString = state.searchString ?? '';
    searchShowrooms(searchString, locationChecked);
  }

  Future<List<Showroom>?> searchShowrooms(
      String searchString, String location) async {
    try {
      emit(state.copyWith(status: ShowroomStatus.loading));
      final response = await ShowroomServices().getShowroomsPaging(
        searchString,
        location,
      );
      if (response != null) {
        emit(state.copyWith(
            status: ShowroomStatus.success, showrooms: response));
        return response;
      } else {
        throw Exception('Failed to load showrooms');
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
