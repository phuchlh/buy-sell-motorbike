import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/sell-request/sell_request_cubit.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';
import 'package:buy_sell_motorbike/src/components/promotion_banner.dart';
import 'package:buy_sell_motorbike/src/model/response/sell_request_response.dart';
import 'package:buy_sell_motorbike/src/pages/sell_request_history.dart';

class DetailSellHistory extends StatefulWidget {
  const DetailSellHistory({super.key, required this.sellRequest});
  final SellRequestHistoryDTO sellRequest;

  @override
  State<DetailSellHistory> createState() => _DetailSellHistoryState();
}

class _DetailSellHistoryState extends State<DetailSellHistory> {
  Future<void> _loadData() async {
    await context
        .read<SellRequestHistoryCubit>()
        .getSellRequestById(widget.sellRequest.id.toString());
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
        child: BlocBuilder<SellRequestHistoryCubit, SellRequestHistoryState>(
          builder: (context, state) {
            if (state.status == SellRequestHistoryStatus.loading ||
                state.status == SellRequestHistoryStatus.loadingDetail) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == SellRequestHistoryStatus.loaded ||
                state.status == SellRequestHistoryStatus.loadDetailSuccess &&
                    state.detailSellRequest != null) {
              final detailHistory = state.detailSellRequest;
              final postDto = detailHistory?.postDto;
              List<String> image =
                  detailHistory?.motorbikeImageDto?.map((e) => e.url ?? '').toList() ?? [];
              // final motorbikedto = detailHistory?.motorbikeDto;
              String formattedDateTime = DateFormat('dd/MM/yyyy').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      int.parse(detailHistory?.createdDate.toString() ?? '0')));
              // final motorbikedto = detailHistory?.motorbikeDto;
              final formattedCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ')
                  .format(detailHistory?.askingPrice);
              return Column(
                children: [
                  PromotionBanner(
                    height: 220,
                    children: image,
                    isLocalFile: false,
                  ),
                  const SizedBox(height: 10),
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
                          'Thông tin đăng bán',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Ngày đăng', style: _leftStyle),
                            Text(formattedDateTime, style: _rightStyle),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Giá khách đề nghị', style: _leftStyle),
                            Text(formattedCurrency, style: _rightStyle),
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
                          'Mô tả',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                postDto?.content ?? 'Đang cập nhật',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                              ),
                            ),
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
                    child: ListTile(
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
                  ),
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
