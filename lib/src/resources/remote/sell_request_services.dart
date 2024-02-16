import 'package:dio/dio.dart';
import '../../../logger.dart';
import '../../common/dio_client.dart';
import '../../model/response/detail_buy_request.dart';
import '../../model/response/detail_sell_request.dart';
import '../../model/response/sell_request_response.dart';

import '../../blocs/cubit/sell-request/sell_request_cubit.dart';

String SELL_REQUEST_HISTORY = '/sell-requests';
String CUSTOMER = '/customer';
String CANCEL = '/cancel';

class SellRequestServices {
  Future<List<SellRequestHistoryDTO>?> getSellRequests(
      String customerID) async {
    try {
      final response =
          await DioClient.get('$SELL_REQUEST_HISTORY$CUSTOMER/$customerID');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => SellRequestHistoryDTO.fromJson(e))
            .toList();
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
      final response = await DioClient.get('$SELL_REQUEST_HISTORY/$id');
      if (response.statusCode == 200) {
        return (
          DetailSellRequest.fromJson(response.data),
          DetailSellRequestStatus.loaded
        );
      } else if (response.statusCode == 400) {
        return (null, DetailSellRequestStatus.error);
      } else {
        return (null, DetailSellRequestStatus.error);
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<bool> cancelSellRequest(String id) async {
    try {
      final response =
          await DioClient.postOneParam('$SELL_REQUEST_HISTORY/$id$CANCEL');
      Logger.log('status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 409) {
        return false;
      } else {
        throw Exception('Failed to cancel sell request');
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
