import 'dart:math';

import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:greenzone_medical/src/utils/responsive.dart';

extension ResponsiveNum on num {
  double get w => Responsive.w(toDouble());
  double get h => Responsive.h(toDouble());
  double get sp => Responsive.sp(toDouble());
}

extension WidgetSpacing on num {
  SizedBox get spacingW => SizedBox(width: toDouble());
  SizedBox get spacingH => SizedBox(height: toDouble());
  Gap get gap => Gap(toDouble());
  //
  SizedBox get height => SizedBox(height: toDouble().h);
  SizedBox get width => SizedBox(width: toDouble().w);
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

  Widget shimmer({
    bool isLoading = true,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: baseColor ?? Colors.grey[300]!,
            highlightColor: highlightColor ?? Colors.grey[100]!,
            child: this,
          )
        : this;
  }
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
