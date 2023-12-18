import 'package:dio/dio.dart';
import 'package:buy_sell_motorbike/src/common/dio_client.dart';
import 'package:buy_sell_motorbike/src/model/response/detail_buy_request.dart';
import 'package:buy_sell_motorbike/src/model/response/detail_sell_request.dart';
import 'package:buy_sell_motorbike/src/model/response/sell_request_response.dart';

String SELL_REQUEST_HISTORY = '/sell-requests';
String CUSTOMER = '/customer';

class SellRequestServices {
  Future<List<SellRequestHistoryDTO>?> getSellRequests(String customerID) async {
    try {
      final response = await DioClient.get('$SELL_REQUEST_HISTORY$CUSTOMER/$customerID');
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => SellRequestHistoryDTO.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load sell requests');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<DetailSellRequest?> getSellRequestById(String id) async {
    try {
      final response = await DioClient.get('$SELL_REQUEST_HISTORY/$id');
      if (response.statusCode == 200) {
        return DetailSellRequest.fromJson(response.data);
      } else {
        throw Exception('Failed to load sell request');
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
