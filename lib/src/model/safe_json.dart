import 'dart:developer';

class SafeJson {
  /// Safely parses an [int] from a dynamic value.
  ///
  /// - If [value] is [int], returns it.
  /// - If [value] is [double], returns it as [int] (truncated).
  /// - If [value] is [bool], returns 1 for true, 0 for false.
  /// - If [value] is [String], tries to parse it as int, then double-to-int.
  /// - Returns [defaultValue] if parsing fails.
  static int asInt(dynamic value, {int defaultValue = 0}) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is bool) return value ? 1 : 0;
    if (value is String) {
      final intVal = int.tryParse(value);
      if (intVal != null) return intVal;
      final doubleVal = double.tryParse(value);
      if (doubleVal != null) return doubleVal.toInt();
    }
    return defaultValue;
  }

  /// Safely parses a [double] from a dynamic value.
  ///
  /// - If [value] is [double], returns it.
  /// - If [value] is [int], returns it as [double].
  /// - If [value] is [String], tries to parse it.
  /// - Returns [defaultValue] if parsing fails.
  static double asDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value == null) return defaultValue;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      final doubleVal = double.tryParse(value);
      if (doubleVal != null) return doubleVal;
    }
    return defaultValue;
  }

  /// Safely parses a [bool] from a dynamic value.
  ///
  /// - If [value] is [bool], returns it.
  /// - If [value] is [int], returns true if 1, false otherwise.
  /// - If [value] is [String], returns true if "true", "1", "yes", "on" (case-insensitive).
  /// - Returns [defaultValue] if parsing fails.
  static bool asBool(dynamic value, {bool defaultValue = false}) {
    if (value == null) return defaultValue;
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) {
      final lowerValue = value.toLowerCase();
      return lowerValue == 'true' ||
          lowerValue == '1' ||
          lowerValue == 'yes' ||
          lowerValue == 'on';
    }
    return defaultValue;
  }

  /// Safely parses a [String] from a dynamic value.
  ///
  /// - Returns the [toString()] representation of any non-null value.
  /// - Returns [defaultValue] if value is null.
  static String asString(dynamic value, {String defaultValue = ''}) {
    if (value == null) return defaultValue;
    return value.toString();
  }

  /// Safely parses a [List] from a dynamic value.
  ///
  /// - If [value] is not a List, returns [defaultValue].
  /// - If [fromJson] is provided, converts each element using it.
  /// - Filters out nulls if conversion fails (returns null).
  static List<T> asList<T>(
    dynamic value, {
    T Function(dynamic)? fromJson,
    List<T> defaultValue = const [],
  }) {
    if (value == null || value is! List) return defaultValue;
    if (fromJson == null) {
      // Try to cast elements if T is matching, otherwise return dynamic list casted
      try {
        return value.map((e) => e as T).toList();
      } catch (e) {
        log('SafeJson.asList cast error: $e');
        return defaultValue;
      }
    }
    try {
      return value.map((e) => fromJson(e)).toList();
    } catch (e) {
      log('SafeJson.asList transformation error: $e');
      return defaultValue;
    }
  }

  /// Safely parses a [Map] from a dynamic value.
  ///
  /// - If [value] is not a Map, returns [defaultValue].
  static Map<String, dynamic> asMap(
    dynamic value, {
    Map<String, dynamic> defaultValue = const {},
  }) {
    if (value == null || value is! Map) return defaultValue;
    return Map<String, dynamic>.from(value);
  }

  /// Safely parses a custom object from a dynamic value (usually a Map).
  ///
  /// - If [value] is null or not a Map, returns [defaultValue] (if provided) or throws/returns null depending on usage.
  /// - Actually, to match "safe" behavior, this requires [defaultValue] or nullable return.
  ///   Given the prompt implies "without throwing errors", nullable return is safer if default not possible.
  static T? parse<T>(
    dynamic value,
    T Function(Map<String, dynamic>) fromJson, {
    T? defaultValue,
  }) {
    if (value == null) {
      return defaultValue;
    }

    // If it's already the target type, return it
    if (value is T) return value;

    if (value is! Map) {
      return defaultValue;
    }

    try {
      return fromJson(Map<String, dynamic>.from(value));
    } catch (e) {
      log('SafeJson.parse factory error: $e');
      return defaultValue;
    }
  }
}
