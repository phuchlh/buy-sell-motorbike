// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buy_sell_motorbike/logger.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/notification/notification_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/refactor_code/selected_index_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/user/user_cubit.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';
import 'package:buy_sell_motorbike/src/pages/notification_page.dart';
import 'package:buy_sell_motorbike/src/components/user_setting_page.dart';
import 'package:buy_sell_motorbike/src/pages/home_page.dart';
import 'package:buy_sell_motorbike/src/pages/post_page.dart';
import 'package:buy_sell_motorbike/src/pages/post_page_not_login.dart';
import 'package:buy_sell_motorbike/src/pages/showrooms_page.dart';
import 'package:buy_sell_motorbike/src/pages/user_page.dart';
import 'package:buy_sell_motorbike/src/state/navigation_items.dart';
import 'package:badges/badges.dart' as badge;

class BotNavBar extends ConsumerWidget {
  BotNavBar({super.key, required this.notificationCount});
  final int notificationCount;

  final contentWidgetLogged = const [
    HomePage(),
    ShowroomsPage(),
    PostPage(),
    NotificationPage(),
    UserSettingPage(),
  ];
  final contentWidgetNotLogged = const [
    HomePage(),
    ShowroomsPage(),
    UserPage(),
  ];

  final navItemNotLogged = const [
    NavigationDestination(icon: Icon(Icons.home_outlined), label: "Trang chủ"),
    NavigationDestination(
        icon: Icon(Icons.storefront_outlined), label: "Cửa hàng"),
    NavigationDestination(
        icon: Icon(Icons.person_outline), label: "Người dùng"),
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationStateProvider);
    final botnavOptions = ref.watch(botnavOptionsProvider);
    final checked = ref.watch(navigationItemsProviderChecked);
    Logger.log('check isLogged in botnav.dart: ${NavigationItems.isLogged}');
    print('checked value: ${checked}');
    return BlocListener<UserCubit, UserState>(
      listener: (context, userState) {},
      child: Scaffold(
        body: IndexedStack(
          index: navigationState.selectedIndex,
          children: NavigationItems.isLogged == true
              ? contentWidgetLogged
              : contentWidgetNotLogged,
        ),
        bottomNavigationBar: Consumer(
          builder: (context, watch, child) {
            final navItemLogged = [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined), label: "Trang chủ"),
              NavigationDestination(
                  icon: Icon(Icons.storefront_outlined), label: "Cửa hàng"),
              NavigationDestination(icon: Icon(Icons.add), label: "Bán xe"),
              notificationCount != 0
                  ? badge.Badge(
                      position: badge.BadgePosition.topEnd(top: -1, end: 10),
                      badgeAnimation: badge.BadgeAnimation.rotation(
                        animationDuration: Duration(seconds: 1),
                        colorChangeAnimationDuration: Duration(seconds: 1),
                        loopAnimation: false,
                        curve: Curves.fastOutSlowIn,
                        colorChangeAnimationCurve: Curves.easeInCubic,
                      ),
                      badgeContent: Text(
                        notificationCount.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      child: NavigationDestination(
                          icon: Icon(Icons.notifications_outlined),
                          label: "Thông báo"),
                    )
                  : NavigationDestination(
                      icon: Icon(Icons.notifications_outlined),
                      label: "Thông báo"),
              NavigationDestination(
                  icon: Icon(Icons.person_outline), label: "Người dùng"),
            ];
            Logger.log('check isLogged in botnav.dart: $notificationCount');

            return NavigationBar(
              backgroundColor: Colors.white,
              indicatorColor: DesignConstants.primaryColor,
              onDestinationSelected: (index) {
                navigationState.updateSelectedIndex(index);
              },
              selectedIndex: navigationState.selectedIndex,
              destinations: NavigationItems.isLogged == true
                  ? navItemLogged
                  : navItemNotLogged,
            );
          },
        ),
      ),
    );

    // Scaffold(
    //   body: IndexedStack(
    //     index: navigationState.selectedIndex,
    //     children: NavigationItems.isLogged == true ? contentWidgetLogged : contentWidgetNotLogged,
    //   ),
    //   bottomNavigationBar: Consumer(
    //     builder: (context, watch, child) {
    //       final navItemLogged = [
    //         NavigationDestination(icon: Icon(Icons.home), label: "Trang chủ"),
    //         NavigationDestination(icon: Icon(Icons.storefront_outlined), label: "Cửa hàng"),
    //         NavigationDestination(icon: Icon(Icons.add), label: "Bán xe"),
    //         notificationCount != 0
    //             ? badge.Badge(
    //                 position: badge.BadgePosition.topEnd(top: -1, end: 10),
    //                 badgeAnimation: badge.BadgeAnimation.rotation(
    //                   animationDuration: Duration(seconds: 1),
    //                   colorChangeAnimationDuration: Duration(seconds: 1),
    //                   loopAnimation: false,
    //                   curve: Curves.fastOutSlowIn,
    //                   colorChangeAnimationCurve: Curves.easeInCubic,
    //                 ),
    //                 badgeContent: Text(
    //                   notificationCount.toString(),
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //                 child: NavigationDestination(
    //                     icon: Icon(Icons.notifications_outlined), label: "Thông báo"),
    //               )
    //             : NavigationDestination(
    //                 icon: Icon(Icons.notifications_outlined), label: "Thông báo"),
    //         NavigationDestination(icon: Icon(Icons.person_outline), label: "Người dùng"),
    //       ];
    //       Logger.log('check isLogged in botnav.dart: $notificationCount');

    //       return NavigationBar(
    //         backgroundColor: Colors.white,
    //         indicatorColor: DesignConstants.primaryColor,
    //         onDestinationSelected: (index) {
    //           navigationState.updateSelectedIndex(index);
    //         },
    //         selectedIndex: navigationState.selectedIndex,
    //         destinations: NavigationItems.isLogged == true ? navItemLogged : navItemNotLogged,
    //       );
    //     },
    //   ),
    // );
  }
}

    // BlocBuilder<SelectedIndexCubit, int>(
    //   builder: (context, selectedIndex) {
    //     // Use selectedIndex instead of _selectedIndex
    //     return Scaffold(
    //       body: Center(
    //         child: botnavOptions.value?.elementAt(selectedIndex), // widget khi bấm 1 index nào đ
    //         // child: botnavOptions.value?.elementAt(selectedIndex),
    //       ),
    //       bottomNavigationBar: NavigationBar(
    //         backgroundColor: Colors.white,
    //         indicatorColor: DesignConstants.primaryColor,
    //         onDestinationSelected: (index) {
    //           // Call the method from the cubit
    //           context.read<SelectedIndexCubit>().updateSelectedIndex(index);
    //         },
    //         selectedIndex: selectedIndex,
    //         destinations: const [
    //           NavigationDestination(icon: Icon(Icons.home), label: "Trang chủ"),
    //           NavigationDestination(icon: Icon(Icons.storefront_outlined), label: "Cửa hàng"),
    //           NavigationDestination(icon: Icon(Icons.add), label: "Bán xe"),
    //           NavigationDestination(icon: Icon(Icons.person_outline), label: "Người dùng"),
    //         ],
    //       ),
    //     );
    //   },
    // );


    
  // final navItemLogged = [
  //   NavigationDestination(icon: Icon(Icons.home), label: "Trang chủ"),
  //   NavigationDestination(icon: Icon(Icons.storefront_outlined), label: "Cửa hàng"),
  //   NavigationDestination(icon: Icon(Icons.add), label: "Bán xe"),
  //   notificationCount != 0
  //       ? badge.Badge(
  //           position: badge.BadgePosition.topEnd(top: -1, end: 10),
  //           badgeAnimation: badge.BadgeAnimation.rotation(
  //             animationDuration: Duration(seconds: 1),
  //             colorChangeAnimationDuration: Duration(seconds: 1),
  //             loopAnimation: false,
  //             curve: Curves.fastOutSlowIn,
  //             colorChangeAnimationCurve: Curves.easeInCubic,
  //           ),
  //           badgeContent: Text(
  //             notificationCount.toString(),
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           child:
  //               NavigationDestination(icon: Icon(Icons.notifications_outlined), label: "Thông báo"),
  //         )
  //       : NavigationDestination(icon: Icon(Icons.notifications_outlined), label: "Thông báo"),
  //   NavigationDestination(icon: Icon(Icons.person_outline), label: "Người dùng"),
  // ];