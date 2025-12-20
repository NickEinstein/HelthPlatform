import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Screen size categories based on Material Design breakpoints
enum ScreenType {
  small, // < 360dp (small phones)
  medium, // 360-600dp (phones)
  large, // 600-1200dp (tablets)
  extraLarge, // > 1200dp (desktop)
}

class Responsive {
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _scaleWidth;
  static late double _scaleHeight;
  static late ScreenType _screenType;

  // Scaling constraints for different element types
  static const double _fontScaleMin = 0.9;
  static const double _fontScaleMax = 1.2;

  static const double _sizeScaleMin = 0.85;
  static const double _sizeScaleMax = 1.5;

  static const double _spaceScaleMin = 0.8;
  static const double _spaceScaleMax = 2.0;

  /// Initialize the responsive system
  ///
  /// Must be called before using any responsive methods.
  /// Typically called in the build method of your root widget.
  ///
  /// [designWidth] and [designHeight] should match your design mockup dimensions
  static void init(
    BuildContext context, {
    double designWidth = 375,
    double designHeight = 812,
  }) {
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;

    // Determine screen category
    if (_screenWidth < 360) {
      _screenType = ScreenType.small;
    } else if (_screenWidth < 600) {
      _screenType = ScreenType.medium;
    } else if (_screenWidth < 1200) {
      _screenType = ScreenType.large;
    } else {
      _screenType = ScreenType.extraLarge;
    }

    _scaleWidth = _screenWidth / designWidth;
    _scaleHeight = _screenHeight / designHeight;
  }

  // ============ WIDTH SCALING ============

  /// Scale width with automatic clamping based on screen type
  static double w(double width) {
    final scaled = width * _scaleWidth;

    switch (_screenType) {
      case ScreenType.small:
        // Small screens: allow slight shrinking, minimal growth
        return scaled.clamp(width * _sizeScaleMin, width * 0.95);
      case ScreenType.medium:
        // Medium screens: modest scaling in both directions
        return scaled.clamp(width * 0.9, width * 1.1);
      case ScreenType.large:
        // Tablets: prevent shrinking, allow moderate growth
        return scaled.clamp(width * 1.0, width * 1.3);
      case ScreenType.extraLarge:
        // Desktop: use the max constraint to cap growth
        return scaled.clamp(width * 1.0, width * _sizeScaleMax);
    }
  }

  /// Scale width with custom min/max constraints
  static double wClamped(double width, {double? min, double? max}) {
    final scaled = width * _scaleWidth;
    if (min != null && max != null) {
      return scaled.clamp(min, max);
    } else if (min != null) {
      return math.max(scaled, min);
    } else if (max != null) {
      return math.min(scaled, max);
    }
    return scaled;
  }

  // ============ HEIGHT SCALING ============

  /// Scale height with automatic clamping based on screen type
  static double h(double height) {
    final scaled = height * _scaleHeight;

    switch (_screenType) {
      case ScreenType.small:
        return scaled.clamp(height * _sizeScaleMin, height * 0.95);
      case ScreenType.medium:
        return scaled.clamp(height * 0.9, height * 1.1);
      case ScreenType.large:
        return scaled.clamp(height * 1.0, height * 1.2);
      case ScreenType.extraLarge:
        return scaled.clamp(height * 1.0, height * 1.3);
    }
  }

  /// Scale height with custom min/max constraints
  static double hClamped(double height, {double? min, double? max}) {
    final scaled = height * _scaleHeight;
    if (min != null && max != null) {
      return scaled.clamp(min, max);
    } else if (min != null) {
      return math.max(scaled, min);
    } else if (max != null) {
      return math.min(scaled, max);
    }
    return scaled;
  }

  // ============ FONT SIZE SCALING ============

  /// Scale font size with conservative limits to maintain readability
  static double sp(double fontSize) {
    final scaled = fontSize * _scaleWidth;

    switch (_screenType) {
      case ScreenType.small:
        // Small screens: use fontScaleMin, prevent text from getting too small
        return scaled.clamp(
          math.max(fontSize * _fontScaleMin, 12.0), // Never below 12px
          fontSize * 1.0,
        );

      case ScreenType.medium:
        // Normal phones: modest scaling using font constraints
        return scaled.clamp(fontSize * _fontScaleMin, fontSize * 1.1);

      case ScreenType.large:
        // Tablets: cap growth at fontScaleMax
        return scaled.clamp(fontSize * 1.0, fontSize * _fontScaleMax);

      case ScreenType.extraLarge:
        // Desktop: fixed increase (could use fontScaleMax here too)
        return fontSize * 1.1;
    }
  }

  /// Scale font size with custom min/max constraints
  static double spClamped(double fontSize, {double? min, double? max}) {
    final scaled = fontSize * _scaleWidth;
    final defaultMin = math.max(fontSize * _fontScaleMin, 12.0);
    final defaultMax = fontSize * _fontScaleMax;

    final effectiveMin = min ?? defaultMin;
    final effectiveMax = max ?? defaultMax;

    return scaled.clamp(effectiveMin, effectiveMax);
  }

  // ============ SPECIALIZED SCALING ============

  /// Scale spacing/padding with more liberal constraints
  /// Spacing can vary more than text or components
  static double spacing(double space) {
    final scaled = space * _scaleWidth;
    // ✅ NOW USING THE CONSTANTS!
    return scaled.clamp(space * _spaceScaleMin, space * _spaceScaleMax);
  }

  /// Scale icon sizes with moderate constraints
  static double icon(double size) {
    final scaled = size * _scaleWidth;

    switch (_screenType) {
      case ScreenType.small:
        return scaled.clamp(size * 0.9, size * 1.0);
      case ScreenType.medium:
        return scaled.clamp(size * 0.95, size * 1.1);
      case ScreenType.large:
        return scaled.clamp(size * 1.0, size * 1.2);
      case ScreenType.extraLarge:
        return size * 1.15;
    }
  }

  /// Scale radius values for borders and decorations
  static double radius(double radius) {
    final scaled = radius * _scaleWidth;
    // Radius uses moderate constraints (similar to sizes)
    return scaled.clamp(radius * 0.9, radius * 1.3);
  }

  /// Ensure minimum touch target size (accessibility)
  /// iOS: 44x44, Android: 48x48
  static double touchTarget(double size, {double minSize = 44.0}) {
    final scaled = size * _scaleWidth;
    return math.max(scaled, minSize);
  }

  // ============ UTILITY GETTERS ============

  /// Current screen width in logical pixels
  static double get screenWidth => _screenWidth;

  /// Current screen height in logical pixels
  static double get screenHeight => _screenHeight;

  /// Current horizontal scale factor
  static double get scaleWidth => _scaleWidth;

  /// Current vertical scale factor
  static double get scaleHeight => _scaleHeight;

  /// Current screen type
  static ScreenType get screenType => _screenType;

  /// Is current device a small phone?
  static bool get isSmall => _screenType == ScreenType.small;

  /// Is current device a regular phone?
  static bool get isMedium => _screenType == ScreenType.medium;

  /// Is current device a tablet?
  static bool get isLarge => _screenType == ScreenType.large;

  /// Is current device desktop/large tablet?
  static bool get isExtraLarge => _screenType == ScreenType.extraLarge;

  /// Is current device a phone (small or medium)?
  static bool get isPhone => isSmall || isMedium;

  /// Is current device a tablet or larger?
  static bool get isTabletOrLarger => isLarge || isExtraLarge;

  // ============ RESPONSIVE VALUES ============

  /// Return different values based on screen type
  static T value<T>({required T mobile, T? tablet, T? desktop}) {
    if (isExtraLarge && desktop != null) return desktop;
    if (isLarge && tablet != null) return tablet;
    return mobile;
  }

  /// Return value from map based on screen type
  static T valueMap<T>({
    T? small,
    T? medium,
    T? large,
    T? extraLarge,
    required T defaultValue,
  }) {
    switch (_screenType) {
      case ScreenType.small:
        return small ?? defaultValue;
      case ScreenType.medium:
        return medium ?? defaultValue;
      case ScreenType.large:
        return large ?? defaultValue;
      case ScreenType.extraLarge:
        return extraLarge ?? defaultValue;
    }
  }
}
