// lib/constants/app_text_styles.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app.colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // DISPLAY / HERO
  static TextStyle heroText = GoogleFonts.poppins(
    fontSize: 48,
    fontWeight: FontWeight.w600,
    color: AppColors.deepTeal,
    height: 1.2,
  );

  // HEADINGS
  static TextStyle h1 = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle h2 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle h3 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // BODY TEXT (ENGLISH)
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
    letterSpacing: 0.5,
  );

  static TextStyle bodyRegular = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
    letterSpacing: 0.5,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 1.5,
    letterSpacing: 0.5,
  );

  static TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
    height: 1.4,
    letterSpacing: 0.5,
  );

  // BANGLA TEXT
  static TextStyle banglaBold = GoogleFonts.hindSiliguri(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.6,
  );

  static TextStyle banglaRegular = GoogleFonts.hindSiliguri(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static TextStyle banglaSmall = GoogleFonts.hindSiliguri(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 1.6,
  );

  // ARABIC TEXT
  static TextStyle arabicLarge = GoogleFonts.amiri(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.8,
  );

  static TextStyle arabicRegular = GoogleFonts.amiri(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.8,
  );

  static TextStyle arabicBold = GoogleFonts.amiri(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.8,
  );

  // BUTTON TEXT
  static TextStyle button = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.pureWhite,
    letterSpacing: 0.5,
  );

  static TextStyle buttonSmall = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.pureWhite,
    letterSpacing: 0.5,
  );

  // COUNTDOWN / NUMBERS
  static TextStyle countdownLarge = GoogleFonts.robotoMono(
    fontSize: 64,
    fontWeight: FontWeight.w700,
    color: AppColors.richGold,
    height: 1.0,
  );

  static TextStyle countdownMedium = GoogleFonts.robotoMono(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.deepTeal,
    height: 1.0,
  );

  static TextStyle countdownSmall = GoogleFonts.robotoMono(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.0,
  );

  // SPECIAL STYLES
  static TextStyle quranVerse = GoogleFonts.amiri(
    fontSize: 26,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 2.0, // Extra spacing for readability
  );

  static TextStyle duaText = GoogleFonts.amiri(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.8,
  );

  static TextStyle badge = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.pureWhite,
    letterSpacing: 1.0,
  );

  // NAVIGATION
  static TextStyle navActive = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.deepTeal,
  );

  static TextStyle navInactive = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
  );
}
