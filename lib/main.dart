import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app_pkg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageServiceImpl().initialize();
  await dotenv.load(fileName: ".env");
  await DependencyInjection.init();
  ErrorWidget.builder = (FlutterErrorDetails details) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.amberAccent.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          details.exception.toString(),
        ),
      );
  runApp(const ProviderScope(child: MyApp()));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10.0
    ..backgroundColor = Colors.transparent // ✅ Fully transparent background
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor =
        Colors.black.withOpacity(0.3) // ✅ Slightly transparent full-screen mask
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
