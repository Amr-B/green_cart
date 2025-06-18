// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:green_cart/features/screens/cart/widgets/qnt_controller.dart';

class CartItemCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String weight;
  final int count;
  final Function(int) onCountChanged;

  const CartItemCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.weight,
    required this.count,
    required this.onCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(2, 3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(price),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(weight),
              const SizedBox(height: 30),
              QuantityController(
                count: count,
                onChanged: onCountChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
