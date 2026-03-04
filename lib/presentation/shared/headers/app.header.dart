import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/theme/app.colors.dart';

class AppHeader extends StatelessWidget {
  final String text;
  const AppHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.w500,
        color: AppColors.pureWhite.withOpacity(0.8),
      ),
    );
  }
}
