import 'package:flutter/material.dart';
import '../common/utils.dart';
import 'reset_password_page.dart';
import 'package:pinput/pinput.dart';

class OtpValidationPage extends StatefulWidget {
  const OtpValidationPage({super.key});

  @override
  _OtpValidationState createState() => _OtpValidationState();
}

class _OtpValidationState extends State<OtpValidationPage> {
  final _formKey = GlobalKey<FormState>();

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
                          child: Text('Nhập OTP',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w800))),
                      const Divider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                                'Xin hãy nhập mã OTP gồm 4 chữ số tại email'),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text('test_user@gmail.com'),
                          ),
                          Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: _formKey,
                              child: Pinput(
                                animationCurve: Curves.bounceOut,
                                autofocus: true,
                                onCompleted: (input) => {
                                  pushNavigator(
                                      context, (_) => ResetPasswordPage())
                                },
                              )),
                        ],
                      ),
                    ]))),
      ),
    );
  }

  dynamic _appbar(BuildContext context) => AppBar(
        title: const Text('OTP Validation'),
      );
}
