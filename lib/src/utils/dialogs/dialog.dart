/// The above class provides methods to show loading dialogs and snackbars with different types of
/// messages in a Flutter app.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

import '../../routes/old_routes.dart';

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

  static void showErrorSnackbar({
    required String message,
  }) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void showSnackbar({
    required String message,
  }) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        // backgroundColor: Colors.red,
      ),
    );
  }

  static void showSuccessSnackbar({
    required String message,
  }) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  static Future openBottomSheet({
    bool showBar = false,
    List<Widget>? children,
    Widget? child,
  }) {
    return showModalBottomSheet(
      context: NavigationService.navigatorKey.currentState!.context,
      barrierColor: const Color(0x9C009006),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return CustomBottomSheet(
          showBar: showBar,
          children: children,
          child: child,
        );
      },
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  final bool showBar;
  final List<Widget>? children;
  final Widget? child;
  const CustomBottomSheet({
    super.key,
    this.showBar = true,
    this.children,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(),
              if (showBar)
                Container(
                  width: 80,
                  height: 4,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE2E2E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ).alignCenter,
              if (children != null) ...children!,
              if (child != null) child!,
            ],
          ),
        ),
      ],
    );
  }
}
