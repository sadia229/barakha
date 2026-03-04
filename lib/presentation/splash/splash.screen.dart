import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../infrastructure/theme/app.colors.dart';
import '../../infrastructure/navigation/config/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    // Add listener to navigate after animation completes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Add a small delay before navigation for better UX
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            context.go(RouteNames.onboarding);
          }
        });
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBar,
      body: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            );
          },
          child: Image.asset(
            'assets/logo/logo.png',
            color: Colors.white,
            height: 220,
          ),
        ),
      ),
    );
  }
}
