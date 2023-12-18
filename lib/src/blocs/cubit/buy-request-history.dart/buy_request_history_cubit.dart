import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_sell_motorbike/src/common/configurations.dart';
import 'package:buy_sell_motorbike/src/model/response/buy_request_history_dto.dart';
import 'package:buy_sell_motorbike/src/model/response/detail_buy_request.dart';
import 'package:buy_sell_motorbike/src/resources/remote/buy_request_history_services.dart';

part 'buy_request_history_state.dart';

class BuyRequestHistoryCubit extends Cubit<BuyRequestHistoryState> {
  BuyRequestHistoryCubit() : super(BuyRequestHistoryState());

  Future<List<BuyRequestHistoryDTO>?> getBuyRequests() async {
    try {
      final customerID = await SharedInstances.secureRead('customerID');

      emit(state.copyWith(status: BuyRequestHistoryStatus.loading));
      final response = await BuyRequestHistoryServices().getBuyRequest(customerID!);
      if (response != null) {
        emit(state.copyWith(status: BuyRequestHistoryStatus.loaded, sellRequests: response));
        return response;
      } else {
        throw Exception('Failed to load sell requests');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<DetailBuyRequest> getBuyRequestByID(int id) async {
    try {
      emit(state.copyWith(status: BuyRequestHistoryStatus.loading));
      final response = await BuyRequestHistoryServices().getBuyRequestByID(id);
      if (response != null) {
        emit(state.copyWith(
            status: BuyRequestHistoryStatus.loadDetailSuccess, detailBuyRequest: response));
        return response;
      } else {
        emit(state.copyWith(status: BuyRequestHistoryStatus.loadDetailError));

        throw Exception('Failed to load buy request');
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
