import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import '../../logger.dart';
import '../blocs/cubit/user/user_cubit.dart';
import '../common/constants.dart';

class EditInformationPage extends StatefulWidget {
  const EditInformationPage({super.key});

  @override
  State<EditInformationPage> createState() => _EditInformationPageState();
}

class _EditInformationPageState extends State<EditInformationPage> {
  final _formKey = GlobalKey<FormState>();

  // final reTypeNewPassTextController = TextEditingController();
  Future<void> _loadData() async {
    await context.read<UserCubit>().getUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa thông tin'),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        // height: 50,
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String fullname = state.fullName ?? '';
                  String email = state.email ?? '';
                  String phone = state.phone ?? '';
                  String address = state.address ?? '';
                  String dob = state.dobEdited ?? '';
                  Logger.log(
                      'fullName $fullname, email $email, phone $phone, address $address, dob $dob');
                  final status =
                      await context.read<UserCubit>().updateProfile();
                  if (status == UserStatus.updateInfoSuccess) {
                    EasyLoading.showSuccess('Cập nhật thông tin thành công');
                    _loadData();
                    Navigator.pop(context);
                  }
                }
              },
              child: Text('Lưu'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    DesignConstants.primaryColor),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            final customerDto = state.user?.customerDto;
            final userDto = state.user;
            String formattedDateTime = DateFormat('dd/MM/yyyy').format(
                DateTime.fromMillisecondsSinceEpoch(
                    int.parse(customerDto?.dob ?? '0')));

            return Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Họ và tên',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    TextFormField(
                      obscureText: false,
                      onChanged: (change) =>
                          context.read<UserCubit>().onChangeFullname(change),
                      initialValue: customerDto?.fullName,
                      validator: (value) => value == null || value.isEmpty
                          ? "Vui lòng nhập họ tên"
                          : null,
                      decoration: const InputDecoration(
                        hintText: 'Nhập họ và tên',
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: DesignConstants.greyBorder),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    TextFormField(
                      obscureText: false,
                      onChanged: (change) =>
                          context.read<UserCubit>().onChangeEmail(change),
                      initialValue: userDto?.email,
                      validator: (value) => EmailValidator.validate(value ?? "")
                          ? null
                          : "Vui lòng nhập email",
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: DesignConstants.greyBorder),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Số điện thoại',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    TextFormField(
                      obscureText: false,
                      onChanged: (change) =>
                          context.read<UserCubit>().onChangePhone(change),
                      initialValue: userDto?.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'[.-]')),
                      ],
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      validator: (value) =>
                          value == null || value.isEmpty || value.length != 10
                              ? "Vui lòng nhập số điện thoại"
                              : null,
                      decoration: const InputDecoration(
                        counterText: "",
                        hintText: 'Nhập số điện thoại',
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: DesignConstants.primaryColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: DesignConstants.greyBorder),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Ngày sinh',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    StatefulBuilder(builder: (context, setState) {
                      String pickedDate = '';
                      return TextFormField(
                        initialValue:
                            pickedDate == '' ? formattedDateTime : pickedDate,
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime(DateTime.now().year - 17),
                            firstDate: DateTime(DateTime.now().year - 80),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            String dateDisplay =
                                DateFormat('dd/MM/yyyy').format(date);
                            Logger.log('dateDisplay $dateDisplay');
                            setState(() {
                              pickedDate = dateDisplay;
                            });
                            Logger.log('dateDisplayxcxcxc $pickedDate');
                            await context.read<UserCubit>().onChangeDob(date);
                          }
                        },
                        obscureText: false,
                        onChanged: (change) =>
                            context.read<UserCubit>().onChangeDBO(change),
                        readOnly: true,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: DesignConstants.greyBorder),
                          ),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: DesignConstants.greyBorder),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 30),
                    Text(
                      'Địa chỉ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    TextFormField(
                      obscureText: false,
                      onChanged: (change) =>
                          context.read<UserCubit>().onChangeAddress(change),
                      initialValue: customerDto?.address,
                      validator: (value) => value == null || value.isEmpty
                          ? "Vui lòng nhập địa chỉ"
                          : null,
                      decoration: const InputDecoration(
                        hintText: 'Địa chỉ',
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: DesignConstants.greyBorder),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
