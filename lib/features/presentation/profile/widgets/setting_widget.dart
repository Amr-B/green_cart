// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:green_cart/config/themes/colors.dart';

class KSettingWidget extends StatelessWidget {
  const KSettingWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: KColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                icon,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: KColors.dGreen,
                fontSize: 20,
              ),
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: KColors.primary.withOpacity(0.4),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                Icons.chevron_right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
