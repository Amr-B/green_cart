import 'package:flutter/material.dart';

class KCategoryContainer extends StatelessWidget {
  const KCategoryContainer({
    super.key,
    required this.screenHeight,
    required this.title,
    required this.itemsCount,
    required this.image,
    required this.color,
    this.right,
    this.bottom,
    this.imageHeight,
  });

  final double screenHeight;
  final String title;
  final String itemsCount;
  final String image;
  final Color color;
  final double? right;
  final double? bottom;
  final double? imageHeight;

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
          right: right,
          bottom: bottom,
          child: Image.asset(
            image,
            height: imageHeight,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
