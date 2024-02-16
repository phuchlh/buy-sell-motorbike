import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../blocs/cubit/sell-request/sell_request_cubit.dart';
import '../common/constants.dart';
import '../components/custom_expansion_card.dart';
import '../components/custom_expansion_title.dart';
import '../components/promotion_banner.dart';
import '../components/render_history.dart';
import '../components/transaction_custom_expansion.dart';
import '../components/warn_lottie.dart';
import '../model/response/detail_sell_request.dart';
import '../model/response/sell_request_response.dart';
import 'sell_request_history.dart';

class DetailSellHistory extends StatefulWidget {
  const DetailSellHistory({super.key, required this.requestID});
  final String requestID;

  @override
  State<DetailSellHistory> createState() => _DetailSellHistoryState();
}

class _DetailSellHistoryState extends State<DetailSellHistory> {
  String? detailSellRequestStatus;
  Future<void> _loadData() async {
    await context
        .read<SellRequestHistoryCubit>()
        .getSellRequestById(widget.requestID);
    setState(() {
      detailSellRequestStatus = context
          .read<SellRequestHistoryCubit>()
          .state
          .detailSellRequest
          ?.status;
    });
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

  @override
  Widget build(BuildContext context) {
    const _leftStyle = TextStyle(fontSize: 16, color: Colors.grey);
    const _rightStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết'),
      ),
      bottomNavigationBar: detailSellRequestStatus == "CREATED"
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
                                        .read<SellRequestHistoryCubit>()
                                        .cancelSellRequest(widget.requestID);
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
        child: BlocBuilder<SellRequestHistoryCubit, SellRequestHistoryState>(
          builder: (context, state) {
            if (state.detailStatus == DetailSellRequestStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.detailStatus == DetailSellRequestStatus.error) {
              return WarningLottie(
                firstLine: 'Có lỗi xảy ra',
                secondLine: 'Vui lòng thử lại sau',
              );
            } else if (state.detailStatus == DetailSellRequestStatus.loaded &&
                state.detailSellRequest != null) {
              final detailHistory = state.detailSellRequest;
              final postDto = detailHistory?.postDto;
              final motorbikedto = detailHistory?.motorbikeDto;
              List<String> image = detailHistory?.motorbikeImageDto
                      ?.map((e) => e.url ?? '')
                      .toList() ??
                  [];
              // final motorbikedto = detailHistory?.motorbikeDto;
              String createdDate = DateFormat('dd/MM/yyyy').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      int.parse(detailHistory?.createdDate.toString() ?? '0')));
              // final motorbikedto = detailHistory?.motorbikeDto;
              String approvedDate = DateFormat('dd/MM/yyyy').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      int.parse(detailHistory?.createdDate.toString() ?? '0')));
              // final motorbikedto = detailHistory?.motorbikeDto;
              final formattedCurrency =
                  NumberFormat.currency(locale: 'vi_VN', symbol: 'đ')
                      .format(detailHistory?.askingPrice);
              final statusMotorbike =
                  status.containsKey(detailHistory?.status ?? '')
                      ? status[detailHistory?.status ?? '']
                      : 'Đang cập nhật';
              final transactionDTOS = detailHistory?.transactionDtos ?? [];
              final requestHistoryDTOs =
                  detailHistory?.requestHistoryDtos ?? [];
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
                  SizedBox(height: 10),
                  CustomExpansionTile(
                    icon: Icons.info,
                    title: 'Thông tin bài đăng',
                    mapItem: {
                      'Ngày đăng': createdDate,
                      'Ngày duyệt': createdDate,
                      'Giá đề nghị': formattedCurrency,
                      'Trạng thái': statusMotorbike,
                      // 'Mô tả': postDto?.content ?? 'Đang cập nhật',
                    },
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
                  SizedBox(height: 10),
                  CustomExpansionCard(
                    icon: Icons.info,
                    title: 'Thông tin showroom',
                    showroomName:
                        detailHistory?.showroomDto?.name ?? 'Đang cập nhật',
                    showroomAddress:
                        detailHistory?.showroomDto?.address ?? 'Đang cập nhật',
                    showroomPhone:
                        detailHistory?.showroomDto?.phone ?? 'Đang cập nhật',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // lịch sử
                  requestHistoryDTOs.isNotEmpty
                      ? HistoryView(requestHistoryDTOs: requestHistoryDTOs)
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
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
                  //         'Thông tin đăng bán',
                  //         style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  //       ),
                  //       SizedBox(height: 10),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text('Ngày đăng', style: _leftStyle),
                  //           Text(formattedDateTime, style: _rightStyle),
                  //         ],
                  //       ),
                  //       SizedBox(height: 10),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text('Giá khách đề nghị', style: _leftStyle),
                  //           Text(formattedCurrency, style: _rightStyle),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  
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
                  //         'Mô tả',
                  //         style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  //       ),
                  //       Row(
                  //         children: [
                  //           Expanded(
                  //             child: Text(
                  //               postDto?.content ?? 'Đang cập nhật',
                  //               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
