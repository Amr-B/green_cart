import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/texts.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KColors.background,
      child: Column(
        children: [
          // > skip button

          // > image
          Image.asset(KImages.onboarding2),

          // > headline
          Text(
            KText.onBoarding2HeadLine,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: KColors.primary,
            ),
          ),
          SizedBox(height: 17),

          // > subtitle
          Text(
            KText.onBoardin2Sub,
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
