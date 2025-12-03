import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app_pkg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(); // 🔒 Ensure Firebase is ready

  await dotenv.load(fileName: ".env");
  await StorageServiceImpl().initialize();
  await DependencyInjection.init();

// TODO: revert
  // ErrorWidget.builder = (FlutterErrorDetails details) => Container(
  //       padding: const EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         color: Colors.amberAccent.shade400,
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: Text(details.exception.toString()),
  //     );

  configLoading();

  runApp(const ProviderScope(child: MyApp()));

  // runZonedGuarded(() async {
  //   WidgetsFlutterBinding.ensureInitialized();

  //   await Firebase.initializeApp(); // 🔒 Ensure Firebase is ready

  //   await dotenv.load(fileName: ".env");
  //   await StorageServiceImpl().initialize();
  //   await DependencyInjection.init();

  //   ErrorWidget.builder = (FlutterErrorDetails details) => Container(
  //         padding: const EdgeInsets.all(10),
  //         decoration: BoxDecoration(
  //           color: Colors.amberAccent.shade400,
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: Text(details.exception.toString()),
  //       );

  //   configLoading();
  //   FlutterError.onError = (FlutterErrorDetails details) {
  //     // Log Flutter errors
  //     FlutterError.dumpErrorToConsole(details);
  //     // You can send to Crashlytics or Sentry here
  //   };

  //   runApp(const ProviderScope(child: MyApp()));
  // }, (error, stack) {
  //   // Log uncaught async errors
  //   print('Unhandled error: $error');
  // });
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10.0
    ..backgroundColor = Colors.transparent // ✅ Fully transparent background
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.black
        .withValues(alpha: 0.3) // ✅ Slightly transparent full-screen mask
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
