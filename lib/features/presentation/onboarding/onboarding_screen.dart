// ignore_for_file: prefer_final_fields, unused_local_variable

import 'package:flutter/material.dart';
import 'package:green_cart/features/presentation/onboarding/intro_screens/intro_2.dart';
import 'package:green_cart/features/presentation/onboarding/intro_screens/intro_3.dart';
import 'package:green_cart/features/presentation/onboarding/widgets/next_onboarding_button.dart';
import 'package:green_cart/features/utils/colors.dart';
import 'package:green_cart/features/utils/responsive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'intro_screens/intro_1.dart';
import 'widgets/skip_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // > controller
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Responsive.screenHeight(context);
    final double screenWidth = Responsive.screenWidth(context);
    return Scaffold(
      backgroundColor: KColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              // Skip Button
              KSkipOnButton(controller: _controller),
              // PageView takes remaining space
              Expanded(
                child: PageView(
                  controller: _controller,
                  children: [IntroPage1(), IntroPage2(), IntroPage3()],
                ),
              ),
            ],
          ),
          // Indicator and next button
          Container(
            alignment: Alignment(0, 0.9),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    effect: WormEffect(
                      dotHeight: 5,
                      dotWidth: 12,
                      activeDotColor: KColors.primary,
                    ),
                    controller: _controller,
                    count: 3,
                  ),
                  KNextOnButton(controller: _controller),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
