import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ramadan/infrastructure/theme/app.colors.dart';
import 'package:ramadan/presentation/shared/loaders/app_loader.dart';
import 'package:ramadan/presentation/sura/providers/sura_provider.dart';
import 'package:ramadan/presentation/sura/widgets/sura_list.dart';
import '../shared/errors/app_error.dart';

part 'widgets/_sura_appbar.dart';

class SuraScreen extends ConsumerStatefulWidget {
  const SuraScreen({super.key});

  @override
  ConsumerState<SuraScreen> createState() => _SuraScreenState();
}

class _SuraScreenState extends ConsumerState<SuraScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final suraAsync = ref.watch(suraProvider);
    final now = DateTime.now();
    final todayDate = DateFormat('EEEE, MMMM d, y').format(now);

    return Scaffold(
      backgroundColor: AppColors.appBar,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              _SuraAppBar(
                todayDate: todayDate,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: suraAsync.when(
                    loading: () => const AppLoader(),
                    error: (error, stack) => const AppError(),
                    data: (suraList) {
                      debugPrint("Sura list in screen: $suraList");
                      return RefreshIndicator(
                        onRefresh: () async {
                          HapticFeedback.lightImpact();
                          ref.refresh(suraProvider);
                        },
                        color: AppColors.deepTeal,
                        child: Column(
                          children: [
                            //SuraHeader(suraCount: suraList.length),
                            Expanded(
                              child: SuraList(suraList: suraList),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
