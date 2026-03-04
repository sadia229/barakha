import 'package:flutter/material.dart';

class AppColors {
  // Prevent instantiation
  AppColors._();

  // PRIMARY COLORS (Based on #002d39)
  static const Color deepTeal = Color(0xFF002d39);        // Your primary color
  static const Color richGold = Color(0xFFF4A259);        // Kept - complements well
  static const Color pureWhite = Color(0xFFFFFFFF);

  // SECONDARY COLORS (Updated to harmonize with new primary)
  static const Color softCream = Color(0xFFF8F3E8);       // Kept
  static const Color darkNavy = Color(0xFF001419);        // Darker shade of primary
  static const Color sageGreen = Color(0xFF7BA591);       // Adjusted to match

  // TEAL VARIATIONS (Based on #002d39)
  static const Color tealLighter = Color(0xFF004d5c);     // Lighter variant
  static const Color tealLight = Color(0xFF00404f);       // Light variant  
  static const Color tealDark = Color(0xFF001f28);        // Dark variant
  static const Color tealDarker = Color(0xFF000f14);      // Darkest variant

  // FUNCTIONAL COLORS
  static const Color success = Color(0xFF2ECC71);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF39C12);
  static const Color info = Color(0xFF3498DB);

  // GRADIENT COLORS
  static const Color sunsetOrange = Color(0xFFE76F51);
  static const Color lightGold = Color(0xFFF2CC8F);
  static const Color oceanBlue = Color(0xFF006B7D);       // New: lighter ocean tone

  // OPACITY VARIATIONS (Updated with new primary)
  static const Color tealOpacity10 = Color(0x1A002d39);   // 10%
  static const Color tealOpacity20 = Color(0x33002d39);   // 20%
  static const Color tealOpacity30 = Color(0x4D002d39);   // 30%
  static const Color tealOpacity50 = Color(0x80002d39);   // 50%
  static const Color tealOpacity70 = Color(0xB3002d39);   // 70%
  static const Color tealOpacity80 = Color(0xCC002d39);   // 80%

  static const Color goldLight = Color(0x1AF4A259);       // 10%
  static const Color goldMedium = Color(0x4DF4A259);      // 30%
  static const Color goldHalf = Color(0x80F4A259);        // 50%

  static const Color navyOverlay = Color(0x99001419);     // 60%
  static const Color navyDark = Color(0xCC001419);        // 80%
  static const Color navyAlmost = Color(0xF2001419);      // 95%

  // TEXT COLORS (Updated to work with darker primary)
  static const Color textPrimary = Color(0xFF001419);     // Very dark
  static const Color textSecondary = Color(0xD9001419);   // 85%
  static const Color textTertiary = Color(0xB3002d39);    // 70% of primary
  static const Color textHint = Color(0x99002d39);        // 60% of primary
  static const Color cardDesign = Color(0xFF002d39);

  // APP BAR (Your specified color)
  static const Color appBar = Color(0xFF002d39);          // Primary color

  // GRADIENTS (Updated with new primary)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [deepTeal, oceanBlue, richGold],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient nightPrayerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [darkNavy, deepTeal, tealLight],
    stops: [0.0, 0.6, 1.0],
  );

  static const LinearGradient softGlowGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [softCream, pureWhite],
  );

  static const LinearGradient goldenHourGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [richGold, lightGold, sunsetOrange],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient oceanDepthGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [tealDarker, deepTeal, tealLighter],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient tealGoldGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [deepTeal, oceanBlue, richGold],
    stops: [0.0, 0.6, 1.0],
  );
}