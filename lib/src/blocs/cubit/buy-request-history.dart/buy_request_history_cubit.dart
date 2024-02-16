import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/configurations.dart';
import '../../../model/response/buy_request_history_dto.dart';
import '../../../model/response/detail_buy_request.dart';
import '../../../resources/remote/buy_request_history_services.dart';

part 'buy_request_history_state.dart';

class BuyRequestHistoryCubit extends Cubit<BuyRequestHistoryState> {
  BuyRequestHistoryCubit() : super(BuyRequestHistoryState());

  Future<List<BuyRequestHistoryDTO>?> getBuyRequests() async {
    try {
      final customerID = await SharedInstances.secureRead('customerID');

      emit(state.copyWith(status: BuyRequestHistoryStatus.loading));
      final response =
          await BuyRequestHistoryServices().getBuyRequest(customerID!);
      if (response != null) {
        emit(state.copyWith(
            status: BuyRequestHistoryStatus.loaded, sellRequests: response));
        return response;
      } else {
        throw Exception('Failed to load sell requests');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<DetailBuyRequest> getBuyRequestByID(String id) async {
    try {
      emit(state.copyWith(detailStatus: DetailBuyRequestHistoryStatus.loading));
      final response = await BuyRequestHistoryServices().getBuyRequestByID(id);
      if (response != null) {
        emit(state.copyWith(
            detailStatus: DetailBuyRequestHistoryStatus.loaded,
            detailBuyRequest: response));
        return response;
      } else {
        emit(state.copyWith(detailStatus: DetailBuyRequestHistoryStatus.error));

        throw Exception('Failed to load buy request');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<bool> cancelBuyRequest(String id) async {
    try {
      final response = await BuyRequestHistoryServices().cancelBuyRequest(id);
      getBuyRequests();
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
