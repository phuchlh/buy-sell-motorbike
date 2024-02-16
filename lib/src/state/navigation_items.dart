import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/authentication_controller.dart';

class NavigationItems extends ChangeNotifier {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static bool isLogged = false;

  Future<void> initialize() async {
    await toggleMode();
  }

  Future<bool> toggleMode() async {
    NavigationItems.isLogged = await AuthenticationController.isLoggedUser();
    print('is logged user: $isLogged');
    notifyListeners();
    return isLogged;
  }
}

final navigationItemsProviderChecked = ChangeNotifierProvider<NavigationItems>(
  (ref) {
    final navigationItems = NavigationItems();
    navigationItems.initialize();
    return navigationItems;
  },
);
final botnavOptionsProvider =
    ChangeNotifierProvider<NavigationItems>((ref) => NavigationItems());

class NavigationState extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

final navigationStateProvider = ChangeNotifierProvider<NavigationState>((ref) {
  return NavigationState();
});
