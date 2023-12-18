import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_sell_motorbike/logger.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/motorbrand/motorbrand_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/showroom/showroom_cubit.dart';
import 'package:buy_sell_motorbike/src/common/configurations.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';
import 'package:buy_sell_motorbike/src/common/utils.dart';
import 'package:buy_sell_motorbike/src/components/input_info_bike.dart';
import 'package:buy_sell_motorbike/src/components/pick_image.dart';
import 'package:buy_sell_motorbike/src/components/widget_location_selector.dart';
import 'package:buy_sell_motorbike/src/model/response/motor_brand_response.dart';
import 'package:buy_sell_motorbike/src/pages/user_page.dart';
import 'package:buy_sell_motorbike/src/state/navigation_items.dart';

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
    Logger.log('123123123 ${_isLogged}');
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
    print('1234565476464356 ${NavigationItems.isLogged}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng tin'),
        backgroundColor: DesignConstants.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PickImage(onImageSelected: addImage, onImageDeleted: removeImage),
            Divider(),
            InputInforBike(
              selectedImages: selectedImages,
              isEnoughImage: isEnoughImages,
            ),
          ],
        ),
      ),
    );
  }
}
