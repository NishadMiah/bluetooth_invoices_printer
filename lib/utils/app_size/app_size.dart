import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSize {
  // Padding
  static EdgeInsetsGeometry padding = EdgeInsets.symmetric(horizontal: 20.w);
  static EdgeInsetsGeometry paddingSmall = EdgeInsets.symmetric(
    horizontal: 12.w,
  );
  static EdgeInsetsGeometry paddingLarge = EdgeInsets.symmetric(
    horizontal: 24.w,
  );
  static EdgeInsetsGeometry paddingAll = EdgeInsets.all(20.w);
  static EdgeInsetsGeometry paddingAllSmall = EdgeInsets.all(12.w);
  static EdgeInsetsGeometry paddingAllLarge = EdgeInsets.all(24.w);

  // Spacing
  static double spaceXSmall = 4.h;
  static double spaceSmall = 8.h;
  static double spaceMedium = 16.h;
  static double spaceLarge = 24.h;
  static double spaceXLarge = 32.h;

  // Border Radius
  static double radiusSmall = 8.r;
  static double radiusMedium = 12.r;
  static double radiusLarge = 16.r;
  static double radiusXLarge = 24.r;
  static double radiusRound = 50.r;

  // Button Heights
  static double buttonHeight = 48.h;
  static double buttonHeightSmall = 40.h;
  static double buttonHeightLarge = 56.h;

  // Icon Sizes
  static double iconSmall = 20.w;
  static double iconMedium = 24.w;
  static double iconLarge = 32.w;
  static double iconXLarge = 48.w;

  // Card
  static double cardElevation = 4;
  static double cardPadding = 16.w;
}
