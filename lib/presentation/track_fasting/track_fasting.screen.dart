import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  
  // Ramadan tracking data
  final int _totalRamadanDays = 30;
  final int _currentDay = 5;
  
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
  
  String _getFormattedDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, MMMM d, y').format(now);
  }
  
  @override
  Widget build(BuildContext context) {
    final remainingRoza = _totalRamadanDays - _currentDay;
    final progress = _currentDay / _totalRamadanDays;
    
    return Scaffold(
      backgroundColor: AppColors.appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Water Intake Tracking
              _buildWaterSection(),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            //backdropFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          ),
          child: Icon(
            Icons.nightlight_round,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ramadan Tracker',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              Text(
                'Track your fasting journey',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildDateSection(int remainingRoza) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.9),
            Colors.white.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
        //backdropFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Today\'s Date',
                style: TextStyle(
                  color: Color(0xFF2d3748),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _getFormattedDate(),
            style: TextStyle(
              color: Color(0xFF1a202c),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.event_available,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '$remainingRoza days remaining',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
  
  Widget _buildCircularProgress(double progress) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.9),
            Colors.white.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Ramadan Progress',
            style: TextStyle(
              color: Color(0xFF2d3748),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background circle
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.grey.shade300, Colors.grey.shade100],
                    ),
                  ),
                ),
                // Progress circle
                SizedBox(
                  height: 140,
                  width: 140,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 14,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF667eea),
                    ),
                  ),
                ),
                // Inner circle with stats
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey.shade50],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$_currentDay',
                        style: TextStyle(
                          color: Color(0xFF2d3748),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'of $_totalRamadanDays',
                        style: TextStyle(
                          color: Color(0xFF718096),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF667eea).withOpacity(0.3),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                // Iftar functionality
              },
              icon: Icon(Icons.nightlight_round, color: Colors.white, size: 24),
              label: Text(
                'Iftar Time',
                style: TextStyle(
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
  
  Widget _buildDietSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.9),
            Colors.white.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Bangladeshi Ramadan Diet',
                style: TextStyle(
                  color: Color(0xFF2d3748),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildMealItem('Sehri', ['Panta bhat', 'Egg fry', 'Banana', 'Yogurt', 'Dates'], const Color(0xFF4CAF50)),
          _buildMealItem('Iftar', ['Dates', 'Water', 'Lentil soup', 'Piyaju', 'Beguni'], const Color(0xFFFF9800)),
          _buildMealItem('Dinner', ['Rice', 'Chicken curry', 'Fish', 'Vegetables', 'Salad'], const Color(0xFF2196F3)),
          _buildMealItem('Snacks', ['Fruits', 'Nuts', 'Juice', 'Muri', 'Jhal muri'], const Color(0xFF9C27B0)),
        ],
      ),
    );
  }
  
  Widget _buildMealItem(String title, List<String> items, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: items.map((item) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: color.withOpacity(0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildWaterSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [
        //     Colors.white.withOpacity(0.9),
        //     Colors.white.withOpacity(0.7),
        //   ],
        // ),
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 20,
        //     offset: const Offset(0, 10),
        //   ),
        // ],
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
                  color: Color(0xFF2d3748),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Drink $_totalGlasses glasses of water throughout the evening',
            style: const TextStyle(
              color: Color(0xFF718096),
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
                      fillPercentage: (_drankGlasses / _totalGlasses) * _glassAnimation.value,
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
                colors: [const Color(0xFF00b4db).withOpacity(0.1), const Color(0xFF0083b0).withOpacity(0.1)],
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
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00b4db)),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Enhanced Drink Water Button
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: _drankGlasses < _totalGlasses 
                  ? const LinearGradient(
                      colors: [Color(0xFF00b4db), Color(0xFF0083b0)],
                    )
                  : LinearGradient(
                      colors: [Colors.grey.shade400, Colors.grey.shade300],
                    ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: _drankGlasses < _totalGlasses ? [
                BoxShadow(
                  color: const Color(0xFF00b4db).withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ] : [],
            ),
            child: ElevatedButton.icon(
              onPressed: _drankGlasses < _totalGlasses ? _drinkWater : null,
              icon: const Icon(
                Icons.local_drink,
                color: Colors.white,
                size: 24,
              ),
              label: Text(
                _drankGlasses < _totalGlasses ? 'Drink Water' : 'Goal Completed! 🎉',
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

// Modern Glass Painter with realistic effects
class ModernGlassPainter extends CustomPainter {
  final double fillPercentage;
  final double bubbleAnimation;
  
  ModernGlassPainter({required this.fillPercentage, required this.bubbleAnimation});
  
  @override
  void paint(Canvas canvas, Size size) {
    final glassPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    
    final glassStrokePaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    
    final waterPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF00b4db).withOpacity(0.8),
          const Color(0xFF0083b0).withOpacity(0.9),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
    
    final bubblePaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.fill;
    
    // Draw glass shape with rounded bottom
    final glassPath = Path()
      ..moveTo(size.width * 0.15, size.height * 0.05)
      ..quadraticBezierTo(
        size.width * 0.1, size.height * 0.02,
        size.width * 0.05, size.height * 0.05
      )
      ..lineTo(size.width * 0.05, size.height * 0.85)
      ..quadraticBezierTo(
        size.width * 0.05, size.height * 0.95,
        size.width * 0.15, size.height * 0.98
      )
      ..lineTo(size.width * 0.85, size.height * 0.98)
      ..quadraticBezierTo(
        size.width * 0.95, size.height * 0.95,
        size.width * 0.95, size.height * 0.85
      )
      ..lineTo(size.width * 0.95, size.height * 0.05)
      ..quadraticBezierTo(
        size.width * 0.9, size.height * 0.02,
        size.width * 0.85, size.height * 0.05
      )
      ..close();
    
    // Draw glass background
    canvas.drawPath(glassPath, glassPaint);
    canvas.drawPath(glassPath, glassStrokePaint);
    
    // Draw water with realistic effect
    if (fillPercentage > 0) {
      final waterHeight = size.height * 0.88 * fillPercentage;
      final waterY = size.height * 0.98 - waterHeight;
      
      // Water path with wave effect
      final waterPath = Path();
      final waveHeight = 4.0;
      final waveFrequency = 3.0;
      
      waterPath.moveTo(size.width * 0.05, size.height * 0.98);
      waterPath.lineTo(size.width * 0.05, waterY);
      
      // Create wave effect
      for (double x = size.width * 0.05; x <= size.width * 0.95; x += 2) {
        final normalizedX = (x - size.width * 0.05) / (size.width * 0.9);
        final waveY = waterY - waveHeight * 
            (0.5 + 0.5 * sin(waveFrequency * 2 * pi * normalizedX + bubbleAnimation * 2 * pi));
        waterPath.lineTo(x, waveY);
      }
      
      waterPath.lineTo(size.width * 0.95, size.height * 0.98);
      waterPath.close();
      
      canvas.drawPath(waterPath, waterPaint);
      
      // Draw bubbles
      if (fillPercentage > 0.2) {
        _drawBubbles(canvas, size, waterY, waterHeight, bubblePaint);
      }
    }
    
    // Draw glass highlights and reflections
    _drawGlassHighlights(canvas, size);
  }
  
  void _drawBubbles(Canvas canvas, Size size, double waterY, double waterHeight, Paint bubblePaint) {
    final bubbleCount = 5;
    for (int i = 0; i < bubbleCount; i++) {
      final bubbleX = size.width * (0.2 + 0.6 * (i / bubbleCount));
      final bubbleY = waterY + waterHeight * (0.1 + 0.8 * (i / bubbleCount)) - 
          (bubbleAnimation * waterHeight * 0.8);
      
      if (bubbleY > waterY && bubbleY < waterY + waterHeight) {
        final bubbleSize = 2.0 + 3.0 * (i / bubbleCount);
        canvas.drawCircle(
          Offset(bubbleX, bubbleY),
          bubbleSize,
          bubblePaint,
        );
      }
    }
  }
  
  void _drawGlassHighlights(Canvas canvas, Size size) {
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    
    // Main highlight
    canvas.drawLine(
      Offset(size.width * 0.25, size.height * 0.15),
      Offset(size.width * 0.25, size.height * 0.75),
      highlightPaint,
    );
    
    // Secondary highlight
    final secondaryHighlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    
    canvas.drawLine(
      Offset(size.width * 0.35, size.height * 0.1),
      Offset(size.width * 0.35, size.height * 0.6),
      secondaryHighlightPaint,
    );
    
    // Rim highlight
    final rimPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.15, size.height * 0.05)
        ..quadraticBezierTo(
          size.width * 0.1, size.height * 0.02,
          size.width * 0.05, size.height * 0.05
        ),
      rimPaint,
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
