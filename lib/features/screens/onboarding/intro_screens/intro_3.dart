import 'package:flutter/material.dart';
import 'package:green_cart/features/utils/texts.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: KColors.background,
      child: Column(
        children: [
          // > image
          Image.asset(KImages.onboarding3),

          // > headline
          Text(
            KText.onBoarding3HeadLine,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: KColors.primary,
            ),
          ),
          SizedBox(height: 17),

          // > subtitle
          Text(
            KText.onBoardin3Sub,
            style: TextStyle(
              fontSize: 16,
              color: KColors.primary,
            ),
          ),

          Text(
            KText.onBoardin3Sub2,
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
