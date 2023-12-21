import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:buy_sell_motorbike/src/blocs/cubit/buy-request-history.dart/buy_request_history_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/buy-request/buy_request_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/comment/comment_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/motorbike/motorbike_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/motorbrand/motorbrand_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/post/post_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/refactor_code/change_page_user_logged_in_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/refactor_code/selected_index_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/sell-request/sell_request_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/showroom/showroom_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/user/user_cubit.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "buysell_app",
    options: FirebaseOptions(
      apiKey: "AIzaSyAadcC3hIVA0_4rF4kAoicRMU-ErgVKtcI",
      appId: "1:1013521465600:android:d28bc3a285db9d5e6333e5",
      messagingSenderId: "1013521465600",
      storageBucket: "buy-sell-motor.appspot.com",
      projectId: "buy-sell-motor",
    ),
  );
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.

  configLoading();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MotorbikeCubit()),
        BlocProvider(create: (_) => PostCubit()),
        BlocProvider(create: (_) => ShowroomCubit()),
        BlocProvider(create: (_) => MotorBrandCubit()),
        BlocProvider(create: (_) => BuyRequestCubit()),
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => CommentCubit()),
        BlocProvider(create: (_) => SelectedIndexCubit()),
        BlocProvider(create: (_) => ChangePageLoggedIn()),
        BlocProvider(create: (_) => SellRequestHistoryCubit()),
        BlocProvider(create: (_) => BuyRequestHistoryCubit()),
      ],
      child: ProviderScope(
        child: MyApp(settingsController: settingsController),
      ),
    ),
  );
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
