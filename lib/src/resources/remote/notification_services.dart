import 'package:dio/dio.dart';
import '../../../logger.dart';
import '../../blocs/cubit/notification/notification_cubit.dart';
import '../../blocs/cubit/user/user_cubit.dart';
import '../../common/configurations.dart';
import '../../common/dio_client.dart';
import '../../model/response/notification_dto_response.dart';

class NotificationServices {
  final NOTI = "/notifications";
  final CUSTOMER = '/customer';
  final IS_SEEN = "/is-seen";
  final NOT_YET = "/not-yet-announced";

  Future<List<NotificationDTO>?> getNotifications(String customerID) async {
    try {
      final response = await DioClient.get('$NOTI$CUSTOMER/$customerID');
      if (response.statusCode == 200) {
        return response.data
            .map<NotificationDTO>((e) => NotificationDTO.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load notifications');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<NotificationStatus> updateStatusNotification(int id) async {
    try {
      final response = await DioClient.putOneParam('$NOTI/$id$IS_SEEN');
      if (response.statusCode == 200) {
        return NotificationStatus.loaded;
      } else {
        throw Exception('Failed to update status notification');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  //not yet announced
  Future<NotificationDTO?> getPopupNotification(String id) async {
    try {
      final response = await DioClient.get('$NOTI$CUSTOMER/$id$NOT_YET');
      if (response.statusCode == 200) {
        // Parse the response data
        final Map<String, dynamic> responseData = response.data;
        Logger.log('Received notification data: $responseData');
        if (responseData.isNotEmpty) {
          // Data is not empty, process the received data
          final NotificationDTO notification =
              NotificationDTO.fromJson(responseData);
          Logger.log('Received notification data: $notification');
          return notification;
        } else {
          // Data is empty
          Logger.log('Failed');
          return null;
        }
      } else {
        // Handle API error
        Logger.log(
            'API request failed with status code: ${response.statusCode}');
        throw Exception('Failed to load notifications');
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
