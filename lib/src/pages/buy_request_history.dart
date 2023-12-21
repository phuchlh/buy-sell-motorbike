import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/buy-request-history.dart/buy_request_history_cubit.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';
import 'package:buy_sell_motorbike/src/common/utils.dart';
import 'package:buy_sell_motorbike/src/pages/detail_buy_history.dart';

class BuyRequestHistory extends StatefulWidget {
  const BuyRequestHistory({super.key});

  @override
  State<BuyRequestHistory> createState() => _BuyRequestHistoryState();
}

class _BuyRequestHistoryState extends State<BuyRequestHistory> {
  Future<void> _loadData() async {
    await context.read<BuyRequestHistoryCubit>().getBuyRequests();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  /*
  CREATE - Đã gửi yêu cầu #757575
CANCELLED - Đã huỷ yêu cầu #d9342b
CONFIRMED - Đã xác nhận #059bb4
DEPOSITED - Đã đặt cọc #d46213
SCHEDULED - Đang tiến hành thủ tục #c79807
COMPLETED - Đã hoàn tất #8f48d2
   */

  Map buyStatus = {
    'CREATED': 'Đã gửi yêu cầu',
    'CANCELLED': 'Đã huỷ yêu cầu',
    'CONFIRMED': 'Đã xác nhận',
    'DEPOSITED': 'Đã đặt cọc',
    'SCHEDULED': 'Đang tiến hành thủ tục',
    'COMPLETED': 'Đã hoàn tất',
  };

  Map statusColor = const {
    'CREATED': Color(0xFF757575),
    'CANCELLED': Color(0xFFd9342b),
    'CONFIRMED': Color(0xFF059bb4),
    'DEPOSITED': Color(0xFFd46213),
    'SCHEDULED': Color(0xFFc79807),
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
          title: const Text('Lịch sử xem xe'),
        ),
        body: RefreshIndicator(
            onRefresh: _loadData,
            child: BlocBuilder<BuyRequestHistoryCubit, BuyRequestHistoryState>(
              builder: (context, state) {
                if (state.status == BuyRequestHistoryStatus.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status == BuyRequestHistoryStatus.loadDetailSuccess ||
                    state.status == BuyRequestHistoryStatus.loaded) {
                  final buyRequestList = state.buyRequests;

                  return ListView.builder(
                    itemCount: buyRequestList.length,
                    itemBuilder: (context, index) {
                      String formattedDateTime = DateFormat('dd/MM/yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(buyRequestList[index].createdDate ?? '0')));
                      return GestureDetector(
                        onTap: pushNavigatorOnPressed(
                          context,
                          (_) => DetailBuyHistory(
                            buyRequestAppointMent: buyRequestList[index],
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
                                              color: Colors.grey[500],
                                              thickness: 1,
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
                                        right: MediaQuery.of(context).size.width / 15,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: statusColor
                                                    .containsKey(buyRequestList[index].status ?? '')
                                                ? statusColor[buyRequestList[index].status ?? '']
                                                : Colors.black,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            buyStatus
                                                    .containsKey(buyRequestList[index].status ?? '')
                                                ? buyStatus[buyRequestList[index].status ?? '']
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
                                color: Colors.grey[500],
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
                                                image: NetworkImage(buyRequestList[index]
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
                                              buyRequestList[index].motorbikeDto?.name ??
                                                  'Đang cập nhật',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            sizedHeight,
                                            Text(
                                              buyRequestList[index].motorbikeDto?.licensePlate ??
                                                  'Đang cập nhật',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                            sizedHeight,
                                            Text(
                                              "${buyRequestList[index].motorbikeDto?.yearOfRegistration} - ${buyRequestList[index].motorbikeDto?.odo} km",
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
                  return Center(
                    child: Text('Có lỗi, vui lòng thử lại'),
                  );
                }
              },
            )));
  }
}
