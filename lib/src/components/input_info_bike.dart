// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/motorbrand/motorbrand_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/post/post_cubit.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';
import 'package:buy_sell_motorbike/src/components/custom_textfield.dart';
import 'package:buy_sell_motorbike/src/components/motor_brand_pick.dart';
import 'package:buy_sell_motorbike/src/components/pick_showroom.dart';
import 'package:buy_sell_motorbike/src/components/year_pick.dart';
import 'package:buy_sell_motorbike/src/model/response/motor_brand_response.dart';

class InputInforBike extends StatefulWidget {
  const InputInforBike({
    super.key,
    required this.selectedImages,
    required this.isEnoughImage,
  });
  final List<File> selectedImages;
  final bool isEnoughImage;

  @override
  State<InputInforBike> createState() => _InputInforBikeState();
}

class _InputInforBikeState extends State<InputInforBike> {
  final TextStyle _textStyle = TextStyle(fontSize: 16, color: Colors.grey[600]);
  final TextStyle _mustHave = TextStyle(fontSize: 16, color: Colors.blue);
  final TextStyle _sellLocation =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
  final Decoration _decorGrey = BoxDecoration(
    border: Border.all(color: Colors.grey),
  );
  final Decoration _decorYellow = BoxDecoration(
    border: Border.all(color: Colors.yellow.shade700),
    color: Colors.yellow.shade700,
  );

  final TextEditingController _controller = TextEditingController();

  final Map _typeMotorbikeMap = {
    'MANUAL': 'Xe số',
    "STICK-SHIFT": 'Xe tay ga',
    'CLUTCH': 'Xe côn tay',
  };

  final Map _engineSize = {
    1: 'Dưới 100cc',
    2: '100cc - 175cc',
    3: '175cc - 500cc',
    4: 'Trên 500cc',
  };
  String _typeMotorbike = "";
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  Future<List<String>> _uploadFile(List<File> listImage) async {
    List<String> downloadURLs = [];
    try {
      final List<Future<String>> uploadTasks = [];
      for (final file in listImage) {
        final _storage = FirebaseStorage.instance.ref().child('img-request/${DateTime.now()}.png');

        final uploadTask =
            _storage.putFile(file).then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
        uploadTasks.add(uploadTask);
      }
      downloadURLs = await Future.wait(uploadTasks);

      return downloadURLs;
    } on PlatformException catch (e) {
      print(e);
    }
    return downloadURLs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // dòng xe
              MotorBrandPick(
                  title: 'Dòng xe', icon: Icons.directions_bike_rounded, isRequired: true),

              // năm sản xuất
              SizedBox(height: 20),
              // _componetTitleAndBottomSheet(
              //     'Lựa chọn năm sản xuất', Icons.date_range_outlined, true, false),
              PickYear(
                  title: 'Năm sản xuất', icon: Icons.calendar_today_outlined, isRequired: true),

              // pick showroom
              SizedBox(height: 20),
              PickShowroom(
                  title: 'Chọn showroom', icon: Icons.directions_bike_rounded, isRequired: true),

              // odo
              SizedBox(height: 20),
              titleForInput('Số đồng hồ', true, false),
              Container(
                padding: EdgeInsets.only(left: 25, right: 25, top: 10),
                child: TextFormField(
                  onChanged: (value) => context.read<PostCubit>().onChangeOdometer(value),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Vui lòng nhập đúng số kilomet đã đi" : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: 'Nhập số km đã đi',
                    prefixIcon: Icon(Icons.motorcycle_outlined),
                  ),
                ),
              ),
              // tên xe
              SizedBox(height: 20),
              titleForInput('Tên xe', true, false),
              Container(
                padding: EdgeInsets.only(left: 25, right: 25, top: 10),
                child: TextFormField(
                  validator: (value) =>
                      value == null || value.isEmpty ? "Vui lòng nhập tên xe" : null,
                  onChanged: (value) => context.read<PostCubit>().onChangeMotorName(value),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: 'Nhập tên xe',
                    prefixIcon: Icon(Icons.motorcycle_outlined),
                  ),
                ),
              ),

              // biển số
              SizedBox(height: 20),
              titleForInput('Biển số xe', true, false),
              Container(
                padding: EdgeInsets.only(left: 25, right: 25, top: 10),
                child: TextFormField(
                  onChanged: (value) => context.read<PostCubit>().onChangeLicensePlate(value),
                  keyboardType: TextInputType.text,
                  validator: (value) =>
                      value == null || value.isEmpty || value.length < 2 || value.length > 10
                          ? "Vui lòng nhập biển số xe"
                          : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: 'Nhập biển số xe (không nhập dấu -)',
                    prefixIcon: Icon(Icons.motorcycle_outlined),
                  ),
                ),
              ),

              // engine size
              SizedBox(height: 20),
              titleForInput('Dung tích xi lanh', true, false),
              Container(
                padding: EdgeInsets.only(left: 25, right: 25, top: 10),
                child: TextFormField(
                  validator: (value) => value == null || value.isEmpty || int.parse(value) < 0
                      ? "Vui lòng nhập dung tích xi lanh"
                      : null,
                  onChanged: (value) => context.read<PostCubit>().onChangeEngineSize(value),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: 'Nhập dung tích xi lanh',
                    prefixIcon: Icon(Icons.motorcycle_outlined),
                  ),
                ),
              ),

              // loại xe

              SizedBox(height: 20),
              titleForInput('Loại xe', true, false),
              _componentPickData('Loại xe', Icons.motorcycle_outlined, (value) {
                context.read<PostCubit>().onChangeMotorType(value);
              }),

              // price
              SizedBox(height: 20),
              titleForInput('Giá trị muốn bán', true, false),
              Container(
                padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      context.read<PostCubit>().onChangePrice(value);
                      final intValue = int.parse(value);
                      final formattedValue = NumberFormat('#,##0.##', 'vi').format(intValue);
                      _controller.value = _controller.value.copyWith(
                        text: formattedValue,
                        selection: TextSelection.collapsed(offset: formattedValue.length),
                      );
                    }
                  },
                  validator: (value) => value == null || value.isEmpty ? "Vui lòng nhập giá" : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    prefixIcon: Icon(Icons.attach_money_outlined),
                    hintText: 'Vui lòng nhập giá',
                    suffix: Text(
                      'đ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    suffixStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                    children: [
                      TextSpan(
                        text: 'Mẹo: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Tham khảo giá thị trường để định giá muốn bán hợp lý, dễ dàng thu hút người mua. Mức giá không hợp lý, giá quá thấp hoặc quá cao sẽ khiến tin đăng bị đánh giá thấp.',
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),
              // price
              titleForInput('Mô tả sản phẩm', true, false),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(left: 8),
                  child: TextFormField(
                    onChanged: (value) => context.read<PostCubit>().onChangeDescription(value),
                    textInputAction: TextInputAction.done,
                    maxLines: 8,
                    validator: (value) =>
                        value == null || value.isEmpty ? "Vui lòng nhập mô tả" : null,
                    decoration: InputDecoration(
                      hintText: 'Vui lòng thêm thông tin mô tả về sản phẩm',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                    children: [
                      TextSpan(
                        text: 'Chú ý: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            ' Hãy đăng thông tin trung thực về sản phẩm. Nếu thông tin sản phẩm của bạn không đúng hoặc giả mạo, tin đăng của bạn sẽ không được xét duyệt trên hệ thống của và tài khoản của bạn có thể bị dừng hoạt động. ',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: widget.isEnoughImage
                    ? () async {
                        if (_formKey.currentState!.validate()) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Gửi yêu cầu'),
                              content: const Text(
                                  'Bạn có chắc chắn muốn gửi yêu cầu?\nYêu cầu của bạn sẽ được admin duyệt trước khi đăng lên hệ thống'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Hủy'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    //loading here
                                    EasyLoading.show(status: 'Đang gửi yêu cầu');
                                    print(widget.selectedImages.length);
                                    final List<String> imageUrls =
                                        await _uploadFile(widget.selectedImages);
                                    await context.read<PostCubit>().onAddImageList(imageUrls);
                                    await context.read<PostCubit>().createPost();
                                    if (context.read<PostCubit>().state.status ==
                                        PostStatus.success) {
                                      EasyLoading.showSuccess('Gửi yêu cầu thành công');
                                      Navigator.pop(context);
                                    } // submit
                                    else if (context.read<PostCubit>().state.status ==
                                        PostStatus.notLoginYet) {
                                      Navigator.pop(context);
                                      EasyLoading.showError(
                                          'Gửi yêu cầu không thành công\nVui lòng đăng nhập và thử lại sau');

                                      // Navigator.pop(context);
                                    }
                                    print('imageUrls $imageUrls');
                                  },
                                  child: const Text('Đồng ý'),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    : null,
                child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: widget.isEnoughImage ? DesignConstants.primaryColor : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Gửi yêu cầu',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _bottomMotorType(String title, Function(String) onChangeMotorType) async {
    // show data
    // put list data here
    String? type = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: _typeMotorbikeMap.length,
            itemBuilder: (context, index) {
              final key = _typeMotorbikeMap.keys.elementAt(index);
              final value = _typeMotorbikeMap[key];
              return ListTile(
                title: Text(value),
                onTap: () {
                  onChangeMotorType(value!);
                  Navigator.pop(context, value); // Return the selected key
                },
              );
            },
          ),
        );
      },
    );
    if (type != null) {
      setState(() {
        _typeMotorbike = type;
      });
    }
  }

  Widget _componetTitleAndBottomSheet(
      // title
      String title,
      IconData icon,
      bool isRequired,
      bool isNoteForSell) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style:
                  isNoteForSell ? _sellLocation : _textStyle, // isNoteForSell = true => title bold
            ),
            SizedBox(width: 5),
            isRequired
                ? Text(
                    '*',
                    style: _mustHave,
                  )
                : SizedBox(),
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: GestureDetector(
            onTap: () {
              _showBottomSheetPicker(title);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(icon),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showBottomSheetPicker(String title) {
    // show data
    // put list data here
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 700,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _componentPickData(String title, IconData icon, Function(String) onChangeMotorType) {
    // put list data here to pass to modal bottom sheet
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: GestureDetector(
        onTap: () {
          _bottomMotorType(title, onChangeMotorType);
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  _typeMotorbike.isNotEmpty ? _typeMotorbike : title,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Icon(Icons.arrow_forward_ios_outlined),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleForInput(String title, bool isRequired, bool isBold) {
    return Row(
      children: [
        Text(
          title,
          style: isBold ? _sellLocation : _textStyle,
        ),
        SizedBox(width: 5),
        isRequired
            ? Text(
                '*',
                style: _mustHave,
              )
            : SizedBox(),
      ],
    );
  }
}
