import 'package:flutter/material.dart';
import '../model/response/request_history_dtos.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key, required this.requestHistoryDTOs});
  final List<RequestHistoryDtos> requestHistoryDTOs;

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: const Text(
              "Lịch sử",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.only(top: 8, left: 8),
            shrinkWrap: true,
            itemCount: widget.requestHistoryDTOs.length,
            itemBuilder: (context, index) {
              final item = widget.requestHistoryDTOs[index];
              final isLast = index == widget.requestHistoryDTOs.length - 1;
              final first = index == 0;
              return TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.3,
                beforeLineStyle: LineStyle(
                  color: Colors.grey.withOpacity(0.3),
                  thickness: 3,
                ),
                afterLineStyle: LineStyle(
                  color: Colors.grey.withOpacity(0.3),
                  thickness: 3,
                ),
                isFirst: first,
                isLast: isLast,
                startChild: Align(
                  alignment: const Alignment(0.0, -0.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        _formatDate(item.createdDate ?? "Updating").$1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: first ? Colors.black : Colors.grey,
                        ),
                      ),
                      Text(
                        _formatDate(item.createdDate ?? "Updating").$2,
                        style: TextStyle(
                          fontSize: 15,
                          color: first ? Colors.black : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                indicatorStyle: IndicatorStyle(
                  width: first ? 20 : 10,
                  height: first ? 20 : 10,
                  indicatorXY: 0.2,
                  indicator: _buildIndicator(first),
                ),
                endChild: _buildTimelineContent(item, first),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isFirst) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFirst ? Colors.green : Colors.grey,
      ),
      child: Center(
        child: Icon(
          isFirst ? Icons.check : null,
          color: Colors.white,
          size: isFirst ? 15 : 5,
        ),
      ),
    );
  }

  Widget _buildTimelineContent(RequestHistoryDtos item, bool isFirst) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      padding: isFirst ? null : const EdgeInsets.only(left: 8),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.content ?? "Updating",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isFirst ? Colors.black : Colors.grey),
          ),
        ],
      ),
    );
  }

  (String, String) _formatDate(String timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    final formattedDate = '${date.day}/${date.month}/${date.year}';
    final formattedTime = '${date.hour}:${date.minute}';
    return (formattedDate, formattedTime);
  }
}
