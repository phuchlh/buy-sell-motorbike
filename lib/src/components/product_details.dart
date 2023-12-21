import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/buy-request/buy_request_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/motorbike/motorbike_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/post/post_cubit.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';
import 'package:buy_sell_motorbike/src/components/location_selection_page.dart';
import 'package:buy_sell_motorbike/src/components/product_hero.dart';
import 'package:buy_sell_motorbike/src/components/promotion_banner.dart';
import 'package:buy_sell_motorbike/src/model/request/buy_request_req.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.id});
  final int id;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _textEditingController = TextEditingController();

  _searchInput() => TextField(
        controller: _textEditingController,
        style: const TextStyle(color: Colors.black, fontSize: 14),
        decoration: InputDecoration(
            isDense: true,
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            fillColor: Colors.white,
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: MaterialStateColor.resolveWith(
                (states) => states.contains(MaterialState.focused) ? Colors.black : Colors.grey),
            labelText: 'Tìm kiếm sản phẩm',
            suffixIcon: IconButton(
              onPressed: () {
                _textEditingController.clear();
                setState(() {
                  // _locationsView = _updateLocationsView();
                });
              },
              icon: const Icon(Icons.clear),
            )),
        onChanged: (value) {
          setState(() {
            // _locationsView = _updateLocationsView(query: value);
          });
        },
      );

  _appBar(BuildContext context) => AppBar(
        backgroundColor: DesignConstants.primaryColor,
        actions: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: OutlinedButton.icon(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocationSelectionPage(
                              availableLocations: {},
                              selectedKey: "",
                            ))),
                icon: const Icon(Icons.location_on_outlined),
                label: const Icon(Icons.expand_more),
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
              ))
        ],
        title: _searchInput(),
        leading: GestureDetector(child: const FlutterLogo(), onTap: () => Navigator.pop(context)),
      );

  Future<void> _loadData() async {
    await context.read<PostCubit>().getPostByID(widget.id);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    const _leftStyle = TextStyle(fontSize: 16, color: Colors.grey);
    const _rightStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    return Scaffold(
        appBar: AppBar(
          title: Text("Chi tiết sản phẩm"),
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () => Navigator.pop(context),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<PostCubit, PostState>(
                builder: (context, state) {
                  final motorid = state.postById?.motorbikeDto?.id ?? 0;
                  final showroomid = state.postById?.showroomDto?.id ?? 0;
                  return Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(DesignConstants.primaryColor),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content:
                                      const Text('Bạn có muốn gửi yêu cầu xem xe đến Showroom?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Không')),
                                    TextButton(
                                        onPressed: () async {
                                          EasyLoading.show(status: 'Đang gửi yêu cầu');
                                          final showroomID = showroomid;
                                          final motorbikeID = motorid;
                                          final postID = widget.id;
                                          await context
                                              .read<BuyRequestCubit>()
                                              .createBuyRequest(postID, motorbikeID, showroomID);
                                          if (context.read<BuyRequestCubit>().state.status ==
                                              BuyRequestStatus.success) {
                                            EasyLoading.showSuccess('Gửi yêu cầu thành công');
                                            Navigator.pop(context);
                                          } else if (context.read<BuyRequestCubit>().state.status ==
                                              BuyRequestStatus.buySelfBike) {
                                            EasyLoading.showError(
                                                'Bạn không thể mua xe của chính mình!');
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text('Có')),
                                  ],
                                ));
                      },
                      child: const Text('Yêu cầu xem xe'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
            onRefresh: _loadData,
            child: SingleChildScrollView(
              child: BlocBuilder<PostCubit, PostState>(
                builder: (context, state) {
                  if (state.status == PostStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.status == PostStatus.success) {
                    final motor = state.postById;
                    final formattedCurrency =
                        NumberFormat.currency(locale: 'vi_VN', symbol: 'đ').format(motor?.price);
                    final imageDtos = state.postById?.motorbikeImageDtos;
                    List<String> image = imageDtos?.map((e) => e.url ?? '').toList() ?? [];
                    return Column(
                      children: [
                        PromotionBanner(
                          children: image,
                          isLocalFile: false,
                        ),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.16,
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(motor?.motorbikeDto?.name ?? 'Đang cập nhật',
                                      style: const TextStyle(
                                          fontSize: 22, fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 10),
                                  Text(motor?.motorbikeDto?.motoType ?? 'Đang cập nhật',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      motor?.motorbikeDto?.yearOfRegistration ?? 'Đang cập nhật',
                                      style: const TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      '${motor?.motorbikeDto?.odo} km' ?? 'Đang cập nhật',
                                      style: const TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                '$formattedCurrency',
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Thông số kỹ thuật',
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Năm sản xuất', style: _leftStyle),
                                  Text(motor?.motorbikeDto?.yearOfRegistration ?? 'Đang cập nhật',
                                      style: _rightStyle),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Loại xe', style: _leftStyle),
                                  Text(motor?.motorbikeDto?.motoType ?? 'Đang cập nhật',
                                      style: _rightStyle),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Dung tích xi lanh', style: _leftStyle),
                                  Text('${motor?.motorbikeDto?.engineSize.toString()} cc',
                                      style: _rightStyle),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Biển số', style: _leftStyle),
                                  Text(motor?.motorbikeDto?.licensePlate ?? 'Đang cập nhật',
                                      style: _rightStyle),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Khu vực', style: _leftStyle),
                                  Text(motor?.showroomDto?.province ?? 'Đang cập nhật',
                                      style: _rightStyle),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          // padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape
                                    .circle, // You can use other shapes or decorations as needed
                                border: Border.all(
                                  color: DesignConstants.primaryColor,
                                  width: 3.0,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/app_logo.jpg',
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  motor?.showroomDto?.name ?? 'Đang cập nhật',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  motor?.showroomDto?.address ?? 'Đang cập nhật',
                                  style:
                                      const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  'Liên hệ: ${motor?.showroomDto?.phone ?? 'Đang cập nhật'}',
                                  style:
                                      const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mô tả',
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      motor?.content ?? 'Đang cập nhật',
                                      style: const TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  return Center(
                    child: Text('Đang có lỗi'),
                  );
                },
              ),
            )));
  }
}

// FractionallySizedBox(
//   // alignment: Alignment.topCenter,
//   widthFactor: 1,
//   child: ProductHero(
//     imageUrls: [
//       "https://tongmotor.vn/wp-content/uploads/2023/05/z4378566362181_c714f7e83dd74f009b425de4c4dea8a0.jpg",
//       "https://tongmotor.vn/wp-content/uploads/2023/05/z4378566340852_434cc97abadfb9c88425b6fabd90816d.jpg",
//       "https://tongmotor.vn/wp-content/uploads/2023/05/z4378566346924_e78cd49ec78f0b4be76a050ba3e9a91a.jpg",
//       "https://tongmotor.vn/wp-content/uploads/2023/05/z4378566356787_91188295d544f53d720941588a5da7b3.jpg",
//     ],
//   ),
// ),
