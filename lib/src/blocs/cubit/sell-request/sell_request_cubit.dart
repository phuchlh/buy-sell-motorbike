import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_sell_motorbike/src/common/configurations.dart';
import 'package:buy_sell_motorbike/src/model/response/detail_buy_request.dart';
import 'package:buy_sell_motorbike/src/model/response/detail_sell_request.dart';
import 'package:buy_sell_motorbike/src/model/response/response_motorbike.dart';
import 'package:buy_sell_motorbike/src/model/response/sell_request_response.dart';
import 'package:buy_sell_motorbike/src/resources/remote/sell_request_services.dart';

part 'sell_request_state.dart';

class SellRequestHistoryCubit extends Cubit<SellRequestHistoryState> {
  SellRequestHistoryCubit() : super(SellRequestHistoryState());

  Future<List<SellRequestHistoryDTO>?> getSellRequests() async {
    try {
      final customerID = await SharedInstances.secureRead('customerID');

      emit(state.copyWith(status: SellRequestHistoryStatus.loading));
      final response = await SellRequestServices().getSellRequests(customerID!);
      if (response != null) {
        emit(state.copyWith(status: SellRequestHistoryStatus.loaded, sellRequests: response));
        return response;
      } else {
        throw Exception('Failed to load sell requests');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<DetailSellRequest?> getSellRequestById(String id) async {
    try {
      emit(state.copyWith(status: SellRequestHistoryStatus.loadingDetail));
      final response = await SellRequestServices().getSellRequestById(id);
      if (response != null) {
        emit(state.copyWith(
            status: SellRequestHistoryStatus.loadDetailSuccess, detailSellRequest: response));
        return response;
      } else {
        throw Exception('Failed to load sell request');
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
