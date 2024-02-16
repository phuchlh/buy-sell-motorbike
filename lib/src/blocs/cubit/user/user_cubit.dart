import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../logger.dart';
import '../../../common/configurations.dart';
import '../../../model/request/change_password_req.dart';
import '../../../model/request/criteria_user_request.dart';
import '../../../model/request/customer_dto_request.dart';
import '../../../model/request/update_user_information_criteria.dart';
import '../../../model/response/userdto_response.dart';
import '../../../resources/remote/user_services.dart';

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
          emit(state.copyWith(
              status: UserStatus.changePFPSuccess, avatarUrl: url));
          return UserStatus.success;
        } else {
          throw Exception('Failed to update profile pic');
        }
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<UserStatus> register(
      CriteriaPostUser criteria, CustomerDTORequest dto) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));
      EasyLoading.show(status: 'Đang đăng ký tài khoản');
      final status = await UserServices().register(criteria, dto);
      if (status == UserStatus.success) {
        EasyLoading.showSuccess('Đăng ký thành công');
        emit(state.copyWith(status: UserStatus.success));
        return UserStatus.success;
      } else if (status == UserStatus.phoneExist) {
        // Handle the specific case where the phone already exists
        EasyLoading.showError(
            'Số điện thoại đã tồn tại. Vui lòng chọn số điện thoại khác.');
        emit(state.copyWith(status: UserStatus.phoneExist));

        return UserStatus.phoneExist;
      } else if (status == UserStatus.emailExist) {
        // Handle the specific case where the phone already exists
        EasyLoading.showError('Email đã tồn tại. Vui lòng chọn email khác.');
        emit(state.copyWith(status: UserStatus.emailExist));
        return UserStatus.emailExist;
      } else if (status == UserStatus.userNameExist) {
        // Handle the specific case where the phone already exists
        EasyLoading.showError(
            'Tên đăng nhập đã tồn tại. Vui lòng chọn tên đăng nhập khác.');
        emit(state.copyWith(status: UserStatus.userNameExist));
        return UserStatus.userNameExist;
      } else {
        throw Exception('Failed to update profile pic');
      }
    } on DioError catch (e) {
      // Handle DioError
      Logger.log('DioError: ${e.message}');
      EasyLoading.showError('Thất bại');
      emit(state.copyWith(status: UserStatus.errorCreate));
      return UserStatus.errorCreate;
    } catch (e) {
      // Handle other types of errors
      Logger.log('DioError: ${e}');
      EasyLoading.showError('Thất bại, vui lòng kiểm tra lại thông tin');
      emit(state.copyWith(status: UserStatus.errorCreate));
      return UserStatus.errorCreate;
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
        throw Exception('Failed to update password');
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

  Future<UserStatus> changePassword(
      String oldPass, String newPass, String reTypeNewPass) async {
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
      EasyLoading.showError(
          'Đổi mật khẩu thất bại,  vui lòng kiểm tra lại mật khẩu cũ');
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

  onChangeFullnameRegister(String fulllnameRegister) {
    emit(state.copyWith(fullNameRegister: fulllnameRegister));
    Logger.log('fullname: ${state.fullNameRegister}');
  }

  onChangeUsernameRegister(String usernameReg) {
    emit(state.copyWith(usernameRegister: usernameReg));
    Logger.log('fullname: ${state.usernameRegister}');
  }

  onChangePhoneRegister(String phoneReg) {
    emit(state.copyWith(phoneRegister: phoneReg));
    Logger.log('phone: ${state.phoneRegister}');
  }

  onChangeEmailRegister(String emailReg) {
    emit(state.copyWith(emailRegister: emailReg));
    Logger.log('email: ${state.emailRegister}');
  }

  onChangeAddressRegister(String addressReg) {
    emit(state.copyWith(addressRegister: addressReg));
    Logger.log('address: ${state.addressRegister}');
  }

  onChangeDobRegister(DateTime dobReg) {
    final parsedDob = dobReg.millisecondsSinceEpoch.toString();
    emit(state.copyWith(dobEditedRegister: parsedDob));
    Logger.log('dob: ${state.dobEditedRegister}');
  }

  onChangePasswordRegister(String passwordReg) {
    emit(state.copyWith(passwordRegister: passwordReg));
    Logger.log('password: ${state.passwordRegister}');
  }

  Future<UserStatus> updateProfile() async {
    try {
      EasyLoading.show(status: 'Đang cập nhật thông tin');
      emit(state.copyWith(status: UserStatus.loading));
      final userID = await SharedInstances.secureRead('userID');
      final customerID = await SharedInstances.secureRead('customerID');
      final pfpUrl = state.user?.customerDto?.avatarUrl ?? '';

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
        avatarUrl: pfpUrl,
      );
      final fullpatch = UpdateUserInforCriteria(
        criteria: criteriaPatch,
        customerDto: inforPatch,
      );
      Logger.log('fullpatch: ${fullpatch.toJson()}');
      final status = await UserServices()
          .updateProfile(int.parse(userID.toString()), fullpatch);
      // if (status == UserStatus.updateInfoSuccess) {
      //   EasyLoading.showSuccess('Cập nhật thông tin thành công');
      //   emit(state.copyWith(status: UserStatus.updateInfoSuccess));
      //   return UserStatus.updateInfoSuccess;
      // } else {
      //   throw Exception('Vui lòng kiểm tra lại thông tin');
      // }
      if (status == UserStatus.updateInfoSuccess) {
        EasyLoading.showSuccess('Cập nhật thông tin thành công');
        emit(state.copyWith(status: UserStatus.updateInfoSuccess));
        return UserStatus.updateInfoSuccess;
      } else if (status == UserStatus.phoneExist) {
        // Handle the specific case where the phone already exists
        EasyLoading.showError(
            'Số điện thoại đã tồn tại. Vui lòng chọn số điện thoại khác.');
        emit(state.copyWith(status: UserStatus.phoneExist));

        return UserStatus.phoneExist;
      } else if (status == UserStatus.emailExist) {
        // Handle the specific case where the phone already exists
        EasyLoading.showError('Email đã tồn tại. Vui lòng chọn email khác.');
        emit(state.copyWith(status: UserStatus.emailExist));
        return UserStatus.emailExist;
      } else {
        throw Exception('Vui lòng kiểm tra lại thông tin');
      }
    } on DioError catch (e) {
      // Handle DioError
      Logger.error('DioError: ${e.message}');
      Logger.error('Response status code: ${e.response?.statusCode}');
      EasyLoading.showError('$e');
      emit(state.copyWith(status: UserStatus.updateInforFail));
      return UserStatus.updateInforFail;
    } catch (e) {
      Logger.error('Error: $e');
      EasyLoading.showError('Vui lòng kiểm tra lại thông tin');
      emit(state.copyWith(status: UserStatus.updateInforFail));
      return UserStatus.updateInforFail;
    }
  }
}
