import 'package:flutter/material.dart';
import 'package:green_cart/features/utils/colors.dart';

class KLoginButton extends StatelessWidget {
  const KLoginButton({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.09,
        decoration: BoxDecoration(
          color: KColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
