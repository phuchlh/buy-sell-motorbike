import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_sell_motorbike/logger.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/motorbrand/motorbrand_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/showroom/showroom_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/user/user_cubit.dart';
import 'package:buy_sell_motorbike/src/common/configurations.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';
import 'package:buy_sell_motorbike/src/common/utils.dart';
import 'package:buy_sell_motorbike/src/components/input_info_bike.dart';
import 'package:buy_sell_motorbike/src/components/pick_image.dart';
import 'package:buy_sell_motorbike/src/components/widget_location_selector.dart';
import 'package:buy_sell_motorbike/src/model/response/motor_brand_response.dart';
import 'package:buy_sell_motorbike/src/pages/user_page.dart';
import 'package:buy_sell_motorbike/src/state/navigation_items.dart';

import 'package:lottie/lottie.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  Future<void> _loadData() async {
    if (context.read<ShowroomCubit>().state.showrooms.isEmpty) {
      await context.read<ShowroomCubit>().getShowrooms();
    }
  }

  List<File> selectedImages = [];
  bool isEnoughImages = false;

  void clearImage() {
    setState(() {
      selectedImages.clear();
    });
  }

  void addImage(File image) {
    setState(() {
      selectedImages.add(image);
    });
    if (selectedImages.length >= 3) {
      setState(() {
        isEnoughImages = true;
      });
    }
  }

  void removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
    if (selectedImages.length < 3) {
      setState(() {
        isEnoughImages = false;
      });
    }
  }

  bool _isLogged = false;
  Future<void> _checkLogin() async {
    bool checkLogin = NavigationItems.isLogged;
    if (checkLogin == true) {
      setState(() {
        _isLogged = true;
      });
    } else {
      setState(() {
        _isLogged = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _loadData();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng tin'),
        backgroundColor: DesignConstants.primaryColor,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            bool ableToBuy = state.user?.customerDto?.isBuy ?? true;
            return ableToBuy
                ? Column(
                    children: [
                      PickImage(
                        onImageSelected: addImage,
                        onImageDeleted: removeImage,
                        listPickedImage: selectedImages,
                      ),
                      const Divider(),
                      InputInforBike(
                        onClearImage: clearImage,
                        selectedImages: selectedImages,
                        isEnoughImage: isEnoughImages,
                      ),
                    ],
                  )
                : Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
                      width: 300,
                      height: 300,
                      child: Column(
                        children: [
                          Lottie.asset(
                            'assets/images/warning.json',
                            width: 150,
                            height: 150,
                            fit: BoxFit.fill,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Bạn không có quyền đăng tin\n',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                              children: [
                                TextSpan(
                                  text: 'Vui lòng liên hệ với 1 trong các showroom để được hỗ trợ',
                                ),
                              ],
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
