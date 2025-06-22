import 'package:flutter/material.dart';
import 'package:green_cart/features/utils/images.dart';

class PriceRate extends StatelessWidget {
  final double price;

  const PriceRate({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              price.toString(),
              style: const TextStyle(fontSize: 25),
            ),
            const Text("/kg", style: TextStyle(color: Colors.grey)),
          ],
        ),
        Row(
          children: [
            Image.asset(KImages.starIcon, height: 27),
            const SizedBox(width: 8),
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                "4.5 (2.3K)",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        )
      ],
    );
  }
}
