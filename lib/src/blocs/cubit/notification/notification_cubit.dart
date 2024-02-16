import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logger.dart';
import '../../../common/configurations.dart';
import '../../../components/in_app_noti.dart';
import '../../../model/response/notification_dto_response.dart';

import 'package:equatable/equatable.dart';
import '../../../resources/remote/notification_services.dart';
part "notification_state.dart";

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState());

  Future<void> getNotifications() async {
    try {
      final customerID = await SharedInstances.secureRead('customerID');

      emit(state.copyWith(
        status: NotificationStatus.loading,
      ));
      final notifications =
          await NotificationServices().getNotifications(customerID!);
      // map unseen
      int unSeen = 0;
      notifications?.forEach((element) {
        if (element.isSeen == false) {
          unSeen++;
        }
      });
      emit(state.copyWith(
        unSeen: unSeen,
        status: NotificationStatus.loaded,
        notifications: notifications,
        count: notifications?.length,
      ));
    } on DioError catch (e) {
      emit(state.copyWith(
          status: NotificationStatus.error, msg: e.response!.statusMessage!));
    }
  }

  Future<NotificationStatus> updateStatusNotification(int id) async {
    try {
      final status = await NotificationServices().updateStatusNotification(id);
      if (status == NotificationStatus.loaded) {
        getNotifications();
      }
      return status;
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<NotificationStatus> getPopupNotification() async {
    try {
      final customerID = await SharedInstances.secureRead('customerID');

      final notification =
          await NotificationServices().getPopupNotification(customerID!);
      if (notification != null) {
        emit(state.copyWith(popup: notification));
        await getNotifications();
        return NotificationStatus.loaded;
      } else {
        return NotificationStatus.noPopup;
      }
    } on DioError catch (e) {
      return NotificationStatus.error;
    }
  }
}
