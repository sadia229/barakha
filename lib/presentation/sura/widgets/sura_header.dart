import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/core/handler/extensions/number_extension.dart';
import '../../../infrastructure/theme/app.colors.dart';

class SuraHeader extends StatelessWidget {
  final int suraCount;

  const SuraHeader({super.key, required this.suraCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.tealGoldGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepTeal.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.pureWhite.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.auto_stories_rounded,
              color: AppColors.pureWhite,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Surahs',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.pureWhite.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  suraCount.toString().toBanglaNumber(),
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    color: AppColors.pureWhite,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
