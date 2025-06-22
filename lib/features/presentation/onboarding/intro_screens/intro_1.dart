import 'package:flutter/material.dart';
import 'package:green_cart/config/themes/colors.dart';
import 'package:green_cart/config/strings/images.dart';
import 'package:green_cart/config/strings/texts.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KColors.background,
      child: Column(
        children: [
          // > skip button

          // > image
          Image.asset(KImages.onboarding1),

          // > headline
          Text(
            KText.onBoarding1HeadLine,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: KColors.primary,
            ),
          ),
          SizedBox(height: 17),

          // > subtitle
          Text(
            KText.onBoardin1Sub,
            style: TextStyle(
              fontSize: 16,
              color: KColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
