import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/post/post_cubit.dart';
import 'package:buy_sell_motorbike/src/common/configurations.dart';
import 'package:buy_sell_motorbike/src/model/request/buy_request_req.dart';
import 'package:buy_sell_motorbike/src/resources/remote/buy_request_services.dart';

part 'buy_request_state.dart';

class BuyRequestCubit extends Cubit<BuyRequestState> {
  BuyRequestCubit() : super(const BuyRequestState(status: BuyRequestStatus.initial, err: ""));

  Future<void> createBuyRequest(int postID, int motorbikeID, int showroomID) async {
    try {
      emit(state.copywith(status: BuyRequestStatus.loading));
      final customerID = await SharedInstances.secureRead('customerID');
      if (customerID == null) {
        emit(state.copywith(status: BuyRequestStatus.notLoginYet));
      } else {
        final buyRequest = BuyRequest(
            customerId: int.parse(customerID),
            showroomId: showroomID,
            motorbikeId: motorbikeID,
            postId: postID);

        final status = await BuyRequestServices().createBuyRequest(buyRequest);
        if (status == BuyRequestStatus.success) {
          emit(state.copywith(status: BuyRequestStatus.success));
        } else {
          emit(state.copywith(status: BuyRequestStatus.error));
        }
      }
    } on DioError catch (e) {
      emit(state.copywith(status: BuyRequestStatus.error, err: e.message));
    }
  }
}
