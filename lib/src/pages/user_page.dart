import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/user/user_cubit.dart';
import 'package:buy_sell_motorbike/src/common/utils.dart';
import 'package:buy_sell_motorbike/src/components/create_account_page.dart';
import 'package:buy_sell_motorbike/src/components/forget_password_page.dart';
import 'package:buy_sell_motorbike/src/model/response/response_user.dart';
import 'package:buy_sell_motorbike/src/controller/authentication_controller.dart';
import 'package:buy_sell_motorbike/src/state/navigation_items.dart';

class UserPage extends ConsumerStatefulWidget {
  const UserPage({super.key});

  @override
  ConsumerState<UserPage> createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  bool saveSession = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController loginIdentityTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(40),
              child: ListView(itemExtent: 80, shrinkWrap: true, children: [
                const Text('Vui lòng đăng nhập để trải nghiệm dịch vụ'),
                _loginIdentityInput(),
                _passwordInput(),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _rememberLoginSession(),
                      TextButton(
                        onPressed: () => Navigator.push(
                            context, MaterialPageRoute(builder: (context) => ForgetPasswordPage())),
                        autofocus: false,
                        clipBehavior: Clip.none,
                        child: const Text('Quên mật khẩu'),
                      )
                    ]),
                const Divider(),
                ElevatedButton.icon(
                  onPressed: () => _onPressedLoginHandler(context, ref),
                  icon: const Icon(Icons.login),
                  label: const Text('Đăng nhập'),
                ),
                Column(
                  children: [
                    const Expanded(child: Text('Chưa có tài khoản?')),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed:
                            pushNavigatorOnPressed(context, (_) => const CreateAccountPage()),
                        icon: const Icon(Icons.person_add),
                        label: const Text('Tạo tài khoản'),
                      ),
                    )
                  ],
                )
              ]),
            )));
  }

  dynamic _onPressedLoginHandler(BuildContext context, WidgetRef ref) {
    UserResponse? user;

    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Đang xử lý...');
      AuthenticationController.login(loginIdentityTextController.text, passwordTextController.text)
          .then((value) async {
        await context.read<UserCubit>().getUser();
        final botnavOptions = ref.watch(botnavOptionsProvider);
        final navigationState = ref.watch(navigationStateProvider);
        await botnavOptions.toggleMode();
        if (NavigationItems.isLogged == true) {
          navigationState.updateSelectedIndex(0);
        }
        // showCupertinoDialog(
        //     context: context,
        //     builder: (BuildContext context) => AlertDialog(
        //           title: const Text('Response'),
        //           content: SingleChildScrollView(
        //             child: ListBody(
        //               children: <Widget>[
        //                 Text(value.toString()),
        //               ],
        //             ),
        //           ),
        //           actions: <Widget>[
        //             TextButton(
        //                 child: const Text('Quay về'),
        //                 onPressed: () {
        //                   Navigator.of(context).pop();
        //                   ref.read(botnavOptionsProvider.notifier).toggleMode();
        //                   Navigator.pushReplacement(
        //                     context,
        //                     MaterialPageRoute(builder: (context) => HomePage()),
        //                   );
        //                 }),
        //           ],
        //         ));
      }).then((value) {
        ref.read(botnavOptionsProvider.notifier).toggleMode();
        print('after login: ' + AuthenticationController.isLoggedUser().toString());
      });

      // if (user != null) {
      //   ScaffoldMessenger.of(context).showSnackBar(W
      //     const SnackBar(content: Text('Processing Data')),
      //   );
    }

    print(user);
  }

  // if (user == null) {}

  // Navigator.push(context, MaterialPageRoute(builder: (context) => OtpValidationPage()));

  _rememberLoginSession() => Row(
        children: [
          Checkbox(
            value: saveSession,
            onChanged: (bool? value) {
              setState(() {
                saveSession = value!;
              });
            },
          ),
          const Text('Ghi nhớ đăng nhập'),
        ],
      );

  _loginIdentityInput() => TextFormField(
        controller: loginIdentityTextController,
        validator: (value) => (value == null || value.isEmpty) ? "Xin điền vào thông tin" : null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Thông tin đăng nhập',
          hintText: 'Tên đăng nhập',
          prefixIcon: Icon(Icons.person),
        ),
      );

  _passwordInput() => TextFormField(
        controller: passwordTextController,
        validator: (value) => (value == null || value.isEmpty || value.length < 6)
            ? "Xin điền vào mật khẩu hợp lệ"
            : null,
        obscureText: true,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: 'Mật khẩu', prefixIcon: Icon(Icons.key)),
      );
}
