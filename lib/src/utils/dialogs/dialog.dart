/// The above class provides methods to show loading dialogs and snackbars with different types of
/// messages in a Flutter app.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Dialogs {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void showLoadingDialog() {
    final context = navigatorKey.currentState?.context;
    if (context == null) return; // Prevent null context crash

    showDialog(
      context: context,
      barrierColor:
          Colors.black.withOpacity(0.5), // Full-screen semi-transparent overlay
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  static void pop<T>([T? value]) {
    //log('Pop to [${}]');

    return Navigator.pop(navigatorKey.currentState!.context, value);
  }

  static void hideLoadingDialog() {
    if (navigatorKey.currentState?.overlay?.context != null) {
      Navigator.of(navigatorKey.currentState!.overlay!.context).pop();
    }
  }
}
