import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cubit/notification/notification_cubit.dart';
import '../pages/buy_request_history.dart';
import '../pages/detail_buy_history.dart';
import '../pages/detail_sell_history.dart';
import '../pages/sell_request_history.dart';

import 'package:timeago/timeago.dart' as timeago;

class NotificationPopUp extends StatelessWidget {
  const NotificationPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18);
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        final popupNoti = state.popup;
        String notiType = popupNoti?.requestType ?? "Thông báo";
        DateTime datetime = DateTime.fromMillisecondsSinceEpoch(
            int.parse(popupNoti?.notificationDate.toString() ?? '0'));

        return GestureDetector(
          onTap: () async {
            if (popupNoti!.isSeen == false) {
              await context
                  .read<NotificationCubit>()
                  .updateStatusNotification(popupNoti.id!);
            }
            if (notiType == "SELL_REQUEST") {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailSellHistory(
                          requestID: popupNoti.requestId.toString(),
                        )),
              );
            } else if (notiType == "BUY_REQUEST") {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailBuyHistory(
                        requestID: popupNoti.requestId.toString())),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Container(
                  height: double
                      .infinity, // Provide a specific height to the Container
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_outlined),
                    ],
                  ),
                ),
                title: notiType == "SELL_REQUEST"
                    ? Text(
                        "Yêu cầu bán xe",
                        style: titleStyle,
                      )
                    : notiType == "B_REQUEST"
                        ? Text(
                            "Yêu cầu xem xe",
                            style: titleStyle,
                          )
                        : Text(
                            "Thông báo",
                            style: titleStyle,
                          ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      popupNoti?.notificationContent ?? "",
                      maxLines: 3,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(timeago.format(datetime, locale: 'vi')),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DumpNoti {
  int? id;
  String? requestType;
  String? notificationContent;
  String? notificationDate;
  bool? isNotified;
  bool? isSeen;
  int? customerId;
  int? requestId;

  DumpNoti(
      {this.id,
      this.requestType,
      this.notificationContent,
      this.notificationDate,
      this.isNotified,
      this.isSeen,
      this.customerId,
      this.requestId});
}

// test noti
/*
final dumpNoti = DumpNoti(
      id: 235,
      requestType: "BUY_REQUEST",
      notificationContent: "Yêu cầu bán xe #108: Đã được nhận xe!",
      notificationDate: "1704627122854",
      isNotified: true,
      isSeen: false,
      customerId: 4,
    );
    final titleStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18);
    // return BlocBuilder<NotificationCubit, NotificationState>(
    //   builder: (context, state) {
    //     final popupNoti = state.popup;
    //     String notiType = popupNoti?.requestType ?? "Thông báo";
    DateTime datetime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(dumpNoti.notificationDate.toString() ?? '0'));

    return GestureDetector(
      onTap: () async {
        if (dumpNoti.isSeen == false) {
          // await context.read<NotificationCubit>().updateStatusNotification(popupNoti.id!);
        }
        if (dumpNoti.requestType == "SELL_REQUEST") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SellRequestHistory()),
          );
        } else if (dumpNoti.requestType == "BUY_REQUEST") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BuyRequestHistory()),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Container(
              height: double.infinity, // Provide a specific height to the Container
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_outlined),
                ],
              ),
            ),
            title: dumpNoti.requestType == "SELL_REQUEST"
                ? Text(
                    "Yêu cầu bán xe",
                    style: titleStyle,
                  )
                : dumpNoti.requestType == "B_REQUEST"
                    ? Text(
                        "Yêu cầu xem xe",
                        style: titleStyle,
                      )
                    : Text(
                        "Thông báo",
                        style: titleStyle,
                      ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dumpNoti.notificationContent ?? "",
                  maxLines: 3,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(timeago.format(datetime, locale: 'vi')),
              ],
            ),
          ),
        ),
      ),
    );
    },
    );
*/