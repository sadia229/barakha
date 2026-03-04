import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../infrastructure/navigation/config/route_names.dart';
import '../../infrastructure/theme/app.colors.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.appBar,
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white.withOpacity(0.7),
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
          color: Colors.white,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        items: [
          // BottomNavigationBarItem(
          //   icon: Image.asset(
          //     'assets/images/quran.png',
          //     width: 32,
          //     height: 32,
          //     color: Colors.white.withOpacity(0.8),
          //   ),
          //   label: 'Quran',
          // ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/prayer.png',
              width: 32,
              height: 32,
              color: Colors.white.withOpacity(0.8),
            ),
            label: 'Prayer',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/sura.png',
              width: 32,
              height: 32,
              color: Colors.white.withOpacity(0.8),
            ),
            label: 'Sura',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/mosque.png',
              width: 32,
              height: 32,
              color: Colors.white.withOpacity(0.7),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/speak.png',
              width: 28,
              height: 28,
              color: Colors.white.withOpacity(0.7),
            ),
            label: 'Self Talk',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/fasting.png',
              width: 32,
              height: 32,
              color: Colors.white.withOpacity(0.7),
            ),
            label: 'Fasting',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    // Order matches bottom nav items (0-4)
    if (location.startsWith('/prayer')) return 0;
    if (location.startsWith('/sura')) return 1;
    if (location == RouteNames.home) return 2; // Center
    if (location.startsWith('/selfTalk')) return 3;
    if (location.startsWith('/trackFasting')) return 4;

    return 2; // Default to Home (center)
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(RouteNames.prayer);
        break;
      case 1:
        context.go(RouteNames.sura);
        break;
      case 2:
        context.go(RouteNames.home);
        break;
      case 3:
        context.go(RouteNames.selfTalk);
        break;
      case 4:
        context.go(RouteNames.trackFasting);
        break;
    }
  }
}
