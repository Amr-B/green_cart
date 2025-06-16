import 'package:flutter/material.dart';

class PaymentItem extends StatelessWidget {
  const PaymentItem({
    super.key,
    required this.price,
    required this.title,
  });
  final String price;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: 17,
          ),
        )
      ],
    );
  }
}
