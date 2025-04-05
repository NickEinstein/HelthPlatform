import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> removeToken() async {
    await prefs.remove('token');
  }

  static Future<void> setToken(String token) async {
    await prefs.setString('token', token);
  }

  static String? get token {
    return prefs.getString('token');
  }

  static Future<void> removeUser() async {
    await prefs.remove('userId');
  }

  static Future<void> setUser(int userId) async {
    await prefs.setInt('userId', userId);
  }

  static int? get userId {
    return prefs.getInt('userId');
  }
}
