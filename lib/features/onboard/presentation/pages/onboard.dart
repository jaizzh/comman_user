import 'package:common_user/app_colors.dart';
import 'package:common_user/features/auth/presentation/pages/choose_auth.dart';
import 'package:common_user/features/onboard/presentation/widgets/onboard1.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/onboard2.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  final _pageController = PageController();
  final _pages = [
    Onboard1(
      title: "Welcome to Mangal Mall",
      subtitle:
          "Plan, manage, and celebrate every occasion in one place. From invitations to shopping, Mangal Mall makes your journey effortless.",
      icon: "assets/json/welcome.json",
    ),
    Onboard2(
      title: "Your Event, Your Experience",
      subtitle:
          "View event details, select food preferences, share photos & videos, and watch live broadcasts — all from your phone.",
      icon: "assets/json/event1.json",
    ),
    Onboard1(
      title: "Plan Like a Pro",
      subtitle:
          "Create events, manage vendors & venues, track budgets, and build e-invitations. All the tools you need to host unforgettable events.",
      icon: "assets/json/onboard1.json",
    ),
    Onboard2(
      title: "Smart Contact & Invitation Management",
      subtitle:
          "Sync your contacts, get instant invitations, and manage your event calendar with ease. Accept, reject, or RSVP in just one tap.",
      icon: "assets/json/contact.json",
    ),
    Onboard1(
      title: "Smart Gifting & Global Mall",
      subtitle:
          "Explore curated products, send gifts or cash registries, and track deliveries to the host. Gifting has never been this simple.",
      icon: "assets/json/gifts.json",
    ),
  ];

  int _current = 0;

  bool get _isFirst => _current == 0;
  bool get _isLast => _current == _pages.length - 1;

  void _goNext() {
    if (!_isLast) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goBack() {
    if (!_isFirst) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipToLast() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  void _getStarted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (_) => const ChooseAuth()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;

          // Responsive values
          final isSmallScreen = screenWidth < 360;
          final isTablet = screenWidth >= 600;

          // Responsive padding values
          final topPadding = isSmallScreen ? 6.0 : 8.0;
          final sidePadding = isSmallScreen ? 6.0 : 8.0;
          final bottomPadding = isSmallScreen ? 6.0 : 8.0;

          // Responsive skip button padding
          final skipTopPadding = isSmallScreen ? 8.0 : 12.0;
          final skipRightPadding = isSmallScreen ? 8.0 : 12.0;

          // Responsive indicator bottom padding
          final indicatorBottomPadding = isSmallScreen ? 16.0 : 24.0;

          // Responsive button font size
          final buttonFontSize =
              isSmallScreen ? 14.0 : (isTablet ? 18.0 : 16.0);

          // Responsive skip text font size
          final skipFontSize = isSmallScreen ? 14.0 : (isTablet ? 18.0 : 16.0);

          // Responsive icon sizes
          final iconSize = isSmallScreen ? 20.0 : (isTablet ? 28.0 : 24.0);

          // Responsive indicator sizes
          final dotHeight = isSmallScreen ? 6.0 : (isTablet ? 10.0 : 8.0);
          final dotWidth = isSmallScreen ? 6.0 : (isTablet ? 10.0 : 8.0);
          final dotSpacing = isSmallScreen ? 6.0 : (isTablet ? 10.0 : 8.0);

          // Responsive button padding
          final buttonHorizontalPadding =
              isSmallScreen ? 12.0 : (isTablet ? 20.0 : 16.0);
          final buttonVerticalPadding =
              isSmallScreen ? 8.0 : (isTablet ? 12.0 : 10.0);

          return Stack(
            children: [
              // Pages
              PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _current = i),
                children: _pages,
              ),

              // BACK (top-left) — show only from page 2 onwards
              SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: topPadding,
                      left: sidePadding,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _isFirst
                          ? const SizedBox(key: ValueKey('no-back'))
                          : IconButton(
                              key: const ValueKey('back'),
                              onPressed: _goBack,
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: iconSize, // Responsive icon size
                              ),
                            ),
                    ),
                  ),
                ),
              ),

              // SKIP (top-right) — hide on last page
              SafeArea(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: skipTopPadding, // Responsive padding
                      right: skipRightPadding, // Responsive padding
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _isLast
                          ? const SizedBox(key: ValueKey('no-skip'))
                          : GestureDetector(
                              key: const ValueKey('skip'),
                              onTap: _skipToLast,
                              child: Text(
                                'Skip',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black45,
                                  fontSize:
                                      skipFontSize, // Responsive font size
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ),

              // INDICATOR (bottom-center) — hide on last page
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: indicatorBottomPadding, // Responsive padding
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _isLast
                          ? const SizedBox(key: ValueKey('no-indicator'))
                          : SmoothPageIndicator(
                              key: const ValueKey('indicator'),
                              controller: _pageController,
                              count: _pages.length,
                              effect: ExpandingDotsEffect(
                                dotColor: Colors.white60,
                                dotHeight: dotHeight, // Responsive dot height
                                dotWidth: dotWidth, // Responsive dot width
                                expansionFactor: 3,
                                spacing: dotSpacing, // Responsive spacing
                                activeDotColor: AppColors.white,
                              ),
                              onDotClicked: (index) {
                                _pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              },
                            ),
                    ),
                  ),
                ),
              ),

              // FORWARD / GET STARTED (bottom-right)
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: bottomPadding, // Responsive padding
                      right: sidePadding, // Responsive padding
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _isLast
                          ? ElevatedButton(
                              key: const ValueKey('get-started'),
                              onPressed: _getStarted,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: AppColors.black,
                                backgroundColor: AppColors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      buttonHorizontalPadding, // Responsive padding
                                  vertical:
                                      buttonVerticalPadding, // Responsive padding
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                textStyle: TextStyle(
                                  fontSize:
                                      buttonFontSize, // Responsive font size
                                ),
                              ),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                key: const ValueKey('forward'),
                                onPressed: _goNext,
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                  size: iconSize, // Responsive icon size
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
