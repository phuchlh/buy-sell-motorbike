import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:intl/intl.dart';
import '../../logger.dart';
import '../blocs/cubit/notification/notification_cubit.dart';
import '../common/utils.dart';
import '../components/in_app_noti.dart';
import 'buy_request_history.dart';
import 'detail_buy_history.dart';
import 'detail_sell_history.dart';
import 'sell_request_history.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../blocs/cubit/user/user_cubit.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future<void> _loadNotification() async {
    await context.read<NotificationCubit>().getNotifications();
  }

// *noti json data sample
// {
//   "id": 235,
//   "requestType": "SELL_REQUEST",
//   "notificationContent": "Yêu cầu bán xe #108: Đã được nhận xe!",
//   "notificationDate": "1704627122854",
//   "isNotified": true,
//   "isSeen": false,
//   "customerId": 4
// }

  Timer? _timer;
  Future<void> _loadPopup() async {
    // if (context.read<UserCubit>().state.user != null) {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) async {
        final checkStatus =
            await context.read<NotificationCubit>().getPopupNotification();

        // Check the status and handle it appropriately
        if (checkStatus == NotificationStatus.loaded) {
          InAppNotification.show(
            child: NotificationPopUp(),
            context: context,
            duration: Duration(seconds: 3),
          );
          await context.read<NotificationCubit>().getNotifications();
        } else if (checkStatus == NotificationStatus.noPopup) {
          Logger.log('No notification found');
        } else {
          Logger.log('Error while loading notification');
        }
      },
    );
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadNotification();
    _loadPopup();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }

  final titleStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông báo"),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => InAppNotification.show(
      //     duration: const Duration(seconds: 5),
      //     context: context,
      //     child: NotificationPopUp(),
      //   ),
      //   child: const Icon(Icons.add),
      // ),
      body: RefreshIndicator(
        onRefresh: _loadNotification,
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            final listNoti = state.notifications;
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemCount: listNoti.length,
              itemBuilder: (_, index) {
                String notiType = listNoti[index].requestType ?? "Thông báo";
                DateTime datetime = DateTime.fromMillisecondsSinceEpoch(
                    int.parse(
                        listNoti[index].notificationDate.toString() ?? '0'));
                Logger.log(
                    'query ${MediaQuery.of(context).size.height.toString()}');
                return Container(
                  height: MediaQuery.of(context).size.height * .106,
                  decoration: listNoti[index].isSeen!
                      ? BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(10),
                        )
                      : BoxDecoration(
                          color: Color(0xFFfff3bf),
                          borderRadius: BorderRadius.circular(10),
                        ),
                  child: GestureDetector(
                      onTap: () async {
                        Logger.log('isSeen: $listNoti[index].isSeen!');
                        if (listNoti[index].isSeen! == false) {
                          await context
                              .read<NotificationCubit>()
                              .updateStatusNotification(listNoti[index].id!);
                        }
                        if (notiType == "SELL_REQUEST") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailSellHistory(
                                      requestID:
                                          listNoti[index].requestId.toString(),
                                    )),
                          );
                        } else if (notiType == "BUY_REQUEST") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailBuyHistory(
                                    requestID:
                                        listNoti[index].requestId.toString())),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.notifications_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              notiType == "SELL_REQUEST"
                                  ? Text(
                                      "Yêu cầu bán xe",
                                      style: titleStyle,
                                    )
                                  : notiType == "BUY_REQUEST"
                                      ? Text(
                                          "Yêu cầu xem xe",
                                          style: titleStyle,
                                        )
                                      : Text(
                                          "Thông báo",
                                          style: titleStyle,
                                        ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                listNoti[index].notificationContent ?? "",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(timeago.format(datetime, locale: 'vi')),
                            ],
                          ),
                        ],
                      )),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
