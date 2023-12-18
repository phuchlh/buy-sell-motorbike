import 'package:dio/dio.dart';
import 'package:buy_sell_motorbike/src/common/dio_client.dart';
import 'package:buy_sell_motorbike/src/model/response/buy_request_history_dto.dart';
import 'package:buy_sell_motorbike/src/model/response/detail_buy_request.dart';

String BUY_REQUEST_HISTORY = "/buy-requests";
String CUSTOMER = "/customer";

class BuyRequestHistoryServices {
  Future<List<BuyRequestHistoryDTO>?> getBuyRequest(String customerID) async {
    try {
      final response = await DioClient.get('$BUY_REQUEST_HISTORY$CUSTOMER/$customerID');
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => BuyRequestHistoryDTO.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load sell requests');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<DetailBuyRequest> getBuyRequestByID(int id) async {
    try {
      final response = await DioClient.get(BUY_REQUEST_HISTORY + "/$id");
      if (response.statusCode == 200) {
        return DetailBuyRequest.fromJson(response.data);
      } else {
        throw Exception('Failed to load buy request');
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
