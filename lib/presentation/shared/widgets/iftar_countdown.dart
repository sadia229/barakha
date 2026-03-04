import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../infrastructure/theme/app.colors.dart';

class IftarCountdown extends StatefulWidget {
  const IftarCountdown({super.key});

  @override
  State<IftarCountdown> createState() => _IftarCountdownState();
}

class _IftarCountdownState extends State<IftarCountdown> {
  late Timer _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calculateRemainingTime();
    });
  }

  void _calculateRemainingTime() {
    final now = DateTime.now();
    final iftarTime = DateTime(now.year, now.month, now.day, 18, 30); // 6:30 PM
    
    DateTime targetIftar;
    if (now.isAfter(iftarTime)) {
      targetIftar = iftarTime.add(const Duration(days: 1));
    } else {
      targetIftar = iftarTime;
    }
    
    setState(() {
      _remainingTime = targetIftar.difference(now);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = _remainingTime.inHours;
    final minutes = _remainingTime.inMinutes.remainder(60);
    final seconds = _remainingTime.inSeconds.remainder(60);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.textSecondary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppColors.richGold.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTimeUnit('Hours', hours),
              _buildSeparator(),
              _buildTimeUnit('Minutes', minutes),
              _buildSeparator(),
              _buildTimeUnit('Seconds', seconds),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeUnit(String label, int value) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: AppColors.richGold.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: AppColors.richGold.withOpacity(0.5),
            ),
          ),
          child: Text(
            value.toString().padLeft(2, '0'),
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.richGold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildSeparator() {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Text(
        ':',
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.richGold.withOpacity(0.8),
        ),
      ),
    );
  }
}
