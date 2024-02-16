import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../logger.dart';
import '../../blocs/cubit/buy-request/buy_request_cubit.dart';
import '../../common/dio_client.dart';
import '../../model/request/buy_request_req.dart';
import '../../model/response/detail_buy_request.dart';

String BUY_REQUEST = "/buy-requests";

class BuyRequestServices {
  Future<(BuyRequestStatus, String)> createBuyRequest(
      BuyRequest buyRequest) async {
    try {
      final response = await DioClient.post(BUY_REQUEST, {
        "criteria": buyRequest.toJson(),
      });
      if (response.statusCode == 200) {
        return (BuyRequestStatus.success, 'Thành công');
      } else if (response.statusCode == 400) {
        return (BuyRequestStatus.error, 'Thất bại');
      } else {
        return (BuyRequestStatus.error, 'Thất bại');
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      print('Response status code: ${e.response?.statusCode}');

      // Print the error response for debugging
      if (e.response != null &&
          e.response?.statusCode == 400 &&
          e.response!.data is Map<String, dynamic>) {
        final errorResponse = e.response!.data;
        final msgsErr = errorResponse['message'].toString();
        return (BuyRequestStatus.error, msgsErr);
      }
      return (BuyRequestStatus.error, 'Thất bại');
    } catch (e) {
      print('Error: $e');
      return (BuyRequestStatus.error, 'Thất bại');
    }
  }
}
