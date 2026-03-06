import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:ramadan/infrastructure/theme/app.colors.dart';
import 'package:ramadan/presentation/shared/cards/category_card.dart';
import 'package:ramadan/presentation/shared/headers/app.header.dart';
import '../../infrastructure/navigation/config/route_names.dart';
import '../shared/cards/current_prayer_time_card.dart';
import '../shared/widgets/iftar_countdown.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.tealLighter.withOpacity(0.5),
                        child: const Icon(
                          CupertinoIcons.person,
                          size: 22,
                          color: AppColors.richGold,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // ✅ IMPORTANT FIX
                      const Expanded(
                        child: VerticalAutoScrollText(),
                      ),

                      const SizedBox(width: 12),

                      CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.tealLighter.withOpacity(0.5),
                        child: Image.asset(
                          'assets/images/notification.png',
                          height: 22,
                          color: AppColors.richGold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 20.0),
              ),
              const SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: CurrentPrayerTimeCard()),
                    SizedBox(width: 8.0),
                    Expanded(child: CurrentPrayerTimeCard()),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 20.0),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    const AppHeader(text: 'Ifter Time CountDown'),
                    const SizedBox(width: 12.0),
                    Image.asset(
                      'assets/images/iftar.png',
                      height: 24,
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 16.0),
              ),
              const SliverToBoxAdapter(
                child: IftarCountdown(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 20.0),
              ),
              // const SliverToBoxAdapter(
              //   child: AppHeader(text: 'Categories'),
              // ),
              // const SliverToBoxAdapter(
              //   child: SizedBox(height: 12.0),
              // ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CategoryCard(
                        image: 'assets/images/dua.png',
                        title: 'Dua',
                        onTap: () {
                          context.go(RouteNames.dua);
                        },
                      ),
                      const SizedBox(width: 16.0),
                      CategoryCard(
                        image: 'assets/images/quran-cat.png',
                        title: 'Quran',
                        onTap: () {
                          context.go(RouteNames.quran);
                        },
                      ),
                      const SizedBox(width: 16.0),
                      CategoryCard(
                        image: 'assets/images/tasbih.png',
                        title: 'Tasbih',
                        onTap: () {
                          context.go(RouteNames.tasbih);
                        },
                      ),
                      const SizedBox(width: 16.0),
                      CategoryCard(
                        image: 'assets/images/faith-in-allah.png',
                        title: 'Allah Name',
                        onTap: () {
                          context.go(RouteNames.allahName);
                        },
                      ),
                      const SizedBox(width: 16.0),
                      CategoryCard(
                        image: 'assets/images/leaf.png',
                        title: 'Track Imaan',
                        onTap: () {
                          context.go(RouteNames.trackImaan);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 24.0),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Track Your Imaan',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.pureWhite.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Monitor your daily spiritual progress and build lasting habits',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.pureWhite.withOpacity(0.8),
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              context.go(RouteNames.trackImaan);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.textSecondary.withOpacity(0.3),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: AppColors.richGold.withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Start Tracking',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.richGold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Lottie.asset(
                          'assets/images/Animated-plant-loader.json',
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.width * 0.35,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 40.0),
              ),
              // SliverAppBar.medium(
              //   backgroundColor: Colors.transparent,
              //   pinned: true,
              //   floating: false,
              //   snap: false,
              //   flexibleSpace: FlexibleSpaceBar(
              //     collapseMode: CollapseMode.pin,
              //     titlePadding: const EdgeInsets.only(left: 20, bottom: 20),
              //     title: Row(
              //       children: [
              //         Text.rich(
              //           TextSpan(
              //             children: [
              //               TextSpan(
              //                 text: "Assalamualikum\n",
              //                 style: TextStyle(
              //                   fontSize: 14,
              //                   color: Colors.white.withOpacity(0.9),
              //                 ),
              //               ),
              //               TextSpan(
              //                 text: "Sadia",
              //                 style: TextStyle(
              //                   fontSize: 18,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.white.withOpacity(0.9),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //     background: Stack(
              //       fit: StackFit.expand,
              //       children: [
              //         Image.asset(
              //           'assets/images/home-banner.png',
              //           fit: BoxFit.cover,
              //         ),
              //         Container(
              //           color: Colors.black.withOpacity(0.2),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // SliverFillRemaining(
              //   child: Image.asset('assets/images/home-banner.png'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class VerticalAutoScrollText extends StatefulWidget {
  const VerticalAutoScrollText({super.key});

  @override
  State<VerticalAutoScrollText> createState() => _VerticalAutoScrollTextState();
}

class _VerticalAutoScrollTextState extends State<VerticalAutoScrollText> {
  final ScrollController _controller = ScrollController();
  late Timer _timer;
  late List<String> messages;

  String getTodayDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, MMMM d').format(now);
  }

  final double itemHeight = 40;

  @override
  void initState() {
    super.initState();
    messages = [
      "Salaam, Sadia",
      getTodayDate(),
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      startAutoScroll();
    });
  }

  void startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      if (_controller.hasClients) {
        _controller.jumpTo(_controller.offset + 1);

        // 🔥 When half of duplicated list is reached, reset smoothly
        if (_controller.offset >= itemHeight * messages.length) {
          _controller.jumpTo(0);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight,
      child: ListView.builder(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: messages.length * 2, // 🔥 duplicate list
        itemBuilder: (context, index) {
          final message = messages[index % messages.length];

          return SizedBox(
            height: itemHeight,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
