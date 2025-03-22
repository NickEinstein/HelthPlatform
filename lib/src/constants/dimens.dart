import 'package:flutter/material.dart';

class Dimens {
  Dimens._();
  static double spacePageHorizontal = 15;
  static double spacePageVertical = 15;
  static int timeout = 500;

  static const double space1 = 1;
  static const double space2 = 2;
  static const double space3 = 3;
  static const double space4 = 4;
  static const double space5 = 5;
  static const double space6 = 6;
  static const double space8 = 8;
  static const double space10 = 10;
  static const double space11 = 11;
  static const double space12 = 12;
  static const double space13 = 13;
  static const double space14 = 14;
  static const double space15 = 15;
  static const double space16 = 16;
  static const double space18 = 18;
  static const double space20 = 20;
  static const double space22 = 22;
  static const double space24 = 24;
  static const double space26 = 26;
  static const double space28 = 28;
  static const double space30 = 30;
  static const double space32 = 32;
  static const double space35 = 35;
  static const double space38 = 38;
  static const double space42 = 42;
  static const double space50 = 50;
  static const double space60 = 60;
  static const double space61 = 61;
  static const double space62 = 62;
  static const double space63 = 63;
  static const double space64 = 64;
  static const double space65 = 65;
  static const double space70 = 70;
  static const double space90 = 90;

  static const double mobileScreenSize = 340;
  static const double tabletScreenSize = 640;
  static const double desktopScreenSize = 1440;

  static const double defaultScreenWidth = 320.0;
  static const double defaultScreenHeight = 640.0;
  static const bool allowFontScaling = false;

  static double paddingWidthMint = 2.0;
  static double paddingWidthExtraSmall = 5.0;
  static double paddingWidthRadius = 8.0;
  static double paddingWidthSmall = 10.0;
  static double paddingWidthDefault = 16.0;
  static double paddingWidthMedium = 20.0;
  static double paddingWidthLarge = 24.0;
  static double paddingWidthExtraLarge = 32.0;

  static double paddingHeightMint = 2.0;
  static double paddingHeightExtraSmall = 5.0;
  static double paddingHeightRadius = 8.0;
  static double paddingHeightSmall = 10.0;
  static double paddingHeightDefault = 16.0;
  static double paddingHeightMedium = 20.0;
  static double paddingHeightLarge = 24.0;
  static double paddingHeightExtraLarge = 32.0;
  static double paddingHeightMoreExtraLarge = 52.0;

  static double fontSizeMint = 8;
  static double fontSizeExtraSmall = 10;
  static double fontSizeSmall = 12;
  static double fontSizeDefault = 14;
  static double fontSizeMedium = 16;
  static double fontSizeExtraMedium = 18;
  static double fontSizeLarge = 24;

  static double radiusMint = 3.0;
  static double radiusSmall = 5.0;
  static double radiusDefault = 10.0;
  static double radiusLarge = 15.0;
  static double radiusExtraLarge = 20.0;
  static double radiusExtraMoreLarge = 50.0;

  static double iconDefault = 24;
}

double width(BuildContext context) => MediaQuery.of(context).size.width;

//MediaQuery Height
double height(BuildContext context) => MediaQuery.of(context).size.height;

SizedBox tiny5HorSpace() => const SizedBox(width: 5);

SizedBox tiny5Space() => const SizedBox(height: 5);

SizedBox tinySpace() => const SizedBox(height: 10);

SizedBox tiny15Space() => const SizedBox(height: 15);

SizedBox tinyHorSpace() => const SizedBox(width: 10);

SizedBox tiny15HorSpace() => const SizedBox(width: 15);

SizedBox smallSpace() => const SizedBox(height: 20);

SizedBox smallHorSpace() => const SizedBox(width: 20);

SizedBox mediumSpace() => const SizedBox(height: 30);

SizedBox mediumHorSpace() => const SizedBox(width: 30);

verticalSpace(context, factor) => SizedBox(height: height(context) * factor);

horizontalSpace(context, factor) => SizedBox(width: width(context) * factor);
