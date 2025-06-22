import 'package:flutter/material.dart';
import 'package:green_cart/config/themes/colors.dart';

class KTotalAmount extends StatelessWidget {
  const KTotalAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total Amount',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Text(
          '10.99',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: KColors.secondary,
          ),
        ),
      ],
    );
  }
}
