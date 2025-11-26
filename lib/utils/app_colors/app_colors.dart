import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors - Modern Blue-Purple Gradient
  static const Color primary = Color(0xff6366F1); // Indigo
  static const Color primaryDark = Color(0xff4F46E5);
  static const Color primaryLight = Color(0xff818CF8);

  static const Color secondary = Color(0xff8B5CF6); // Purple
  static const Color secondaryDark = Color(0xff7C3AED);
  static const Color secondaryLight = Color(0xffA78BFA);

  static const Color accent = Color(0xff10B981); // Emerald
  static const Color accentDark = Color(0xff059669);

  // Background Colors
  static const Color backgroundClr = Color(0xffF8FAFC); // Slate 50
  static const Color backgroundDark = Color(0xff0F172A); // Slate 900
  static const Color cardBackground = Color(0xffFFFFFF);
  static const Color cardBackgroundDark = Color(0xff1E293B);

  // Text Colors
  static const Color textPrimary = Color(0xff0F172A); // Slate 900
  static const Color textSecondary = Color(0xff64748B); // Slate 500
  static const Color textTertiary = Color(0xff94A3B8); // Slate 400
  static const Color textOnPrimary = Color(0xffFFFFFF);

  // Status Colors
  static const Color success = Color(0xff10B981); // Emerald 500
  static const Color warning = Color(0xffF59E0B); // Amber 500
  static const Color error = Color(0xffEF4444); // Red 500
  static const Color info = Color(0xff3B82F6); // Blue 500

  // Neutral Colors
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color grey100 = Color(0xffF1F5F9);
  static const Color grey200 = Color(0xffE2E8F0);
  static const Color grey300 = Color(0xffCBD5E1);
  static const Color grey400 = Color(0xff94A3B8);
  static const Color grey500 = Color(0xff64748B);
  static const Color grey600 = Color(0xff475569);
  static const Color grey700 = Color(0xff334155);
  static const Color grey800 = Color(0xff1E293B);
  static const Color grey900 = Color(0xff0F172A);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xffFFFFFF), Color(0xffF8FAFC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xffF8FAFC), Color(0xffE2E8F0)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: grey300.withValues(alpha: 0.3),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.3),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];
}
