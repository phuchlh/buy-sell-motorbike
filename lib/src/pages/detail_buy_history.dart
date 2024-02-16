import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../blocs/cubit/buy-request-history.dart/buy_request_history_cubit.dart';
import '../common/constants.dart';
import '../components/custom_expansion_card.dart';
import '../components/custom_expansion_title.dart';
import '../components/promotion_banner.dart';
import '../components/render_history.dart';
import '../components/transaction_custom_expansion.dart';
import '../model/response/request_history_dtos.dart';

class DetailBuyHistory extends StatefulWidget {
  const DetailBuyHistory({super.key, required this.requestID});

  final String requestID;
  @override
  State<DetailBuyHistory> createState() => _DetailBuyHistoryState();
}

class _DetailBuyHistoryState extends State<DetailBuyHistory> {
  String? detailBuyRequestStatus;
  Future<void> _loadData() async {
    await context
        .read<BuyRequestHistoryCubit>()
        .getBuyRequestByID(widget.requestID);
    setState(() {
      detailBuyRequestStatus =
          context.read<BuyRequestHistoryCubit>().state.detailBuyRequest?.status;
    });
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
      bottomNavigationBar: detailBuyRequestStatus == "CREATED"
          ? Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      DesignConstants.primaryColor),
                ),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: const Text(
                                'Bạn có chắc chắn muốn hủy yêu cầu?'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Không')),
                              TextButton(
                                  onPressed: () async {
                                    EasyLoading.show(
                                        status: 'Đang hủy yêu cầu');
                                    final check = await context
                                        .read<BuyRequestHistoryCubit>()
                                        .cancelBuyRequest(widget.requestID);
                                    if (check) {
                                      EasyLoading.showSuccess(
                                          'Hủy yêu cầu thành công');
                                      Navigator.pop(context);
                                    } else {
                                      EasyLoading.showError(
                                          'Hủy không thành công');
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text('Có')),
                            ],
                          ));
                },
                child: const Text('Hủy yêu cầu'),
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: BlocBuilder<BuyRequestHistoryCubit, BuyRequestHistoryState>(
          builder: (context, state) {
            if (state.detailStatus == DetailBuyRequestHistoryStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.detailStatus ==
                DetailBuyRequestHistoryStatus.loaded) {
              final detailHistory = state.detailBuyRequest;
              final requestHistoryDTOs =
                  detailHistory?.requestHistoryDtos ?? [];
              final transactionDTOS = detailHistory?.transactionDtos ?? [];
              if (detailHistory == null) {
                // Handle the case where detailHistory is null (perhaps show a loading indicator)
                return Center(child: CircularProgressIndicator());
              }
              List<String> image = detailHistory?.motorbikeImageDto
                      ?.map((e) => e.url ?? '')
                      .toList() ??
                  [];
              final motorbikedto = detailHistory?.motorbikeDto;
              // ngày hẹn xem xe
              String appointmentDate = DateFormat('dd/MM/yyyy').format(
                  DateTime.fromMillisecondsSinceEpoch(int.parse(
                      detailHistory?.checkingAppointmentDto?.appointmentDate ??
                          '0')));

              // ngày giao dịch
              String tradingDate = DateFormat('dd/MM/yyyy').format(
                  DateTime.fromMillisecondsSinceEpoch(int.parse(
                      detailHistory?.purchaseAppointmentDto?.appointmentDate ??
                          '0')));
              return Column(
                children: [
                  PromotionBanner(
                    isAutoScroll: false,
                    height: 220,
                    children: image,
                    isLocalFile: false,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .13,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(motorbikedto!.name ?? 'Tên xe',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 10),
                            Text(
                                motorbikedto?.motoType.toString() ??
                                    'Đang cập nhật',
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
                                motorbikedto?.yearOfRegistration.toString() ??
                                    'Đang cập nhật',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
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
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomExpansionTile(
                    icon: Icons.settings,
                    title: 'Thông số kỹ thuật',
                    mapItem: {
                      'Năm sản xuất':
                          motorbikedto?.yearOfRegistration ?? 'Đang cập nhật',
                      'Loại xe': motorbikedto?.motoType ?? 'Đang cập nhật',
                      'Dung tích xi lanh':
                          motorbikedto?.engineSize.toString() ??
                              'Đang cập nhật',
                      'Biển số': motorbikedto?.licensePlate ?? 'Đang cập nhật',
                      'Mô tả': motorbikedto?.description ?? 'Đang cập nhật',
                    },
                  ),
                  SizedBox(height: 10),
                  transactionDTOS.isNotEmpty
                      ? TransactionCustomExpansion(
                          icon: Icons.calendar_month,
                          title: 'Chi tiết giao dịch',
                          transaction: transactionDTOS,
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: 10,
                  ),
                  CustomExpansionCard(
                    icon: Icons.info,
                    title: 'Thông tin showroom',
                    showroomName:
                        detailHistory.showroomDto?.name ?? 'Đang cập nhật',
                    showroomAddress:
                        detailHistory.showroomDto?.address ?? 'Đang cập nhật',
                    showroomPhone:
                        detailHistory.showroomDto?.phone ?? 'Đang cập nhật',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // lịch sử
                  requestHistoryDTOs.isNotEmpty
                      ? HistoryView(requestHistoryDTOs: requestHistoryDTOs)
                      : Container(),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  'Vui lòng thử lại',
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildIndicator(RequestHistoryDtos item) {
    final isBuyRequest = item.requestType == 'BUY_REQUEST';

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isBuyRequest ? Colors.green : Colors.grey,
      ),
      child: Center(
        child: Icon(
          isBuyRequest ? Icons.shopping_cart : Icons.info,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTimelineContent(RequestHistoryDtos item) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 120,
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.content ?? "Updating",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            _formatDate(item.createdDate ?? '0'),
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  String _formatDate(String timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    final formattedDate = '${date.day}/${date.month}/${date.year}';
    return formattedDate;
  }
}


// Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.withOpacity(0.5),
                  //         blurRadius: 5,
                  //         offset: const Offset(0, 3), // changes position of shadow
                  //       ),
                  //     ],
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'Thông tin showroom',
                  //         style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  //       ),
                  //       ListTile(
                  //         leading: Container(
                  //           decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             border: Border.all(
                  //               color: DesignConstants.primaryColor,
                  //               width: 3.0,
                  //             ),
                  //           ),
                  //           child: ClipOval(
                  //             child: Image.asset(
                  //               'assets/images/app_logo.jpg',
                  //               width: 50,
                  //               height: 50,
                  //             ),
                  //           ),
                  //         ),
                  //         subtitle: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               detailHistory?.showroomDto?.name ?? 'Đang cập nhật',
                  //               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  //             ),
                  //             Text(
                  //               detailHistory?.showroomDto?.address ?? 'Đang cập nhật',
                  //               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  //             ),
                  //             Text(
                  //               'Liên hệ: ${detailHistory?.showroomDto?.phone ?? 'Đang cập nhật'}',
                  //               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),