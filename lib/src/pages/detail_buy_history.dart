import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/buy-request-history.dart/buy_request_history_cubit.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';
import 'package:buy_sell_motorbike/src/components/promotion_banner.dart';
import 'package:buy_sell_motorbike/src/model/response/buy_request_history_dto.dart';

class DetailBuyHistory extends StatefulWidget {
  const DetailBuyHistory({super.key, required this.buyRequestAppointMent});

  final BuyRequestHistoryDTO buyRequestAppointMent;

  @override
  State<DetailBuyHistory> createState() => _DetailBuyHistoryState();
}

class _DetailBuyHistoryState extends State<DetailBuyHistory> {
  Future<void> _loadData() async {
    await context
        .read<BuyRequestHistoryCubit>()
        .getBuyRequestByID(widget.buyRequestAppointMent.id!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    const _leftStyle = TextStyle(fontSize: 16, color: Colors.grey);
    const _rightStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<BuyRequestHistoryCubit, BuyRequestHistoryState>(
          builder: (context, state) {
            final detailHistory = state.detailBuyRequest;
            List<String> image =
                detailHistory?.motorbikeImageDto?.map((e) => e.url ?? '').toList() ?? [];
            final motorbikedto = detailHistory?.motorbikeDto;
            String formattedDateTime = DateFormat('dd/MM/yyyy').format(
                DateTime.fromMillisecondsSinceEpoch(
                    int.parse(detailHistory?.createdDate.toString() ?? '0')));

            return Column(
              children: [
                PromotionBanner(
                  height: 220,
                  children: image,
                  isLocalFile: false,
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 100,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(widget.buyRequestAppointMent.motorbikeDto!.name ?? 'Tên xe',
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 10),
                          Text(motorbikedto?.motoType.toString() ?? 'Đang cập nhật',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal, color: Colors.grey)),
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
                              motorbikedto?.yearOfRegistration.toString() ?? 'Đang cập nhật',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
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
                              '${motorbikedto?.odo.toString()} km',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                          Text(motorbikedto?.yearOfRegistration ?? '2020', style: _rightStyle),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Loại xe', style: _leftStyle),
                          Text(motorbikedto?.motoType ?? 'Đang cập nhật', style: _rightStyle),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Dung tích xi lanh', style: _leftStyle),
                          Text(motorbikedto?.engineSize.toString() ?? 'Đang cập nhật',
                              style: _rightStyle),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Biển số', style: _leftStyle),
                          Text(motorbikedto?.licensePlate ?? 'Đang cập nhật', style: _rightStyle),
                        ],
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
                        'Thông tin lịch hẹn',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ngày hẹn', style: _leftStyle),
                          Text(formattedDateTime, style: _rightStyle),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Khách hàng', style: _leftStyle),
                          Text(detailHistory?.customerVo?.fullName.toString() ?? 'Đang cập nhật',
                              style: _rightStyle),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                        'Thông tin showroom',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
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
                              detailHistory?.showroomDto?.name ?? 'Đang cập nhật',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              detailHistory?.showroomDto?.address ?? 'Đang cập nhật',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                            Text(
                              'Liên hệ: ${detailHistory?.showroomDto?.phone ?? 'Đang cập nhật'}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
