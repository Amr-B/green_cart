import 'package:flutter/material.dart';
import 'package:green_cart/config/themes/colors.dart';

class ProductCount extends StatelessWidget {
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ProductCount({
    super.key,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onDecrement,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: KColors.primary.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.remove, size: 16),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '$count',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: onIncrement,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: KColors.secondary,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.add, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
