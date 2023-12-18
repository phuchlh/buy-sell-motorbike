import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/user/user_cubit.dart';
import 'package:buy_sell_motorbike/src/common/utils.dart';
import 'dart:developer' as developer;

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final oldPassTextController = TextEditingController();
  final newPassTextController = TextEditingController();
  final reTypeNewPassTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu'),
      ),
      body: FractionallySizedBox(
        heightFactor: 0.8,
        widthFactor: 1,
        child: Center(
          heightFactor: 1,
          widthFactor: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text('Đổi mật khẩu',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800))),
                  const Divider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              obscureText: true,
                              controller: oldPassTextController,
                              validator: (value) =>
                                  value == null || value.isEmpty ? "Vui lòng nhập mật khẩu" : null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Mật khẩu cũ',
                                prefixIcon: Icon(Icons.key_sharp),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: newPassTextController,
                              obscureText: true,
                              validator: (value) =>
                                  value == null || value.isEmpty ? "Vui lòng nhập mật khẩu" : null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Mật khẩu mới',
                                prefixIcon: Icon(Icons.key_sharp),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: reTypeNewPassTextController,
                              obscureText: true,
                              validator: (value) => value == null || value.isEmpty
                                  ? "Vui lòng nhập mật khẩu"
                                  : reTypeNewPassTextController.text != newPassTextController.text
                                      ? "Mật khẩu không khớp"
                                      : null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Nhập lại mật khẩu',
                                prefixIcon: Icon(Icons.key_sharp),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                            ),
                            SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  child: const Text('Đổi mật khẩu'),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      String oldPass = oldPassTextController.text;
                                      String newPass = newPassTextController.text;
                                      String reTypeNewPass = reTypeNewPassTextController.text;
                                      developer.log(
                                          'oldPass: $oldPass, newPass: $newPass, reTypeNewPass: $reTypeNewPass');
                                      await context
                                          .read<UserCubit>()
                                          .changePassword(oldPass, newPass, reTypeNewPass);
                                    }
                                  },
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
