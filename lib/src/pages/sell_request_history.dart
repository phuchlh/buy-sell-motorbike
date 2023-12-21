import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/sell-request/sell_request_cubit.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';
import 'package:buy_sell_motorbike/src/common/utils.dart';
import 'package:buy_sell_motorbike/src/pages/detail_buy_history.dart';
import 'package:buy_sell_motorbike/src/pages/detail_sell_history.dart';

class SellRequestHistory extends StatefulWidget {
  const SellRequestHistory({super.key});

  @override
  State<SellRequestHistory> createState() => _SellRequestHistoryState();
}

class _SellRequestHistoryState extends State<SellRequestHistory> {
  Future<void> _loadData() async {
    await context.read<SellRequestHistoryCubit>().getSellRequests();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  Map status = {
    'CREATED': 'Đã gửi yêu cầu',
    'CANCELLED': 'Đã huỷ yêu cầu',
    'APPROVED': 'Yêu cầu đã được chấp nhận',
    'REJECTED': ' Yêu cầu đã bị từ chối',
    'CHECKED': 'Đã tiếp nhận xe ',
    'POSTED': 'Đã đăng bài',
    'EXPIRED': 'Hết hạn',
    'COMPLETED': 'Đã hoàn tất',
  };

  Map statusColor = const {
    'CREATED': Color(0xFF757575),
    'CANCELLED': Color(0xFFd9342b),
    'APPROVED': Color(0xFF059bb4),
    'REJECTED': Color(0xFFd9342b),
    'CHECKED': Color(0xFF1da750),
    'POSTED': Color(0xFFd46213),
    'EXPIRED': Color(0xFFd9342b),
    'COMPLETED': Color(0xFF8f48d2),
  };

  final sizedHeight = const SizedBox(
    height: 10,
  );
  final sizedWidth = const SizedBox(
    width: 10,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lịch sử đăng bán'),
        ),
        body: RefreshIndicator(
            onRefresh: _loadData,
            child: BlocBuilder<SellRequestHistoryCubit, SellRequestHistoryState>(
              builder: (context, state) {
                if (state.status == SellRequestHistoryStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status == SellRequestHistoryStatus.loaded ||
                    state.status == SellRequestHistoryStatus.loadDetailSuccess) {
                  final sellRequestList = state.sellRequests;
                  return ListView.builder(
                    itemCount: sellRequestList.length,
                    itemBuilder: (context, index) {
                      String formattedDateTime = DateFormat('dd/MM/yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(sellRequestList[index].createdDate ?? '0')));
                      return GestureDetector(
                        onTap: pushNavigatorOnPressed(
                          context,
                          (_) => DetailSellHistory(
                            sellRequest: sellRequestList[index],
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10, left: 10),
                                  child: Stack(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: Icon(
                                              Icons.pedal_bike_rounded,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                            child: VerticalDivider(
                                              color: Colors.grey[450],
                                              thickness: .5,
                                            ),
                                          ),
                                          Text(
                                            formattedDateTime,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        right: MediaQuery.of(context).size.width / 20,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: statusColor.containsKey(
                                                    sellRequestList[index].status ?? '')
                                                ? statusColor[sellRequestList[index].status ?? '']
                                                : Colors.grey[500],
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            status.containsKey(sellRequestList[index].status ?? '')
                                                ? status[sellRequestList[index].status ?? '']
                                                : 'Đang cập nhật',
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey[450],
                                thickness: 1,
                              ),
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: NetworkImage(sellRequestList[index]
                                                        .motorbikeImageDto?[0]
                                                        .url ??
                                                    ErrorConstants.ERROR_PHOTO),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      sizedWidth,
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              sellRequestList[index].motorbikeDto?.name ??
                                                  'Đang cập nhật',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            sizedHeight,
                                            Text(
                                              sellRequestList[index].motorbikeDto?.licensePlate ??
                                                  'Đang cập nhật',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                            sizedHeight,
                                            Text(
                                              "${sellRequestList[index].motorbikeDto?.yearOfRegistration} - ${sellRequestList[index].motorbikeDto?.odo} km",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Có lỗi'),
                  );
                }
              },
            )));
  }
}
