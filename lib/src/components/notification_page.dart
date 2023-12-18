import 'package:flutter/material.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Thông Báo của bạn'),
            backgroundColor: DesignConstants.primaryColor,
            foregroundColor: Colors.black),
        body: _NotificationPageComponents.notifications);
  }
}

class _NotificationPageComponents {
  static createPromotionNotification(
          {String promotionTitle = "Promotion", String content = "", bool alreadyRead = false}) =>
      Card(
          child: ListTile(
        title: Text(promotionTitle),
        subtitle: Text(content),
        trailing: const Icon(Icons.redeem_outlined, color: DesignConstants.primaryColor, size: 40),
        selectedTileColor: Colors.yellowAccent.shade100,
        selected: alreadyRead,
      ));

  static final dynamic notifications = ListView(
    padding: const EdgeInsets.all(8),
    children: [
      createNotificationItem(title: "Thông báo", message: "Nội dung thông báo"),
      createNotificationItem(title: "Thông báo 2", message: "Nội dung thông báo dài hơn"),
      createNotificationItem(
          title: "Thông báo chưa được đọc",
          message: "Thẻ thông báo sẽ có màu vàng",
          alreadyRead: true),
      createPromotionNotification(promotionTitle: "Ưu đãi của tôi", content: "Nội dung ưu đãi")
    ],
  );

  static createNotificationItem(
          {String title = "Notification", String message = "", bool alreadyRead = false}) =>
      Card(
          child: ListTile(
        title: Text(title),
        subtitle: Text(message),
        trailing: const Icon(Icons.more_vert),
        selectedTileColor: Colors.yellowAccent.shade100,
        selected: alreadyRead,
      ));
}
