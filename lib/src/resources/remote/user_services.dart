import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:buy_sell_motorbike/logger.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/user/user_cubit.dart';
import 'package:buy_sell_motorbike/src/common/dio_client.dart';
import 'package:buy_sell_motorbike/src/model/request/change_password_req.dart';
import 'package:buy_sell_motorbike/src/model/request/criteria_user_request.dart';
import 'package:buy_sell_motorbike/src/model/request/customer_dto_request.dart';
import 'package:buy_sell_motorbike/src/model/request/update_user_information_criteria.dart';
import 'package:buy_sell_motorbike/src/model/response/userdto_response.dart';

import 'dart:developer' as developer;

String USER = "/users";
String CUSTOMER = "/customer";
String CUSTOMERS_AVT = "/customers";

class UserServices {
  Future<UserDTO> getUser(String id) async {
    try {
      final response = await DioClient.get(USER + "/$id");
      if (response.statusCode == 200) {
        return UserDTO.fromJson(response.data);
      } else {
        throw Exception('Failed to load user');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<UserStatus> updateProfilePic(String id, String url) async {
    try {
      final json = {
        "id": id,
        "avatarUrl": url,
      };
      final params = {
        "avatarUrl": url,
      };
      developer.log(json.toString());
      final response =
          await DioClient.putOneParam("$CUSTOMERS_AVT/$id/update-avatar", params: params);
      // await DioClient.putOneParam("$CUSTOMERS_AVT/$id/update-avatar?avatarUrl=$url");
      if (response.statusCode == 200) {
        return UserStatus.changePFPSuccess;
      } else {
        throw Exception('Failed to update profile pic');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<UserStatus> register(CriteriaPostUser criteria, CustomerDTORequest dto) async {
    try {
      final jsonCreate = {"criteria": criteria.toJson(), "customerDto": dto.toJson()};
      developer.log(jsonCreate.toString());
      final response = await DioClient.post(USER + CUSTOMER, jsonCreate);
      if (response.statusCode == 200) {
        return UserStatus.success;
      } else {
        throw Exception('Failed to update profile');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<UserStatus> resetPassword(String email) async {
    try {
      final response = await DioClient.putOneParam(USER + "/reset-password?email=$email");
      if (response.statusCode == 200) {
        return UserStatus.success;
      } else {
        throw Exception('Failed to update profile');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<UserStatus> changePassword(ChangePasswordRequest changePassword) async {
    try {
      Response response = await DioClient.put(USER + "/change-password", changePassword.toJson());
      Logger.log('Response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        return UserStatus.changePasswordSuccess;
      } else {
        return UserStatus.errorChangePassword;
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      print('Response status code: ${e.response?.statusCode}');
      return UserStatus.errorChangePassword;
    } catch (e) {
      print('Error: $e');
      return UserStatus.errorChangePassword;
    }
  }

  Future<UserStatus> updateProfile(int id, UpdateUserInforCriteria updatePatch) async {
    try {
      Response response = await DioClient.put("$USER/$id$CUSTOMER", updatePatch.toJson());
      Logger.log('Response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        return UserStatus.updateInfoSuccess;
      } else {
        throw Exception('Failed to update profile');
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      print('Response status code: ${e.response?.statusCode}');
      return UserStatus.updateInforFail;
    } catch (e) {
      print('Error: $e');
      return UserStatus.updateInforFail;
    }
  }
}
