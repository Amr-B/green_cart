import 'package:flutter/material.dart';

class KIconButton extends StatelessWidget {
  const KIconButton({
    super.key,
    required this.finalTotal,
    required this.image,
    this.onTap,
  });

  final double finalTotal;
  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            child: Image.asset(
              image,
              scale: 20,
            ),
          ),
        ],
      ),
    );
  }
}
