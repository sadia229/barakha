import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../infrastructure/theme/app.colors.dart';
import '../../infrastructure/navigation/config/route_names.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late AnimationController _buttonController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Welcome to Ramadan Companion',
      'subtitle': 'Your spiritual guide for a blessed Ramadan journey',
      'icon': 'mosque',
      'description': 'Begin your spiritual journey with comprehensive tools for a meaningful Ramadan',
    },
    {
      'title': 'Prayer & Quran',
      'subtitle': 'Stay connected with your faith',
      'icon': 'quran',
      'description': 'Accurate prayer times, Quran reading, and spiritual guidance at your fingertips',
    },
    {
      'title': 'Track Your Progress',
      'subtitle': 'Monitor your spiritual growth',
      'icon': 'progress',
      'description': 'Track fasting, prayers, and good deeds throughout the holy month',
    },
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations
    _animationController.forward();
    
    // Start button animation after content appears
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        _buttonController.forward();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBar,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => context.go(RouteNames.home),
                    child: Text(
                      'Skip',
                      style: GoogleFonts.poppins(
                        color: AppColors.pureWhite.withOpacity(0.7),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // PageView for onboarding screens
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(index);
                },
              ),
            ),
            
            // Dot indicators and navigation
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Dot indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                      (index) => _buildDotIndicator(index),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Navigation buttons
                  Row(
                    children: [
                      // Previous button (hidden on first page)
                      if (_currentPage > 0)
                        Expanded(
                          child: AnimatedBuilder(
                            animation: _buttonController,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _buttonController.value,
                                child: Opacity(
                                  opacity: _buttonController.value,
                                  child: child,
                                ),
                              );
                            },
                            child: OutlinedButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.richGold,
                                side: const BorderSide(color: AppColors.richGold),
                                minimumSize: const Size(double.infinity, 56),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              ),
                              child: Text(
                                'Previous',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      
                      if (_currentPage > 0) const SizedBox(width: 16),
                      
                      // Next/Get Started button
                      Expanded(
                        child: AnimatedBuilder(
                          animation: _buttonController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _buttonController.value,
                              child: Opacity(
                                opacity: _buttonController.value,
                                child: child,
                              ),
                            );
                          },
                          child: ElevatedButton(
                            onPressed: () {
                              if (_currentPage < _onboardingData.length - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                context.go(RouteNames.home);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.richGold,
                              foregroundColor: AppColors.pureWhite,
                              minimumSize: const Size(double.infinity, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 8,
                              shadowColor: AppColors.richGold.withOpacity(0.3),
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _currentPage < _onboardingData.length - 1 ? 'Next' : 'Get Started',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                if (_currentPage < _onboardingData.length - 1) ...[
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward_rounded, size: 20),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(int index) {
    final data = _onboardingData[index];
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo or icon with animation
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Opacity(
                  opacity: _fadeAnimation.value,
                  child: child,
                ),
              );
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.richGold.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: AppColors.richGold.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  _getIconForPage(data['icon']!),
                  size: 100,
                  color: AppColors.richGold,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Title with slide animation
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return SlideTransition(
                position: _slideAnimation,
                child: Opacity(
                  opacity: _fadeAnimation.value,
                  child: child,
                ),
              );
            },
            child: Text(
              data['title']!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.pureWhite,
                letterSpacing: -0.5,
                height: 1.2,
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Subtitle with slide animation
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return SlideTransition(
                position: _slideAnimation,
                child: Opacity(
                  opacity: _fadeAnimation.value,
                  child: child,
                ),
              );
            },
            child: Text(
              data['subtitle']!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: AppColors.pureWhite.withOpacity(0.8),
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Description with fade animation
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: child,
              );
            },
            child: Text(
              data['description']!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.pureWhite.withOpacity(0.6),
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDotIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? AppColors.richGold
            : AppColors.pureWhite.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  IconData _getIconForPage(String iconType) {
    switch (iconType) {
      case 'mosque':
        return Icons.mosque_rounded;
      case 'quran':
        return Icons.menu_book_rounded;
      case 'progress':
        return Icons.trending_up_rounded;
      default:
        return Icons.star_rounded;
    }
  }
}
