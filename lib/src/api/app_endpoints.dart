import 'package:flutter/foundation.dart';

class AppEndpoints {
  static const bool liveWhileDebug = false;

  static String get baseUrl {
    return baseUrlTest;
    if (kDebugMode && (!liveWhileDebug)) {
      return baseUrlTest;
    } else {
      return baseUrlLive;
    }
  }

  static String get suffix {
    return suffixTest;
    if (kDebugMode && (!liveWhileDebug)) {
      return suffixTest;
    } else {
      return suffixLive;
    }
  }

  // static String baseUrlTest = 'https://edogoverp.com';
  static String baseUrlTest = 'https://api.greenzonetechnologies.com.ng';

  static String baseUrlLive = 'https://api.greenzonetechnologies.com.ng';

  static String suffixTest = 'emrpatientapi';
  static String suffixLive = 'emrpatientsapi';
}
