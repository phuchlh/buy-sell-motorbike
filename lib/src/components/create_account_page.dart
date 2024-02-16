import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import '../../logger.dart';
import '../blocs/cubit/user/user_cubit.dart';
import '../common/constants.dart';
import '../controller/authentication_controller.dart';

import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/request/criteria_user_request.dart';
import '../model/request/customer_dto_request.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  String selectedYear = '';
  String convertUnix = '';
  final _formKey = GlobalKey<FormState>();
  final _formPassword = GlobalKey<FormState>();
  var fullNameTextController = TextEditingController();
  var userNameTextController = TextEditingController();
  var addressTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var phoneTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var passwordRetypeTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      resizeToAvoidBottomInset: false,
      body: Center(
        heightFactor: 1,
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text('Tạo tài khoản',
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w800))),
              const Divider(),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      onChanged: (value) => context
                          .read<UserCubit>()
                          .onChangeFullnameRegister(value),
                      controller: fullNameTextController,
                      validator: (value) => (value == null || value.isEmpty)
                          ? "Họ và tên không được để trống"
                          : null,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Họ và Tên',
                          prefixIcon: Icon(Icons.person_outline_outlined)),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: userNameTextController,
                      onChanged: (value) => context
                          .read<UserCubit>()
                          .onChangeUsernameRegister(value),
                      keyboardType: TextInputType.text,
                      validator: (value) => (value == null ||
                              value.isEmpty ||
                              value.length > 20 ||
                              value.length < 2)
                          ? "Vui lòng nhập tên đăng nhập"
                          : null,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Tên đăng nhập',
                        prefixIcon: Icon(Icons.account_circle_outlined),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => context
                          .read<UserCubit>()
                          .onChangeEmailRegister(value),
                      validator: (value) => EmailValidator.validate(value ?? "")
                          ? null
                          : "Vui lòng nhập đúng định dạng email",
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.mail_outline),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: phoneTextController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'[.-]')),
                      ],
                      onChanged: (value) => context
                          .read<UserCubit>()
                          .onChangePhoneRegister(value),
                      validator: (value) => (value == null ||
                              value.isEmpty ||
                              value.length > 10 ||
                              value.length < 10)
                          ? "Vui lòng nhập đúng số điện thoại (10 số)"
                          : null,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Số điện thoại',
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) => context
                          .read<UserCubit>()
                          .onChangeAddressRegister(value),
                      controller: addressTextController,
                      validator: (value) =>
                          (value == null || value.isEmpty || value.length < 2)
                              ? "Vui lòng nhập địa chỉ"
                              : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Địa chỉ',
                        prefixIcon: Icon(Icons.location_city),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        // _showBottomSheetPicker();
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(DateTime.now().year - 17),
                          firstDate: DateTime(DateTime.now().year - 80),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          convertUnix =
                              picked.millisecondsSinceEpoch.toString();
                          context.read<UserCubit>().onChangeDBO(convertUnix);
                          setState(() {
                            selectedYear =
                                DateFormat('dd/MM/yyyy').format(picked);
                          });
                        }
                      },
                      child: Container(
                        width: 312,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today_outlined),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                selectedYear.isNotEmpty
                                    ? selectedYear
                                    : 'Ngày tháng năm sinh',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios_outlined),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Form(
                key: _formPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      controller: passwordTextController,
                      obscureText: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Mật khẩu không được để trống"
                          : value.length < 8
                              ? 'Mật khẩu phải có ít nhất 8 ký tự'
                              : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mật khẩu',
                        prefixIcon: Icon(Icons.key_rounded),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordRetypeTextController,
                      obscureText: true,
                      validator: (value) => (value == null ||
                              value.isEmpty ||
                              value != passwordTextController.text)
                          ? "Mật khẩu không khớp"
                          : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nhập lại mật khẩu',
                        prefixIcon: Icon(Icons.key_rounded),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      child: const Text('Tạo tài khoản'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            _formPassword.currentState!.validate()) {
                          String fullname = context
                                  .read<UserCubit>()
                                  .state
                                  .fullNameRegister ??
                              "";
                          String username = context
                                  .read<UserCubit>()
                                  .state
                                  .usernameRegister ??
                              "";
                          String email =
                              context.read<UserCubit>().state.emailRegister ??
                                  "";
                          String phone =
                              context.read<UserCubit>().state.phoneRegister ??
                                  "";
                          String address =
                              context.read<UserCubit>().state.addressRegister ??
                                  "";
                          // String password = context.read<UserCubit>().state.passwordRegister ?? "";
                          // String fullname = fullNameTextController.text;
                          // String username = userNameTextController.text;
                          // String email = emailTextController.text;
                          // String phone = phoneTextController.text;
                          // String address = addressTextController.text;
                          String password = passwordTextController.text;
                          final criteria = CriteriaPostUser(
                              userName: username,
                              phone: phone,
                              email: email,
                              password: password);
                          final dto = CustomerDTORequest(
                            fullName: fullname,
                            dob: convertUnix,
                            address: address,
                            avatarUrl: "string",
                          );
                          Logger.log(criteria.toJson().toString());
                          Logger.log(dto.toJson().toString());
                          final checkStatus = await context
                              .read<UserCubit>()
                              .register(criteria, dto);
                          if (checkStatus == UserStatus.success) {
                            EasyLoading.showSuccess('Tạo tài khoản thành công');
                            Navigator.pop(context);
                          }
                        }
                      },
                    )),
              ),
              const SizedBox(
                height: 220,
              )
            ],
          ),
        ),
      ),
    );
  }

  dynamic _appbar(BuildContext context) => AppBar(
        title: const Text(''),
        backgroundColor: DesignConstants.primaryColor,
      );

  void _showBottomSheetPicker() async {
    // show data
    // put list data here
    DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn năm sản xuất'),
          content: SizedBox(
            height: 300,
            width: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 20),
              lastDate: DateTime.now(),
              selectedDate: DateTime.now(),
              onChanged: (DateTime dateTime) {
                String convertUnix = dateTime.millisecondsSinceEpoch.toString();
                context.read<UserCubit>().onChangeDBO(convertUnix);
                Navigator.of(context).pop(dateTime);
              },
            ),
          ),
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedYear = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _pickDOB() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 17),
      firstDate: DateTime(DateTime.now().year - 80),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      String convertUnix = picked.millisecondsSinceEpoch.toString();
      // context.read<UserCubit>().onChangeDBO(convertUnix);
      setState(() {
        selectedYear = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }
}
