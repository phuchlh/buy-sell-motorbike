import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../logger.dart';
import '../model/response/transaction_dto.dart';

class TransactionCustomExpansion extends StatelessWidget {
  const TransactionCustomExpansion({
    super.key,
    required this.transaction,
    required this.icon,
    required this.title,
  });
  final List<TransactionDtos>? transaction;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
      child: ExpansionTile(
        shape: Border(),
        initiallyExpanded: false,
        leading: Icon(icon),
        title: Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        children: _buildItem(),
      ),
    );
  }

  List<Widget> _buildItem() {
    List<Widget> list = [];
    int length = transaction!.length;
    int count = 0;
    transaction!.forEach((element) {
      final formattedCurrency =
          NumberFormat.currency(locale: 'vi_VN', symbol: 'đ')
              .format(element.amount);
      ++count;
      String recordedDate = DateFormat('dd-MM-yyyy hh:mm').format(
          DateTime.fromMillisecondsSinceEpoch(
              int.parse(element?.recordedDate ?? '0')));
      list.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              // color: Colors.grey[200],
              child: Stack(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Chuyển tiền đến ${element.targetAccountHolder}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            _richText('Nội dung: ', element.description ?? ""),
                            SizedBox(height: 5),
                            Text(recordedDate,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    bottom: 15,
                    child: Text(
                      '$formattedCurrency',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            if (count != length)
              Divider(
                height: 1,
                thickness: 1,
              ),
          ],
        ),
      );
    });
    return list;
  }

  Widget _richText(String title, String content) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 14, color: Colors.grey),
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: content,
          ),
        ],
      ),
    );
  }
}
