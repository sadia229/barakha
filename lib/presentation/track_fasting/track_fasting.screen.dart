import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progressive_time_picker/progressive_time_picker.dart';
import 'package:ramadan/presentation/track_fasting/widgets/modern_glass_painter.dart';
import '../../infrastructure/theme/app.colors.dart';

class TrackFastingScreen extends StatefulWidget {
  const TrackFastingScreen({super.key});

  @override
  State<TrackFastingScreen> createState() => _TrackFastingScreenState();
}

class _TrackFastingScreenState extends State<TrackFastingScreen>
    with TickerProviderStateMixin {
  late AnimationController _glassController;
  late AnimationController _bubbleController;
  late Animation<double> _glassAnimation;
  late Animation<double> _bubbleAnimation;
  int _drankGlasses = 0;
  final int _totalGlasses = 5;

  @override
  void initState() {
    super.initState();
    _glassController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _bubbleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    _glassAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glassController, curve: Curves.easeInOutBack),
    );
    _bubbleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bubbleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glassController.dispose();
    _bubbleController.dispose();
    super.dispose();
  }

  void _drinkWater() {
    if (_drankGlasses < _totalGlasses) {
      setState(() {
        _drankGlasses++;
      });
      _glassController.reset();
      _glassController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRamadanTrackerSection(),
              _buildWaterSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRamadanTrackerSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TimePicker(
            initTime: PickedTime(h: 0, m: 0),
            endTime: PickedTime(h: 8, m: 0),
            onSelectionChange: (start, end, isDisableRange) => print(
                'onSelectionChange => init : ${start.h}:${start.m}, end : ${end.h}:${end.m}, isDisableRangeRange: $isDisableRange'),
            onSelectionEnd: (start, end, isDisableRange) => print(
                'onSelectionEnd => init : ${start.h}:${start.m}, end : ${end.h}:${end.m},, isDisableRangeRange: $isDisableRange'),
          ),
        ],
      ),
    );
  }

  Widget _buildWaterSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00b4db), Color(0xFF0083b0)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.local_drink,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Hydration Tracker',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Drink $_totalGlasses glasses of water throughout the evening',
            style: GoogleFonts.poppins(
              color: const Color(0xFF7288A8),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 30),

          // Enhanced Glass Animation
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([_glassAnimation, _bubbleAnimation]),
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: CustomPaint(
                    size: const Size(100, 140),
                    painter: ModernGlassPainter(
                      fillPercentage: (_drankGlasses / _totalGlasses) *
                          _glassAnimation.value,
                      bubbleAnimation: _bubbleAnimation.value,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // Water Counter with Progress
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF00b4db).withOpacity(0.1),
                  const Color(0xFF0083b0).withOpacity(0.1)
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Progress',
                      style: TextStyle(
                        color: Color(0xFF2d3748),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '$_drankGlasses / $_totalGlasses glasses',
                      style: const TextStyle(
                        color: Color(0xFF0083b0),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: _drankGlasses / _totalGlasses,
                  backgroundColor: Colors.grey.shade300,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFF00b4db)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Enhanced Drink Water Button
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00b4db), Color(0xFF0083b0)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ElevatedButton.icon(
              onPressed: _drankGlasses < _totalGlasses ? _drinkWater : null,
              icon: const Icon(
                Icons.local_drink,
                color: Colors.white,
                size: 24,
              ),
              label: Text(
                _drankGlasses < _totalGlasses
                    ? 'Drink Water'
                    : 'Goal Completed! 🎉',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
