import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/utils/custom_toast.dart';

extension ContextExtension on BuildContext {
  showFeedBackDialog({
    required String message,
    ToastType toastType = ToastType.warning,
  }) {
    CustomToast.show(this, message, type: toastType);
  }
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  Size get appScreenSize => MediaQuery.of(this).size;
}

extension Lists on List {
  bool hasNextItem(item) {
    return indexOf(item) < length - 1;
  }

  bool hasPreviousItem(item) {
    return indexOf(item) > 0;
  }

  bool hasNextIndex(int index) {
    return index < length - 1;
  }

  bool hasPreviousIndex(int index) {
    return index > 0;
  }

  nextItem(item) {
    return this[indexOf(item) + 1];
  }
}
