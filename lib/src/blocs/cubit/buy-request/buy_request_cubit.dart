import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../logger.dart';
import '../post/post_cubit.dart';
import '../../../common/configurations.dart';
import '../../../model/request/buy_request_req.dart';
import '../../../resources/remote/buy_request_services.dart';

part 'buy_request_state.dart';

class BuyRequestCubit extends Cubit<BuyRequestState> {
  BuyRequestCubit()
      : super(const BuyRequestState(status: BuyRequestStatus.initial, err: ""));

  Future<void> createBuyRequest(
      int postID, int motorbikeID, int showroomID) async {
    try {
      emit(state.copyWith(status: BuyRequestStatus.loading));
      final customerID = await SharedInstances.secureRead('customerID');
      if (customerID == null) {
        emit(state.copyWith(status: BuyRequestStatus.notLoginYet));
      } else {
        final buyRequest = BuyRequest(
            customerId: int.parse(customerID),
            showroomId: showroomID,
            motorbikeId: motorbikeID,
            postId: postID);

        final (status, msg) =
            await BuyRequestServices().createBuyRequest(buyRequest);
        if (status == BuyRequestStatus.success) {
          emit(state.copyWith(status: BuyRequestStatus.success));
        } else if (status == BuyRequestStatus.error) {
          emit(state.copyWith(status: BuyRequestStatus.error));
          EasyLoading.showError(msg);
        } else {
          emit(state.copyWith(status: BuyRequestStatus.error));
        }
      }
    } on DioError catch (e) {
      // Handle DioError
      Logger.log('DioError: ${e.message}');
      EasyLoading.showError('Thất bại');
      emit(state.copyWith(status: BuyRequestStatus.error));
    } catch (e) {
      // Handle other types of errors
      Logger.log('DioError: ${e}');
      EasyLoading.showError('Thất bại, vui lòng kiểm tra lại thông tin');
      emit(state.copyWith(status: BuyRequestStatus.error));
    }
  }
}
