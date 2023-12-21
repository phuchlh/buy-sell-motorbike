import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/user/user_cubit.dart';
import 'package:buy_sell_motorbike/src/common/configurations.dart';
import 'package:buy_sell_motorbike/src/common/dio_client.dart';
import 'package:buy_sell_motorbike/src/common/remote_path_configs.dart';
import 'package:buy_sell_motorbike/src/controller/result.dart';
import 'package:buy_sell_motorbike/src/model/response/login_custom_dto.dart';
import 'package:buy_sell_motorbike/src/model/response/response_user.dart';

class AuthenticationController {
  final DioClient _dioClient = DioClient();

  static Future<ApiResponse<LoginCustomerDTO?, Exception>> login(
      String loginIdentity, String password) async {
    try {
      Response res = await DioClient.post(
        RemotePathEndPoints.login,
        {
          "loginIdentity": loginIdentity,
          "password": password,
        },
      );

      print('called res?.statusCode ${res.statusCode}');
      // if (res.statusCode == 200) {
      //   final userData = res.data;
      //   var roleid =userData.roleId.toString();
      //   print('called res?.statusCode ${res.data.roleId}');
      //   if (roleid == 5) {
      //     var userData = LoginCustomerDTO.fromJson(res.data);
      //     await SharedInstances.secureWrite('userData', res.data);
      //     await SharedInstances.secureWrite('userID', userData.id);
      //     await SharedInstances.secureWrite('customerID', userData.customerDto?.id);
      //     print('user data: ' + roleid);
      //     EasyLoading.showSuccess('Đăng nhập thành công');
      //     return Success(userData);
      //   } else {
      //     EasyLoading.showSuccess('Tài khoản admin/showroom không thể đăng nhập trên mobile app');
      //     return Failure(Exception(res.data.message));
      //   }
      // } else if (res.statusCode == 404) {
      //   EasyLoading.showError(res.data.message);
      //   EasyLoading.dismiss();
      //   return Failure(Exception(res.data.message));
      // } else {
      //   return Failure(Exception(res.data.message));
      // }

      switch (res.statusCode) {
        case 200:
          var userData = LoginCustomerDTO.fromJson(res.data);
          await SharedInstances.secureWrite('userData', res.data);
          await SharedInstances.secureWrite('userID', userData.id);
          await SharedInstances.secureWrite('customerID', userData.customerDto?.id);
          print('user data: ' + userData.roleId.toString());
          EasyLoading.showSuccess('Đăng nhập thành công');
          return Success(userData);
        case 404:
          EasyLoading.showError(res.data.message);
          EasyLoading.dismiss();
          return Failure(Exception(res.data.message));
        default:
          return Failure(Exception(res.data.message));
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      print('Response status code: ${e.response?.statusCode}');

      // Print the error response for debugging
      if (e.response != null &&
          e.response?.statusCode == 404 &&
          e.response!.data is Map<String, dynamic>) {
        final errorResponse = e.response!.data;
        final msgsErr = errorResponse['message'];
        EasyLoading.showError(msgsErr);

        return Failure(Exception(msgsErr));
      } else if (e.response?.statusCode == 502) {
        EasyLoading.showError('Server đang bận, vui lòng thử lại sau');

        return Failure(Exception(e.message));
      }

      return Failure(Exception(e.message));
    } catch (error) {
      EasyLoading.showError('Có lỗi xảy ra, vui lòng kiểm tra lại tên đăng nhập và mật khẩu');
      EasyLoading.dismiss();
      return Failure(Exception('Error occurred: $error'));
    }
  }

  static Future<bool> isLoggedUser() async {
    bool isLoggedUser = await SharedInstances.secureContainsKey('userData');
    print('isLoggedUser: ' + await isLoggedUser.toString());
    return isLoggedUser;
  }

  static Future<UserResponse> getUserByUserId(String id) async {
    Response? res = await DioClient.get("/users/$id");
    return UserResponse.fromJson(res?.data);
  }

  // static Future<bool?> deleteUser(String id) async {
  //   Response? res = await DioClient.delete("/users/$id");
  //   return res?.data;
  // }
}
