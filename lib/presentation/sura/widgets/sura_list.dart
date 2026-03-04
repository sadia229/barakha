import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/core/handler/extensions/number_extension.dart';
import '../../../infrastructure/theme/app.colors.dart';

class SuraList extends StatelessWidget {
  final List<Map<String, dynamic>> suraList;

  const SuraList({super.key, required this.suraList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Surahs',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.deepTeal,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: suraList.length,
              itemBuilder: (context, index) {
                final sura = suraList[index];
                debugPrint("Individual sura: $sura");

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.tealOpacity20,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.deepTeal.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                      expansionTileTheme: const ExpansionTileThemeData(
                        backgroundColor: Colors.transparent,
                        collapsedBackgroundColor: Colors.transparent,
                      ),
                    ),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.deepTeal.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            sura['id'].toString().toBanglaNumber(),
                            style: GoogleFonts.poppins(
                              color: AppColors.pureWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        sura['name'] ?? 'Unknown',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          letterSpacing: 0.2,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          "Surah ${sura['id'].toString().toBanglaNumber()}",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.expand_more,
                        color: AppColors.deepTeal,
                      ),
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          decoration: const BoxDecoration(
                            color: AppColors.tealOpacity10,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Meaning:",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.deepTeal,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                sura['meaning']?.toString() ??
                                    'No meaning available',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: AppColors.textPrimary,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      HapticFeedback.lightImpact();
                                      // TODO: Add navigation to sura details
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                      size: 18,
                                      color: AppColors.deepTeal,
                                    ),
                                    label: Text(
                                      "Read More",
                                      style: GoogleFonts.poppins(
                                        color: AppColors.deepTeal,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: const BorderSide(
                                            color: AppColors.deepTeal),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                      onExpansionChanged: (isExpanded) {
                        if (isExpanded) {
                          HapticFeedback.selectionClick();
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
