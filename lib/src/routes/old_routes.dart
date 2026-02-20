import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../routes/app_pages.dart';

class NavigationService {
  static GlobalKey<NavigatorState> get navigatorKey => rootNavigatorKey;
}

Future<T?> pushToWihRouteAndNavKey<T>(
    GlobalKey<NavigatorState> navKey, Route route) async {
  return await navKey.currentState!.push(route as Route<T>);
}

Future<T?> pushToWithNavKey<T>(GlobalKey<NavigatorState> navKey, Widget page,
    [PushStyle? pushStyle]) async {
  return await navKey.currentState!.push(pushStyle == PushStyle.cupertino
      ? CupertinoPageRoute(builder: (context) => page)
      : MaterialPageRoute(builder: (context) => page));
}

Future<T?> pushToAndRemoveUntilWithNavKey<T>(
    GlobalKey<NavigatorState> navKey, Widget page,
    [PushStyle? pushStyle]) async {
  return await navKey.currentState!.pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => page),
    (route) => false,
  );
}

Future<T?> pushToWithRoute<T>(Route route) async {
  return await Navigator.push<T>(
      NavigationService.navigatorKey.currentState!.context, route as Route<T>);
}

Future<T?> pushReplacementToWithRoute<T>(
    BuildContext context, Route route) async {
  return await Navigator.pushReplacement(
      NavigationService.navigatorKey.currentState!.context, route as Route<T>);
}

/// Pushes a new route onto the navigator that most tightly encloses the given context.
Future<T?> pushTo<T>(Widget page,
    [BuildContext? context, PushStyle? pushStyle]) async {
  return await Navigator.push(
      NavigationService.navigatorKey.currentState!.context,
      pushStyle == PushStyle.cupertino
          ? CupertinoPageRoute(builder: (context) => page)
          : MaterialPageRoute(builder: (context) => page));
}

/// Pushes the given [page] to the navigator and clears the current [page] from the stack
Future<T?> pushReplacementTo<T>(Widget page,
    [BuildContext? context, PushStyle? pushStyle]) async {
  log('PushReplacementTo to [$page]\n${StackTrace.current.toString().split('\n')[1]}');

  return await Navigator.pushReplacement(
      NavigationService.navigatorKey.currentState!.context,
      pushStyle == PushStyle.cupertino
          ? CupertinoPageRoute(builder: (context) => page)
          : MaterialPageRoute(builder: (context) => page));
}

/// Pushes the given [page] to the navigator and clears the stack
void pushToAndClearStack(Widget page) {
  log('PushToAndClearStack to [$page]\n${StackTrace.current.toString().split('\n')[1]}');
  //log('PushToAndClearStack to [$page]');

  Navigator.of(NavigationService.navigatorKey.currentState!.context)
      .pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => page), (route) => false);
}

/// Removes the current [page] from the stack
void pop<T>([T? value]) {
  //log('Pop to [${}]');

  return Navigator.pop(
      NavigationService.navigatorKey.currentState!.context, value);
}

/// Removes the current [page] from the stack
// void popDialog<T>([T? value]) {
//   // check if stack has dialog and pop that

// }

enum PushStyle { material, cupertino }

class CustomRoutes {
  static Route fadeIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = 0.0;
        var end = 1.0;
        var curve = Curves.easeInExpo;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return FadeTransition(
          opacity: animation.drive(tween),
          child: page,
        );
      },
    );
  }

  static Route slideIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(seconds: 4),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = const Offset(10, 0);
        var end = Offset.zero;
        var curve = Curves.easeInExpo;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: page,
        );
      },
    );
  }

  static Route slideUp(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = const Offset(0, 1);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: page,
        );
      },
    );
  }
}

GestureDetector backButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      pop();
    },
    child: const Align(
      alignment: Alignment.centerLeft,
      child: Icon(
        Icons.arrow_back,
        size: 20,
      ),
    ),
  );
}
