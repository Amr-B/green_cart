import 'package:flutter/material.dart';
import 'package:green_cart/config/themes/colors.dart';

class QuantityController extends StatelessWidget {
  final int count;
  final ValueChanged<int> onChanged;

  const QuantityController({
    super.key,
    required this.count,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (count > 1) onChanged(count - 1);
          },
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: KColors.secondary),
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
          onTap: () => onChanged(count + 1),
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
