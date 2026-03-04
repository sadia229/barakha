import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../infrastructure/theme/app.colors.dart';

class CategoriesScroll extends StatelessWidget {
  const CategoriesScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 4,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return _buildCategoryItem(
            context,
            _categories[index]['title']!,
            _categories[index]['icon']!,
            _categories[index]['color']!,
          );
        },
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Container(
      //width: 100,
      // decoration: BoxDecoration(
      //   color: AppColors.textSecondary.withOpacity(0.3),
      //   borderRadius: BorderRadius.circular(16),
      //   border: Border.all(
      //     color: color.withOpacity(0.3),
      //     width: 1,
      //   ),
      // ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Handle category tap
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: color.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const List<Map<String, dynamic>> _categories = [
    {
      'title': 'Quran',
      'icon': CupertinoIcons.book,
      'color': AppColors.richGold,
    },
    {
      'title': 'Tasbih',
      'icon': CupertinoIcons.number,
      'color': Colors.teal,
    },
    {
      'title': 'Dua',
      'icon': CupertinoIcons.heart,
      'color': Colors.pink,
    },
    {
      'title': 'Hadith',
      'icon': CupertinoIcons.text_badge_star,
      'color': Colors.orange,
    },
  ];
}
