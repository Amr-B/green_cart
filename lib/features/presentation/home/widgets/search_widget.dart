import 'package:flutter/material.dart';
import 'package:green_cart/config/responsive/responsive.dart';

class KSearchWidget extends StatelessWidget {
  const KSearchWidget({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = Responsive.screenWidth(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: screenWidth * 0.85,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFF1c5d47),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.search, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Search Groceries',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
