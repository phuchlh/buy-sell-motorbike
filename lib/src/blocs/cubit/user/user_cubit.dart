import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:buy_sell_motorbike/logger.dart';
import 'package:buy_sell_motorbike/src/common/configurations.dart';
import 'package:buy_sell_motorbike/src/model/request/change_password_req.dart';
import 'package:buy_sell_motorbike/src/model/request/criteria_user_request.dart';
import 'package:buy_sell_motorbike/src/model/request/customer_dto_request.dart';
import 'package:buy_sell_motorbike/src/model/request/update_user_information_criteria.dart';
import 'package:buy_sell_motorbike/src/model/response/userdto_response.dart';
import 'package:buy_sell_motorbike/src/resources/remote/user_services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());

  Future<UserDTO> getUser() async {
    try {
      emit(state.copyWith(status: UserStatus.loading));
      final userID = await SharedInstances.secureRead('userID');
      if (userID == null) {
        emit(state.copyWith(status: UserStatus.notLoginYet));
        return UserDTO();
      } else {
        final user = await UserServices().getUser(userID);
        if (user != null) {
          emit(state.copyWith(
            status: UserStatus.success,
            user: user,
            dobEdited: user.customerDto?.dob ?? '',
            fullName: user.customerDto?.fullName ?? '',
            phone: user.phone ?? '',
            email: user.email ?? '',
            address: user.customerDto?.address ?? '',
          ));
          return user;
        } else {
          throw Exception('Failed to load user');
        }
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<UserStatus> updateProfilePic(String url) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));
      final customerID = await SharedInstances.secureRead('customerID');
      if (customerID == null) {
        emit(state.copyWith(status: UserStatus.notLoginYet));
        return UserStatus.notLoginYet;
      } else {
        final status = await UserServices().updateProfilePic(customerID, url);
        if (status == UserStatus.changePFPSuccess) {
          emit(state.copyWith(status: UserStatus.changePFPSuccess, avatarUrl: url));
          return UserStatus.success;
        } else {
          throw Exception('Failed to update profile pic');
        }
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<UserStatus> register(CriteriaPostUser criteria, CustomerDTORequest dto) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));
      EasyLoading.show(status: 'Đang đăng ký tài khoản');
      final status = await UserServices().register(criteria, dto);
      if (status == UserStatus.success) {
        EasyLoading.showSuccess('Đăng ký thành công');
        emit(state.copyWith(status: UserStatus.success));
        return UserStatus.success;
      } else {
        throw Exception('Failed to update profile pic');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  onChangeDBO(String dob) {
    print('unix $dob');
    emit(state.copyWith(dob: dob));
  }

  Future<UserStatus> forgotPassword(String email) async {
    try {
      EasyLoading.show(status: 'Đang kiểm tra email');
      emit(state.copyWith(status: UserStatus.loading));
      final status = await UserServices().resetPassword(email);
      if (status == UserStatus.success) {
        EasyLoading.showSuccess('Vui lòng kiểm tra email để lấy lại mật khẩu');
        emit(state.copyWith(status: UserStatus.success));
        return UserStatus.success;
      } else {
        throw Exception('Failed to update profile pic');
      }
    } on DioError catch (e) {
      // Handle DioError
      Logger.log('DioError: ${e.message}');
      EasyLoading.showError('Thất bại, vui lòng kiểm tra lại email');
      emit(state.copyWith(status: UserStatus.errorChangePassword));
      return UserStatus.errorChangePassword;
    } catch (e) {
      // Handle other types of errors
      Logger.log('DioError: ${e}');
      EasyLoading.showError('Thất bại, vui lòng kiểm tra lại email');
      emit(state.copyWith(status: UserStatus.errorChangePassword));
      return UserStatus.errorChangePassword;
    }
  }

  Future<UserStatus> changePassword(String oldPass, String newPass, String reTypeNewPass) async {
    try {
      EasyLoading.show(status: 'Đang đổi mật khẩu');

      final userID = await SharedInstances.secureRead('userID');
      final req = ChangePasswordRequest(
        criteria: CriteriaChangePassword(id: int.parse(userID.toString())),
        oldPassword: oldPass,
        newPassword: newPass,
        confirmNewPassword: reTypeNewPass,
      );

      final status = await UserServices().changePassword(req);

      EasyLoading.dismiss();

      if (status == UserStatus.changePasswordSuccess) {
        EasyLoading.showSuccess('Đổi mật khẩu thành công');
        emit(state.copyWith(status: UserStatus.success));

        return UserStatus.success;
      } else {
        throw Exception('Thất bại, vui lòng kiểm tra lại mật khẩu cũ');
      }
    } on DioError catch (e) {
      // Handle DioError
      Logger.error('DioError: ${e.message}');
      Logger.error('Response status code: ${e.response?.statusCode}');
      EasyLoading.showError('Đổi mật khẩu thất bại,  vui lòng kiểm tra lại mật khẩu cũ');
      emit(state.copyWith(status: UserStatus.errorChangePassword));
      return UserStatus.errorChangePassword;
    } catch (e) {
      // Handle other types of errors
      Logger.error('Error: $e');
      EasyLoading.showError('Đổi mật khẩu thất bại');
      emit(state.copyWith(status: UserStatus.errorChangePassword));
      return UserStatus.errorChangePassword;
    }
  }

  onChangeFullname(String fulllname) {
    emit(state.copyWith(fullName: fulllname));
    Logger.log('fullname: ${state.fullName}');
  }

  onChangePhone(String phone) {
    emit(state.copyWith(phone: phone));
    Logger.log('phone: ${state.phone}');
  }

  onChangeEmail(String email) {
    emit(state.copyWith(email: email));
    Logger.log('email: ${state.email}');
  }

  onChangeAddress(String address) {
    emit(state.copyWith(address: address));
    Logger.log('address: ${state.address}');
  }

  onChangeDob(DateTime dob) {
    final parsedDob = dob.millisecondsSinceEpoch.toString();
    emit(state.copyWith(dobEdited: parsedDob));
    Logger.log('dob: ${state.dobEdited}');
  }

  Future<UserStatus> updateProfile() async {
    try {
      emit(state.copyWith(status: UserStatus.loading));
      final userID = await SharedInstances.secureRead('userID');
      final customerID = await SharedInstances.secureRead('customerID');

      final criteriaPatch = CriteriaUpdateInfor(
        id: int.parse(userID.toString()),
        phone: state.phone,
        email: state.email,
      );
      final inforPatch = CustomerDtoUpdateInfo(
        id: int.parse(customerID.toString()),
        fullName: state.fullName,
        dob: state.dobEdited,
        address: state.address,
        userId: int.parse(userID.toString()),
      );
      final fullpatch = UpdateUserInforCriteria(
        criteria: criteriaPatch,
        customerDto: inforPatch,
      );
      final status = await UserServices().updateProfile(int.parse(userID.toString()), fullpatch);
      if (status == UserStatus.updateInfoSuccess) {
        EasyLoading.showSuccess('Cập nhật thông tin thành công');
        emit(state.copyWith(status: UserStatus.updateInfoSuccess));
        return UserStatus.updateInfoSuccess;
      } else {
        throw Exception('Failed to update profile');
      }
    } on DioError catch (e) {
      // Handle DioError
      Logger.error('DioError: ${e.message}');
      Logger.error('Response status code: ${e.response?.statusCode}');
      EasyLoading.showError('Cập nhật thông tin thất bại');
      emit(state.copyWith(status: UserStatus.updateInforFail));
      return UserStatus.updateInforFail;
    } catch (e) {
      // Handle other types of errors
      Logger.error('Error: $e');
      EasyLoading.showError('Cập nhật thông tin thất bại');
      emit(state.copyWith(status: UserStatus.updateInforFail));
      return UserStatus.updateInforFail;
    }
  }
}
