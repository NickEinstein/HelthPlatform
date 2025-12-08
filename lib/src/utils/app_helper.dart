import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

const kLOGTAG = "[Demo-Flutter]";
const kLOGENABLE = true;

printLog(dynamic data) {
  if (kLOGENABLE) {
    print("$kLOGTAG: ${data.toString()}");
  }
}

class AppHelper {
  AppHelper._();

  static ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: ColorConstant.primaryLightColor,
      secondary: ColorConstant.primaryLightColor,
    ),
    useMaterial3: true,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static final monthList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  static int monthToNumber(String month) {
    return monthList.indexOf(month) + 1;
  }
}
