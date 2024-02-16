import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logger.dart';
import '../blocs/cubit/motorbrand/motorbrand_cubit.dart';
import '../blocs/cubit/showroom/showroom_cubit.dart';
import '../blocs/cubit/user/user_cubit.dart';
import '../common/configurations.dart';
import '../common/constants.dart';
import '../common/utils.dart';
import '../components/input_info_bike.dart';
import '../components/pick_image.dart';
import '../components/warn_lottie.dart';
import '../components/widget_location_selector.dart';
import '../model/response/motor_brand_response.dart';
import 'user_page.dart';
import '../state/navigation_items.dart';

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
                : WarningLottie(
                    firstLine: 'Bạn không thể đăng bài',
                    secondLine:
                        'Vui lòng liên hệ với showroom gần nhất để được hỗ trợ',
                  );
          },
        ),
      ),
    );
  }
}
