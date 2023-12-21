part of 'user_cubit.dart';

enum UserStatus {
  initial,
  loading,
  success,
  error,
  notLoginYet,
  changePFPSuccess,
  errorChangePassword,
  changePasswordSuccess,
  updateInfoSuccess,
  updateInforFail,
  emailExist,
  phoneExist,
  errorCreate,
  userNameExist,
}

class UserState extends Equatable {
  final String? usernameRegister;
  final String? passwordRegister;
  final String? fullNameRegister;
  final String? phoneRegister;
  final String? emailRegister;
  final String? dobEditedRegister;
  final String? addressRegister;
  final String? avatarUrl;
  final String? fullName;
  final String? phone;
  final String? email;
  final String? dobEdited;
  final String? address;
  final UserStatus status;
  final UserDTO? user;
  final String err;
  final String? dob;

  const UserState({
    this.usernameRegister,
    this.passwordRegister,
    this.fullNameRegister,
    this.phoneRegister,
    this.emailRegister,
    this.dobEditedRegister,
    this.addressRegister,
    this.avatarUrl,
    this.dobEdited,
    this.fullName,
    this.phone,
    this.email,
    this.address,
    this.status = UserStatus.initial,
    this.user,
    this.err = "",
    this.dob,
  });

  UserState copyWith({
    String? usernameRegister,
    String? passwordRegister,
    String? fullNameRegister,
    String? phoneRegister,
    String? emailRegister,
    String? dobEditedRegister,
    String? addressRegister,
    String? avatarUrl,
    String? fullName,
    String? phone,
    String? email,
    String? address,
    String? dobEdited,
    UserStatus? status,
    UserDTO? user,
    String? err,
    String? dob,
  }) {
    return UserState(
      usernameRegister: usernameRegister ?? this.usernameRegister,
      passwordRegister: passwordRegister ?? this.passwordRegister,
      fullNameRegister: fullNameRegister ?? this.fullNameRegister,
      phoneRegister: phoneRegister ?? this.phoneRegister,
      emailRegister: emailRegister ?? this.emailRegister,
      dobEditedRegister: dobEditedRegister ?? this.dobEditedRegister,
      addressRegister: addressRegister ?? this.addressRegister,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      dobEdited: dobEdited ?? this.dobEdited,
      status: status ?? this.status,
      user: user ?? this.user,
      err: err ?? this.err,
      dob: dob ?? this.dob,
    );
  }

  @override
  List<Object?> get props => [
        usernameRegister,
        passwordRegister,
        fullNameRegister,
        phoneRegister,
        emailRegister,
        dobEditedRegister,
        addressRegister,
        avatarUrl,
        fullName,
        phone,
        email,
        address,
        dobEdited,
        status,
        user,
        err,
        dob,
      ];
}
