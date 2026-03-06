
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ramadan/presentation/auth/social_login.screen.dart';
import 'package:ramadan/presentation/chat/chat.screen.dart';
import 'package:ramadan/presentation/dua/dua.screen.dart';
import 'package:ramadan/presentation/fasting_diet/fasting_diet.screen.dart';
import 'package:ramadan/presentation/hadith/hadith.screen.dart';
import 'package:ramadan/presentation/home/main_scaffold.screen.dart';
import 'package:ramadan/presentation/no_internet/no_internet.screen.dart';
import 'package:ramadan/presentation/onboarding/onboarding.screen.dart';
import 'package:ramadan/presentation/prayer/prayer.screen.dart';
import 'package:ramadan/presentation/self_talk/self_talk.screen.dart';
import 'package:ramadan/presentation/splash/splash.screen.dart';
import 'package:ramadan/presentation/sura/sura.screen.dart';
import 'package:ramadan/presentation/tasbih/tasbih.screen.dart';
import 'package:ramadan/presentation/track_fasting/track_fasting.screen.dart';
import 'package:ramadan/presentation/track_imaan/track_imaan.screen.dart';

import '../../../presentation/allah_name/allah_name.screen.dart';
import '../../../presentation/home/home.screen.dart';
import 'route_names.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true, // Remove in production

    // ============ ERROR HANDLING ============
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: ${state.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),

    routes: [
      // ============ STANDALONE ROUTES (Outside bottom nav) ============
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),

      GoRoute(
        path: RouteNames.onboarding,
        name: 'onboarding',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),

      GoRoute(
        path: RouteNames.allahName,
        name: 'allahName',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const AllahNameScreen(),
        ),
      ),

      GoRoute(
        path: RouteNames.socialLogin,
        name: 'socialLogin',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SocialLoginScreen(),
        ),
      ),

      GoRoute(
        path: RouteNames.noInternet,
        name: 'noInternet',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const NoInternetScreen(),
        ),
      ),

      GoRoute(
        path: RouteNames.chat,
        name: 'chat',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ChatScreen(),
        ),
      ),

      // ============ MAIN APP WITH BOTTOM NAVIGATION ============
      ShellRoute(
        builder: (context, state, child) {
          return MainScaffold(child: child);
        },
        routes: [
          // HOME TAB
          GoRoute(
            path: RouteNames.home,
            name: 'home',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomeScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const curve = Curves.easeInOutCubic;
                final scaleTween = Tween(begin: 0.95, end: 1.0);
                final opacityTween = Tween(begin: 0.0, end: 1.0);

                return FadeTransition(
                  opacity: animation.drive(opacityTween.chain(CurveTween(curve: curve))),
                  child: ScaleTransition(
                    scale: animation.drive(scaleTween.chain(CurveTween(curve: curve))),
                    child: child,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 250),
            ),
          ),

          // QURAN TAB
          GoRoute(
            path: RouteNames.prayer,
            name: 'prayer',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const PrayerScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const curve = Curves.easeInOutCubic;
                final scaleTween = Tween(begin: 0.95, end: 1.0);
                final opacityTween = Tween(begin: 0.0, end: 1.0);

                return FadeTransition(
                  opacity: animation.drive(opacityTween.chain(CurveTween(curve: curve))),
                  child: ScaleTransition(
                    scale: animation.drive(scaleTween.chain(CurveTween(curve: curve))),
                    child: child,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 250),
            ),
          ),

          // SURA TAB
          GoRoute(
            path: RouteNames.sura,
            name: 'sura',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const SuraScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const curve = Curves.easeInOutCubic;
                final scaleTween = Tween(begin: 0.95, end: 1.0);
                final opacityTween = Tween(begin: 0.0, end: 1.0);

                return FadeTransition(
                  opacity: animation.drive(opacityTween.chain(CurveTween(curve: curve))),
                  child: ScaleTransition(
                    scale: animation.drive(scaleTween.chain(CurveTween(curve: curve))),
                    child: child,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 250),
            ),
          ),

          // SELF TALK TAB
          GoRoute(
            path: RouteNames.selfTalk,
            name: 'selfTalk',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const SelfTalkScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const curve = Curves.easeInOutCubic;
                final scaleTween = Tween(begin: 0.95, end: 1.0);
                final opacityTween = Tween(begin: 0.0, end: 1.0);

                return FadeTransition(
                  opacity: animation.drive(opacityTween.chain(CurveTween(curve: curve))),
                  child: ScaleTransition(
                    scale: animation.drive(scaleTween.chain(CurveTween(curve: curve))),
                    child: child,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 250),
            ),
          ),

          // TRACK FASTING TAB
          GoRoute(
            path: RouteNames.trackFasting,
            name: 'trackFasting',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const TrackFastingScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const curve = Curves.easeInOutCubic;
                final scaleTween = Tween(begin: 0.95, end: 1.0);
                final opacityTween = Tween(begin: 0.0, end: 1.0);

                return FadeTransition(
                  opacity: animation.drive(opacityTween.chain(CurveTween(curve: curve))),
                  child: ScaleTransition(
                    scale: animation.drive(scaleTween.chain(CurveTween(curve: curve))),
                    child: child,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 250),
            ),
          ),
        ],
      ),

      // ============ OTHER STANDALONE SCREENS ============
      // These screens will open WITHOUT bottom navigation

      GoRoute(
        path: RouteNames.dua,
        name: 'dua',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const DuaScreen(),
        ),
      ),

      GoRoute(
        path: RouteNames.fastingDiet,
        name: 'fastingDiet',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const FastingDietScreen(),
        ),
      ),

      GoRoute(
        path: RouteNames.hadith,
        name: 'hadith',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HadithScreen(),
        ),
      ),

      GoRoute(
        path: RouteNames.tasbih,
        name: 'tasbih',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const TasbihScreen(),
        ),
      ),

      GoRoute(
        path: RouteNames.trackImaan,
        name: 'trackImaan',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const TrackImaanScreen(),
        ),
      ),
    ],
  );
});

// // ============ AUTH STATE PROVIDER ============
// final authStateProvider = StreamProvider<bool>((ref) async* {
//   // Replace with your actual auth logic
//   final prefs = await SharedPreferences.getInstance();
//   yield prefs.getBool('isLoggedIn') ?? false;
//
//   // If using Firebase Auth:
//   // final auth = FirebaseAuth.instance;
//   // yield* auth.authStateChanges().map((user) => user != null);
// });
//
// // ============ ONBOARDING STATE PROVIDER ============
// final onboardingCompletedProvider = FutureProvider<bool>((ref) async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getBool('hasSeenOnboarding') ?? false;
// });
