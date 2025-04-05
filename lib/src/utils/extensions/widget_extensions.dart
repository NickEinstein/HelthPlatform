import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

extension WidgetSpacing on num {
  SizedBox get spacingW => SizedBox(width: toDouble());
  SizedBox get spacingH => SizedBox(height: toDouble());
  Gap get gap => Gap(toDouble());
}

extension WidgetVisibility on Widget {
  Widget get visible => this;
  Widget get invisible => const SizedBox.shrink();

  Widget invisibleIf(bool condition) {
    if (condition) {
      return const SizedBox.shrink();
    } else {
      return this;
    }
  }
}

extension WidgetExtensions on Widget {
  Widget rotateDegrees(double angle) => Transform.rotate(
        angle: angle * (pi / 180),
        child: this,
      );
  Widget rotate(double angle) => Transform.rotate(
        angle: angle,
        child: this,
      );
}

extension WidgetPadding on Widget {
  Widget paddingAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget paddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget paddingOnly({
    double l = 0,
    double t = 0,
    double r = 0,
    double b = 0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: l,
          top: t,
          right: r,
          bottom: b,
        ),
        child: this,
      );
}

// align widget horizontal

extension WidgetAlignHorizontal on Widget {
  /// puts widget in a row and aligns it to the left
  Widget get alignLeft => Align(
        alignment: Alignment.centerLeft,
        child: this,
      );

  /// puts widget in a row and aligns it to the right
  Widget get alignRight => Align(
        alignment: Alignment.centerRight,
        child: this,
      );

  /// puts widget in a row and aligns it to the center
  Widget get alignCenter => Align(
        alignment: Alignment.center,
        child: this,
      );
}

extension TextWidgetExtensions on String {
  Widget textWithStyle(TextStyle style) => Text(
        this,
        style: style,
      );
}
