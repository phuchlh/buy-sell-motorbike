part of "notification_cubit.dart";

enum NotificationStatus {
  initial,
  loading,
  loaded,
  error,
  notRunYet,
  noPopup,
}

class NotificationState extends Equatable {
  final NotificationDTO? popup;
  final int count;
  final NotificationStatus status;
  final List<NotificationDTO> notifications;
  final String msg;
  final int unSeen;

  const NotificationState({
    this.popup,
    this.status = NotificationStatus.initial,
    this.notifications = const <NotificationDTO>[],
    this.msg = "",
    this.count = 0,
    this.unSeen = 0,
  });

  NotificationState copyWith({
    NotificationDTO? popup,
    int? count,
    NotificationStatus? status,
    List<NotificationDTO>? notifications,
    String? msg,
    int? unSeen,
  }) {
    return NotificationState(
      popup: popup ?? this.popup,
      count: count ?? this.count,
      msg: msg ?? this.msg,
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      unSeen: unSeen ?? this.unSeen,
    );
  }

  @override
  List<Object?> get props => [
        popup,
        unSeen,
        count,
        status,
        notifications,
        msg,
      ];
}
