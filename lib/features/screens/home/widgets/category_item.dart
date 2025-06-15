import 'package:flutter/material.dart';

class KCircularCategoryItem extends StatelessWidget {
  const KCircularCategoryItem({
    super.key,
    required this.title,
    required this.image,
    this.onTap,
  });

  final String title;
  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: ClipOval(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(title)
        ],
      ),
    );
  }
}
