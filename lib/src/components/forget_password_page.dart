import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cubit/user/user_cubit.dart';
import '../common/constants.dart';
import '../common/utils.dart';
import 'otp_validation_page.dart';
import 'package:pinput/pinput.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: FractionallySizedBox(
        heightFactor: 0.75,
        widthFactor: 1,
        child: Center(
            heightFactor: 1,
            widthFactor: 1,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text('Quên Mật Khẩu',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w800))),
                      const Divider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                                'Xin hãy nhập lại email đăng ký tài khoản của bạn'),
                          ),
                          Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: _formKey,
                            child: TextFormField(
                              controller: emailTextController,
                              validator: (value) =>
                                  EmailValidator.validate(value ?? "")
                                      ? null
                                      : "Vui lòng nhập email",
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.mail_outline)),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => _onPressedHandler(context),
                              child: const Text('Khôi phục mật khẩu'),
                            ),
                          )),
                    ]))),
      ),
    );
  }

  dynamic _appbar(BuildContext context) => AppBar(
        title: const Text(''),
        backgroundColor: DesignConstants.primaryColor,
      );

  Future<dynamic> _onPressedHandler(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final checkFlagSuccess = await context
          .read<UserCubit>()
          .forgotPassword(emailTextController.text);
      print('email ${emailTextController.text}');
      if (checkFlagSuccess == UserStatus.success) {
        Navigator.pop(context);
      }
    }
  }
}
