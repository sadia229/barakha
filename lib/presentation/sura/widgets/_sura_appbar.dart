part of '../sura.screen.dart';

class _SuraAppBar extends StatelessWidget {
  final String todayDate;

  const _SuraAppBar({
    super.key,
    required this.todayDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Holy Sura' s",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.pureWhite,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      todayDate,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.pureWhite.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.richGold.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: AppColors.richGold,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
