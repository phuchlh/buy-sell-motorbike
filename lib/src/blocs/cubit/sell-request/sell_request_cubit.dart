import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/configurations.dart';
import '../../../model/response/detail_buy_request.dart';
import '../../../model/response/detail_sell_request.dart';
import '../../../model/response/response_motorbike.dart';
import '../../../model/response/sell_request_response.dart';
import '../../../resources/remote/sell_request_services.dart';

part 'sell_request_state.dart';

class SellRequestHistoryCubit extends Cubit<SellRequestHistoryState> {
  SellRequestHistoryCubit() : super(SellRequestHistoryState());

  Future<List<SellRequestHistoryDTO>?> getSellRequests() async {
    try {
      final customerID = await SharedInstances.secureRead('customerID');

      emit(state.copyWith(status: SellRequestHistoryStatus.loading));
      final response = await SellRequestServices().getSellRequests(customerID!);
      if (response != null) {
        emit(state.copyWith(
            status: SellRequestHistoryStatus.loaded, sellRequests: response));
        return response;
      } else {
        throw Exception('Failed to load sell requests');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<(DetailSellRequest?, DetailSellRequestStatus)> getSellRequestById(
      String id) async {
    try {
      emit(state.copyWith(detailStatus: DetailSellRequestStatus.loading));
      final (data, status) = await SellRequestServices().getSellRequestById(id);
      if (data != null) {
        emit(state.copyWith(
            detailStatus: DetailSellRequestStatus.loaded,
            detailSellRequest: data));
        return (data, status);
      } else {
        emit(state.copyWith(detailStatus: DetailSellRequestStatus.error));
        return (data, status);
      }
    } on DioError catch (e) {
      emit(state.copyWith(detailStatus: DetailSellRequestStatus.error));
      throw e;
    }
  }

  Future<bool> cancelSellRequest(String id) async {
    try {
      final response = await SellRequestServices().cancelSellRequest(id);
      getSellRequests();
      if (response) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
