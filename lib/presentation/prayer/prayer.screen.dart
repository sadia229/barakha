import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ramadan/infrastructure/theme/app.colors.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _progressController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _progressAnimation;
  
  final List<String> _waqtNames = ['Fajr', 'Sunrise', 'Dhuhr', 'Asr', 'Sunset', 'Maghrib', 'Isha'];
  
  final Map<String, String> _prayerTimes = {
    "Fajr": "05:14",
    "Sunrise": "06:30",
    "Dhuhr": "12:12",
    "Asr": "16:18",
    "Sunset": "17:55",
    "Maghrib": "17:55",
    "Isha": "19:11",
    "Imsak": "05:04",
    "Midnight": "00:12",
    "Firstthird": "22:07",
    "Lastthird": "02:18"
  };

  final Map<String, IconData> _prayerIcons = {
    "Fajr": Icons.wb_twilight_rounded,
    "Sunrise": Icons.wb_sunny_rounded,
    "Dhuhr": Icons.wb_sunny_outlined,
    "Asr": Icons.cloud_rounded,
    "Sunset": Icons.nights_stay_rounded,
    "Maghrib": Icons.nightlight_rounded,
    "Isha": Icons.bedtime_rounded,
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
    
    _animationController.forward();
    _progressController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  String _getCurrentPrayer() {
    final now = DateTime.now();
    final currentTime = DateFormat('HH:mm').format(now);
    
    for (int i = 0; i < _waqtNames.length; i++) {
      final prayerTime = _prayerTimes[_waqtNames[i]]!;
      if (currentTime.compareTo(prayerTime) <= 0) {
        return _waqtNames[i];
      }
    }
    return 'Fajr'; // Default to next day's Fajr
  }

  String _getNextPrayer() {
    final currentPrayer = _getCurrentPrayer();
    final currentIndex = _waqtNames.indexOf(currentPrayer);
    return _waqtNames[(currentIndex + 1) % _waqtNames.length];
  }

  double _getPrayerProgress() {
    final now = DateTime.now();
    final currentTime = DateFormat('HH:mm').format(now);
    final currentPrayer = _getCurrentPrayer();
    final currentIndex = _waqtNames.indexOf(currentPrayer);
    
    if (currentIndex == 0) return 0.0;
    
    final previousPrayer = _waqtNames[currentIndex - 1];
    final previousTime = _prayerTimes[previousPrayer]!;
    final currentTimeObj = _prayerTimes[currentPrayer]!;
    
    final previous = DateFormat('HH:mm').parse(previousTime);
    final current = DateFormat('HH:mm').parse(currentTimeObj);
    final nowTime = DateFormat('HH:mm').parse(currentTime);
    
    final totalDuration = current.difference(previous).inMinutes;
    final elapsedDuration = nowTime.difference(previous).inMinutes;
    
    if (elapsedDuration <= 0) return 0.0;
    if (elapsedDuration >= totalDuration) return 1.0;
    
    return elapsedDuration / totalDuration;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBar,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildCurrentPrayerCard(),
                          ),
                          Expanded(
                            child: _buildPrayerProgress(),
                          ),
                        ],
                      ),
                      _buildAllPrayersList(),
                      _buildTahajudSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    final now = DateTime.now();
    final todayDate = DateFormat('EEEE, MMMM d, y').format(now);
    
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
                      'Prayer Times',
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
                  Icons.mosque_rounded,
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

  Widget _buildCurrentPrayerCard() {
    final currentPrayer = _getCurrentPrayer();
    final nextPrayer = _getNextPrayer();
    
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.deepTeal,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepTeal.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Prayer',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.pureWhite.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentPrayer,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      color: AppColors.pureWhite,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Time',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.pureWhite.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _prayerTimes[currentPrayer] ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: AppColors.pureWhite,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.pureWhite.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.schedule_rounded,
                  size: 16,
                  color: AppColors.pureWhite,
                ),
                const SizedBox(width: 6),
                Text(
                  'Next: $nextPrayer at ${_prayerTimes[nextPrayer]}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.pureWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerProgress() {
    final progress = _getPrayerProgress();
    final currentPrayer = _getCurrentPrayer();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepTeal.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: AppColors.tealOpacity20,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Day Progress',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.deepTeal,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background circle
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.tealOpacity20,
                      ),
                    ),
                    // Progress circle
                    Transform.rotate(
                      angle: -90 * (3.14159 / 180), // Start from top
                      child: ClipOval(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          widthFactor: progress * _progressAnimation.value,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.deepTeal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Inner white circle
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.pureWhite,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.deepTeal.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    // Progress text
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${(progress * 100).toInt()}%',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.deepTeal,
                          ),
                        ),
                        Text(
                          'Complete',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.tealOpacity10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.deepTeal,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Current: $currentPrayer',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.deepTeal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllPrayersList() {
    final currentPrayer = _getCurrentPrayer();
    final nextPrayer = _getNextPrayer();
    
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Prayer Times',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.deepTeal,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _waqtNames.length,
                itemBuilder: (context, index) {
                  final prayerName = _waqtNames[index];
                  final prayerTime = _prayerTimes[prayerName]!;
                  final isCurrent = prayerName == currentPrayer;
                  final isNext = prayerName == nextPrayer;
                  final isSunTime = prayerName.contains('sun') || prayerName.contains('Sun');
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: isCurrent 
                          ? AppColors.deepTeal.withOpacity(0.1)
                          : isSunTime
                              ? AppColors.richGold.withOpacity(0.05)
                              : AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isCurrent 
                            ? AppColors.deepTeal.withOpacity(0.3)
                            : isSunTime
                                ? AppColors.richGold.withOpacity(0.2)
                                : AppColors.tealOpacity20,
                        width: isCurrent ? 2 : 1,
                      ),
                      boxShadow: [
                        if (isCurrent)
                          BoxShadow(
                            color: AppColors.deepTeal.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isCurrent
                                  ? AppColors.deepTeal.withOpacity(0.2)
                                  : isSunTime
                                      ? AppColors.richGold.withOpacity(0.1)
                                      : AppColors.tealOpacity10,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _prayerIcons[prayerName] ?? Icons.access_time_rounded,
                              size: 24,
                              color: isCurrent
                                  ? AppColors.deepTeal
                                  : isSunTime
                                      ? AppColors.richGold
                                      : AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      prayerName,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: isCurrent
                                            ? AppColors.deepTeal
                                            : AppColors.textPrimary,
                                      ),
                                    ),
                                    if (isCurrent) ...[
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.deepTeal,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          'NOW',
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.pureWhite,
                                          ),
                                        ),
                                      ),
                                    ],
                                    if (isNext && !isCurrent) ...[
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.richGold.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: AppColors.richGold.withOpacity(0.4),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          'NEXT',
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.richGold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  isSunTime ? 'Sun Time' : 'Prayer Time',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: AppColors.textHint,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                prayerTime,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: isCurrent
                                      ? AppColors.deepTeal
                                      : AppColors.textPrimary,
                                ),
                              ),
                              if (isCurrent) ...[
                                const SizedBox(height: 4),
                                Text(
                                  'In Progress',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: AppColors.deepTeal,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTahajudSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.deepTeal.withOpacity(0.1),
            AppColors.tealLighter.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.deepTeal.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.deepTeal.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.nightlight_rounded,
                  color: AppColors.deepTeal,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Tahajud Time',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.deepTeal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTahajudTimeCard('Best Time', _prayerTimes['Lastthird'] ?? ''),
              _buildTahajudTimeCard('Before Fajr', _prayerTimes['Imsak'] ?? ''),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.pureWhite.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.star_rounded,
                  size: 18,
                  color: AppColors.richGold,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'The last third of the night is the most blessed time for Tahajud prayers',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.deepTeal,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTahajudTimeCard(String label, String time) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.deepTeal.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.deepTeal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
