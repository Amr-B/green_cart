import 'package:flutter/material.dart';
import 'package:green_cart/features/categories/all_categoreis.dart';
import 'package:green_cart/config/animations/animations.dart';

class KSeeAllCategories extends StatelessWidget {
  const KSeeAllCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Categoreis',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              CustomPageRoute(child: AllCategoriesScreen()),
            );
          },
          child: Text(
            'See All',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
