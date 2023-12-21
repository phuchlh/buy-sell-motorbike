import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:buy_sell_motorbike/logger.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/user/user_cubit.dart';
import 'package:buy_sell_motorbike/src/common/configurations.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';
import 'package:buy_sell_motorbike/src/components/footer.dart';
import 'package:buy_sell_motorbike/src/components/notification_page.dart';
import 'package:buy_sell_motorbike/src/components/reset_password_page.dart';
import 'package:buy_sell_motorbike/src/components/widget_location_selector.dart';
import 'package:buy_sell_motorbike/src/pages/buy_request_history.dart';
import 'package:buy_sell_motorbike/src/pages/edit_personal_info.dart';
import 'package:buy_sell_motorbike/src/pages/sell_request_history.dart';
import 'package:buy_sell_motorbike/src/state/navigation_items.dart';

import '../common/utils.dart';

class UserSettingPage extends StatefulWidget {
  const UserSettingPage({super.key});

  @override
  _UserSettingPageState createState() => _UserSettingPageState();
}

Future<File> _pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile == null) return File('');
  File pickedImage = (File(pickedFile!.path)); // *fix chỗ này nếu back lại
  return pickedImage;
}

String imageName = "";

bool hasPfp(String url) {
  // true -> has, false -> no
  if (url.startsWith('http') || url.startsWith('https')) {
    return true;
  } else {
    return false;
  }
}

Future<String> uploadimage(File imageFile) async {
  // up từng tấm, sửa lại up 1 list
  try {
    final _storage = FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png');

    final uploadTask =
        _storage.putFile(imageFile).then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
    print("URL is $uploadTask");

    // Return the download URL.
    return uploadTask;
  } catch (error) {
    // Handle any errors that occur during the upload.
    print("Error uploading image: $error");
    return 'Error';
  }
}

class _UserSettingPageState extends State<UserSettingPage> {
  SizedBox _verticalSpacing = const SizedBox(height: 5);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final customerDto = state.user?.customerDto;
        final user = state.user;
        final customerPFP = customerDto?.avatarUrl;
        bool checkPfp = hasPfp(customerPFP ?? "");
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              padding: EdgeInsets.only(top: 20),
              width: double.infinity,
              color: Color(0xFFEBE3D5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: customerPFP == "" || !checkPfp
                            ? ProfilePicture(
                                name: customerDto?.fullName ?? "",
                                radius: 31,
                                fontsize: 18,
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.black45,
                                radius: 20,
                                backgroundImage: NetworkImage(customerPFP ?? ""),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 5,
                        child: GestureDetector(
                          onTap: () async {
                            File pickedImage = await _pickImage();
                            EasyLoading.show(status: 'Đang cập nhật ảnh đại diện');
                            final uploaded = await uploadimage(pickedImage);
                            setState(() {
                              imageName = uploaded;
                            });
                            print('asdkjlhadkjahsd $imageName');
                            if (imageName != "") {
                              await context.read<UserCubit>().updateProfilePic(imageName);
                            }
                            if (context.read<UserCubit>().state.status ==
                                UserStatus.changePFPSuccess) {
                              await context.read<UserCubit>().getUser();
                              EasyLoading.showSuccess('Cập nhật ảnh đại diện thành công');
                            }
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Text(
                            customerDto?.fullName ?? "",
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                          _verticalSpacing,
                          Text(
                            user?.email ?? "",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          _verticalSpacing,
                          Text(
                            user?.phone ?? "Đang cập nhật",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          _verticalSpacing,
                          Text(
                            customerDto?.address ?? "",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Column(
                children: [
                  _elementSetting('Chỉnh sửa thông tin cá nhân', Icons.person_outline_sharp,
                      pushNavigatorOnPressed(context, (_) => EditInformationPage())),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  _elementSetting('Đổi mật khẩu', Icons.lock_outline_rounded,
                      pushNavigatorOnPressed(context, (_) => ResetPasswordPage())),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  _elementSetting('Lịch sử xem xe', Icons.add,
                      pushNavigatorOnPressed(context, (_) => BuyRequestHistory())),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  _elementSetting('Lịch sử đăng bán', Icons.remove,
                      pushNavigatorOnPressed(context, (_) => SellRequestHistory())),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  LogoutButton(title: 'Đăng xuất', icon: Icons.logout),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .143),
              child: Footer(),
            ),
          ],
        );
      },
    );
  }

  Widget _elementSetting(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  _handleOnPressedLogOut(BuildContext context, WidgetRef ref) {
    Logger.log('123123123');
    NavigationItems.isLogged == true;
    final navigationState = ref.watch(navigationStateProvider);
    SharedInstances.secureRemove('userData');
    navigationState.updateSelectedIndex(0);
  }
}

class LogoutButton extends ConsumerStatefulWidget {
  final String title;
  final IconData icon;
  const LogoutButton({super.key, required this.title, required this.icon});

  @override
  ConsumerState<LogoutButton> createState() => _LogoutHandlerState();
}

class _LogoutHandlerState extends ConsumerState<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await SharedInstances.secureRemove('userData');
        await SharedInstances.secureRemove('userID');
        await SharedInstances.secureRemove('customerID');
        final botnavOptions = ref.watch(botnavOptionsProvider);
        final navigationState = ref.watch(navigationStateProvider);
        await botnavOptions.toggleMode();
        Logger.log('123123123999');
        navigationState.updateSelectedIndex(2);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 40,
        child: Row(
          children: [
            Icon(widget.icon),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
