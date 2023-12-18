import 'package:dio/dio.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/buy-request/buy_request_cubit.dart';
import 'package:buy_sell_motorbike/src/common/dio_client.dart';
import 'package:buy_sell_motorbike/src/model/request/buy_request_req.dart';
import 'package:buy_sell_motorbike/src/model/response/detail_buy_request.dart';

String BUY_REQUEST = "/buy-requests";

class BuyRequestServices {
  Future<BuyRequestStatus> createBuyRequest(BuyRequest buyRequest) async {
    try {
      final response = await DioClient.post(BUY_REQUEST, {
        "criteria": buyRequest.toJson(),
      });
      if (response.statusCode == 200) {
        return BuyRequestStatus.success;
      } else {
        return BuyRequestStatus.error;
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
