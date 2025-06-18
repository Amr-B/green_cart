import 'package:flutter/material.dart';

class KCategoryContainer extends StatelessWidget {
  const KCategoryContainer({
    super.key,
    required this.screenHeight,
    required this.title,
    required this.itemsCount,
    required this.image,
    required this.color,
  });

  final double screenHeight;
  final String title;
  final String itemsCount;
  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: screenHeight * 0.13,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "$itemsCount Items",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: -40,
          bottom: -40,
          child: Image.asset(
            image,
            height: screenHeight * 0.22,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
