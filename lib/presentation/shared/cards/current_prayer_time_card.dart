import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/theme/app.colors.dart';

class CurrentPrayerTimeCard extends StatelessWidget {
  const CurrentPrayerTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 20.0),
      decoration: BoxDecoration(
        color: AppColors.textSecondary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppColors.richGold.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 12.0),
                decoration: BoxDecoration(
                  color: AppColors.tealOpacity80,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Now',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                CupertinoIcons.moon,
                color: AppColors.pureWhite,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'Isha',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold,
                  color: AppColors.pureWhite.withOpacity(0.7),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            '7:30 pm',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.bold,
              color: AppColors.richGold,
            ),
          ),
        ],
      ),
    );
  }
}
