import 'package:flutter/material.dart';

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
          onPressed: () {},
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
