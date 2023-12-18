import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/refactor_code/selected_index_cubit.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';
import 'package:buy_sell_motorbike/src/components/user_setting_page.dart';
import 'package:buy_sell_motorbike/src/pages/home_page.dart';
import 'package:buy_sell_motorbike/src/pages/post_page.dart';
import 'package:buy_sell_motorbike/src/pages/post_page_not_login.dart';
import 'package:buy_sell_motorbike/src/pages/showrooms_page.dart';
import 'package:buy_sell_motorbike/src/pages/user_page.dart';
import 'package:buy_sell_motorbike/src/state/navigation_items.dart';

class BotNavBar extends ConsumerWidget {
  const BotNavBar({super.key});

  final contentWidgetLogged = const [
    HomePage(),
    ShowroomsPage(),
    PostPage(),
    UserSettingPage(),
  ];
  final contentWidgetNotLogged = const [
    HomePage(),
    ShowroomsPage(),
    UserPage(),
  ];

  final navItemLogged = const [
    NavigationDestination(icon: Icon(Icons.home), label: "Trang chủ"),
    NavigationDestination(icon: Icon(Icons.storefront_outlined), label: "Cửa hàng"),
    NavigationDestination(icon: Icon(Icons.add), label: "Bán xe"),
    NavigationDestination(icon: Icon(Icons.person_outline), label: "Người dùng"),
  ];
  final navItemNotLogged = const [
    NavigationDestination(icon: Icon(Icons.home), label: "Trang chủ"),
    NavigationDestination(icon: Icon(Icons.storefront_outlined), label: "Cửa hàng"),
    NavigationDestination(icon: Icon(Icons.person_outline), label: "Người dùng"),
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationStateProvider);
    final botnavOptions = ref.watch(botnavOptionsProvider);
    final checked = ref.watch(navigationItemsProviderChecked);
    print('checked value: ${checked}');
    return Scaffold(
      body: IndexedStack(
        index: navigationState.selectedIndex,
        children: NavigationItems.isLogged == true ? contentWidgetLogged : contentWidgetNotLogged,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: DesignConstants.primaryColor,
        onDestinationSelected: (index) {
          // Call the method from the cubit
          navigationState.updateSelectedIndex(index);
        },
        selectedIndex: navigationState.selectedIndex,
        destinations: NavigationItems.isLogged == true ? navItemLogged : navItemNotLogged,
      ),
    );
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