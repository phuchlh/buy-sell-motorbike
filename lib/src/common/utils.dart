import 'package:flutter/material.dart';

import 'custom_toast.dart';

Future<bool> onWillPop({
  required BuildContext context,
  required Function(DateTime?) action,
  DateTime? currentBackPressTime,
}) {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null || now.difference(currentBackPressTime) > const Duration(seconds: 3)) {
    action(now);
    customToast(context, "Nhấn lại để thoát");
    return Future.value(false);
  }
  return Future.value(true);
}

void pushNavigator(BuildContext currentBuildContext, Widget Function(BuildContext) builderCallBack) {
  Navigator.push(
      currentBuildContext,
      MaterialPageRoute(
        builder: builderCallBack,
      ));
}

void Function() pushNavigatorOnPressed(
    BuildContext currentBuildContext, Widget Function(BuildContext) builderCallBack) {
  return () {
    pushNavigator(currentBuildContext, builderCallBack);
  };
}
