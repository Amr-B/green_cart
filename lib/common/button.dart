import 'package:flutter/material.dart';
import 'package:green_cart/features/utils/colors.dart';

class KButton extends StatelessWidget {
  const KButton(
      {super.key,
      required this.screenHeight,
      required this.title,
      required this.onTap});

  final double screenHeight;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.09,
        decoration: BoxDecoration(
          color: KColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
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
